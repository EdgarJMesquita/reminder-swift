//
//  SelectOptions.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 23/01/25.
//

import Foundation

struct Option {
    let value: Int
    let label: String

    init(_ value: Int, _ label: String) {
        self.value = value
        self.label = label
    }
}

class SelectOptions {
    static let recurrence = [
        Option(1, "De hora em hora"),
        Option(2, "2 em 2 horas"),
        Option(4, "4 em 4 horas"),
        Option(6, "6 em 6 horas"),
        Option(8, "8 em 8 horas"),
        Option(12, "12 em 12 horas"),
        Option(24, "Um por dia")
    ]
}
