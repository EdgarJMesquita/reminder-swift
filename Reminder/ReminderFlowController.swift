//
//  ReminderFlowController.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 30/12/24.
//

import Foundation
import UIKit

class ReminderFlowController {
    // MARK: - Properties
    private var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllersFactoryProtocol
    
    // MARK: - init
    public init(){
        self.viewControllerFactory = ViewControllersFactory()
    }
    
    // MARK: - startFlow
    func start()->UINavigationController? {
        let contentView = NewReceiptView()
        let startViewController = viewControllerFactory.makeSplashViewController(delegate: self)
        self.navigationController = UINavigationController(rootViewController: startViewController)
        return self.navigationController
    }
}

// MARK: - Login
extension ReminderFlowController: LoginBottomSheetFlowDelegate {
    func navigateToHome() {
        self.navigationController?.dismiss(animated: false)
        
        let viewController = viewControllerFactory.makeHomeViewController(delegate: self)
        
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}

// MARK: - Splash
extension ReminderFlowController: SplashFlowDelegate {
    func openLoginBottomSheet() {
        let loginBottomSheet = viewControllerFactory.makeLoginBottomSheetViewController(delegate: self)
        loginBottomSheet.modalPresentationStyle = .overCurrentContext
        loginBottomSheet.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(loginBottomSheet, animated: false) {
            loginBottomSheet.animateShow()
        }
        
        func navigateToHome() {
            self.navigationController?.dismiss(animated: false)
            let viewController = UIViewController()
            viewController.view.backgroundColor = .red
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}

// MARK: - Home
extension ReminderFlowController:HomeFlowDelegate {
    func logout() {
        self.navigationController?.popViewController(animated: true)
        self.openLoginBottomSheet()
    }
    
    func navigateToNewReceipt(){
        let viewController = viewControllerFactory.makeNewReceiptViewController(delegate: self)
        navigationController?.pushViewController(viewController, animated: true)
        navigationController?.navigationBar.isHidden = true
    }
}


extension ReminderFlowController:NewReceiptFlowDelegate {
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
