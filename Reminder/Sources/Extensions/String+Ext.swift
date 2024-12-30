//
//  String+Ext.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 28/12/24.
//

import Foundation


extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
