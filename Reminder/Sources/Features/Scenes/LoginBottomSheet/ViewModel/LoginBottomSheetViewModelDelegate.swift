//
//  LoginBottomViewModelDelegate.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 30/12/24.
//

import Foundation

protocol LoginBottomSheetViewModelDelegate: AnyObject {
    func onLoginSuccess(userNameLogin: String)
    func onLoginFailure(message: String)
}
