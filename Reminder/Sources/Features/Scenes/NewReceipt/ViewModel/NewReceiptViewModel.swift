//
//  NewReceiptViewModel.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 20/01/25.
//

import Foundation
import UserNotifications

class NewReceiptViewModel {
    func addReceipt(remedy: String, time: String, recurrence: String, takeNow: Bool) {

        var finalTime = time

        if takeNow {
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            finalTime = formatter.string(from: date)

        }

        let id = DBHelper.shared.insertReceipt(remedy: remedy, time: finalTime, recurrence: recurrence, takeNow: takeNow)

        guard let id else { return }

        scheduleNotifications(remedy: remedy, time: time, recurrence: recurrence, id: id)
    }

    private func scheduleNotifications(remedy: String, time: String, recurrence: String, id: Int) {
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()

        content.title = "Hora de tomar o remédio!"
        content.body = "Lembre-se de tomar o \(remedy)"
        content.sound = .default

        guard let interval = getIntervalIHours(from: recurrence) else {
            return
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        guard let initialDate = formatter.date(from: time) else {
            return
        }

        let calendar = Calendar.current
        let initialComponents = calendar.dateComponents([.hour, .minute], from: initialDate)

        var currentDate = initialDate

        for iterator in 00..<(24 / interval) {
            let components = calendar.dateComponents([.hour, .minute], from: currentDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            let request = UNNotificationRequest(identifier: "\(id)-\(iterator)", content: content, trigger: trigger)

            center.add(request) { error in
                if error != nil {
                    print("Erro ao agendar notificações")
                } else {
                    print("Notificação para o \(remedy) criada com sucesso")
                }
            }

            currentDate = calendar.date(byAdding: .hour, value: interval, to: currentDate) ?? Date()
        }

    }

    private func getIntervalIHours(from recurrence: String) -> Int? {
        let option = SelectOptions.recurrence.first(where: {option in option.label == recurrence})
        return option?.value
    }
}
