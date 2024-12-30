//
//  ViewControllersFactory.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 30/12/24.
//

import Foundation
import UIKit

final class ViewControllersFactory: ViewControllersFactoryProtocol {
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
}
