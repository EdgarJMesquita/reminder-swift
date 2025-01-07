//
//  ViewControllersFactory.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 30/12/24.
//

import Foundation
import UIKit

final class ViewControllersFactory: ViewControllersFactoryProtocol {
    func makeHomeViewController(delegate: HomeFlowDelegate) -> HomeViewController {
        let contentView = HomeView()
        let viewController = HomeViewController(contentView: contentView,delegate: delegate)
        return viewController
    }
    
    func makeSplashViewController(delegate: SplashFlowDelegate) -> SplashViewController {
        let contentView = SplashView()
        let viewController = SplashViewController(contentView: contentView,delegate: delegate)
        return viewController
    }
    
    func makeLoginBottomSheetViewController(delegate: LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController {
        let viewModel = LoginBottomSheetViewModel()
        let contentView = LoginBottomSheetView()
        let viewController = LoginBottomSheetViewController(
            contentView: contentView,
            viewModel: viewModel,
            delegate: delegate
        )
        return viewController
    }
    
    func makeNewReceiptViewController(delegate: NewReceiptFlowDelegate) -> NewReceiptViewController {
        let contentView = NewReceiptView()
        let viewController = NewReceiptViewController(
            contentView: contentView,
            delegate: delegate
        )
        return viewController
    }
}
