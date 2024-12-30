//
//  LoginBottomSheetViewController.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 28/12/24.
//

import Foundation
import UIKit

class LoginBottomSheetViewController: UIViewController {
    let contentView:LoginBottomSheetView
    let viewModel:LoginBottomSheetViewModel
    let handleAreaHeight:CGFloat = 50.0
    public weak var delegate:LoginBottomSheetFlowDelegate?

    init(contentView: LoginBottomSheetView, viewModel: LoginBottomSheetViewModel, delegate: LoginBottomSheetFlowDelegate) {
        self.delegate = delegate
        self.viewModel = viewModel
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGesture()
        contentView.delegate = self
        viewModel.delegate = self
    }
    
    private func setupUI(){
        self.view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        contentView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    private func setupGesture(){
        
    }
    
    private func handlePanGesture(){
        
    }
    
    func animateShow(completion: (()->Void)?=nil){
        self.view.layoutIfNeeded()
        contentView.transform = CGAffineTransform(translationX: 0, y: contentView.frame.height)
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.transform = .identity
            self.view.layoutIfNeeded()
            
        }) { _ in
            completion?()
        }
    }
}


extension LoginBottomSheetViewController: LoginBottomSheetViewDelegate {
    func sendLoginData(user: String, password: String) {
        viewModel.doAuth(user: user, password: password)
    }
}

extension LoginBottomSheetViewController: LoginBottomSheetViewModelDelegate {
    func onLoginSuccess() {
        self.delegate?.navigateToHome()
    }
}
