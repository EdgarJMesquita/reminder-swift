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
  
        contentView.delegate = self
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func keyboardWillShow(notification: Notification){
        guard 
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = -keyboardHeight / 1.5
        }
    }
    
    @objc
    private func keyboardWillHide(notification: Notification){
     
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
    
    private func setupUI(){
        self.view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        contentView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
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
    
    private func presentSaveLoginAlert(userNameLogin:String){
        let alertController = UIAlertController(title: "Salvar acesso", message: "Deseja Salvar seu acesso?", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Salvar", style:.default) {_ in 
            UserDefaultsManager.saveUser(user: User(email: userNameLogin, isUserSaved: true))
            self.delegate?.navigateToHome()
        }
        
        let cancelAction = UIAlertAction(title: "Não", style:.destructive) {_ in
            UserDefaultsManager.saveUser(user: User(email: userNameLogin, isUserSaved: false))
            self.delegate?.navigateToHome()
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
        
    }
}


extension LoginBottomSheetViewController: LoginBottomSheetViewDelegate {
    func sendLoginData(user: String, password: String, completion: (() -> Void)?) {
        viewModel.doAuth(user: user, password: password, completion: completion)
    }
}

extension LoginBottomSheetViewController: LoginBottomSheetViewModelDelegate {
    func onLoginSuccess(userNameLogin:String) {
        self.presentSaveLoginAlert(userNameLogin: userNameLogin)
    }
    
    func onLoginFailure(message: String) {
        let alertController = UIAlertController(title: "Error ao logar", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}
