//
//  LoginBottomSheetViewDelegate.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 29/12/24.
//

import Foundation
import UIKit

protocol LoginBottomSheetViewDelegate: AnyObject {
    func sendLoginData(user: String, password: String, completion: (() -> Void)?)
}
