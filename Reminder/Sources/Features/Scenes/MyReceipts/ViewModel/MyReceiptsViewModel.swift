//
//  MyReceiptsViewModel.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 22/01/25.
//

import Foundation
import UserNotifications

class MyReceiptsViewModel {
    public private(set) var receipts:[Remedy] = []
    
    func fetchReceipts() async {
        self.receipts = await DBHelper.shared.fetchReceipts()
    }
    
    func deleteReceipt(byId id: Int) {
        DBHelper.shared.deleteReceipt(byId: id)
        
        receipts.removeAll(where: { remedy in
            remedy.id == id
        })
        
        removeNotifications(byId: id)
    }
    
    private func removeNotifications(byId id: Int){
        let center = UNUserNotificationCenter.current()
        let identifiers = (0..<6).map { "\(id)-\($0)" }
        
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
        
        print("Notificações para id: \(id)")
    }
    
}
