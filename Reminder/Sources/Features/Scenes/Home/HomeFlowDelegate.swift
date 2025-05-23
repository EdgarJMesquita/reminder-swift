//
//  HomeFlowDelegate.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 31/12/24.
//

import Foundation

public protocol HomeFlowDelegate: AnyObject {
    func logout()
    func navigateToNewReceipt()

    func navigateToMyReceipts()
}
