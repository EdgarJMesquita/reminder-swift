//
//  ViewControllersFactoryProtocol.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 30/12/24.
//

import Foundation

protocol ViewControllersFactoryProtocol: AnyObject {
    func makeSplashViewController(delegate: SplashFlowDelegate) -> SplashViewController
    
    func makeLoginBottomSheetViewController(delegate: LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController
    
    func makeHomeViewController(delegate: HomeFlowDelegate ) -> HomeViewController
    
    func makeNewReceiptViewController(delegate: NewReceiptFlowDelegate ) ->NewReceiptViewController
    
    func makeMyReceiptViewController(delegate: MyReceiptsFlowDelegate) ->MyReceiptsViewController
}
