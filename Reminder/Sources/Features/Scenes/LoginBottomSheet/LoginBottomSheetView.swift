//
//  LoginBottomSheetView.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 28/12/24.
//

import Foundation
import UIKit

class LoginBottomSheetView: UIView {
    public weak var delegate: LoginBottomSheetViewDelegate?
    
    private let handleArea:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = Metrics.tiny
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let title:UILabel = {
        let label = UILabel()
        label.text = "login.label.title".localized
        label.font = Typograph.subHeading
        label.textColor = Colors.gray100
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelEmail:UILabel = {
        let label = UILabel()
        label.text = "login.email.label".localized
        label.font = Typograph.label
        label.textColor = Colors.gray100
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textView = UITextField()
        textView.placeholder = "login.email.placeholder".localized
        textView.borderStyle = .roundedRect
        textView.layer.cornerRadius = Metrics.tiny
        textView.layer.borderColor = Colors.gray400.cgColor
        textView.layer.borderWidth = 1
        textView.keyboardType = .emailAddress
        textView.autocapitalizationType = .none
   
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: Metrics.small, height: 20))
        textView.leftView = paddingView
        textView.leftViewMode = .always
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let eyeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        button.widthAnchor.constraint(equalToConstant: 56).isActive = true
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        return button
    }()
    
    private let labelPassword:UILabel = {
        let label = UILabel()
        label.text = "login.password.label".localized
        label.font = Typograph.label
        label.textColor = Colors.gray100
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textView = UITextField()
        textView.borderStyle = .roundedRect
        textView.layer.cornerRadius = Metrics.tiny
        textView.layer.borderColor = Colors.gray400.cgColor
        textView.layer.borderWidth = 1
        textView.isSecureTextEntry = true
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: Metrics.small, height: 20))
        textView.leftView = paddingView
        textView.leftViewMode = .always
        
        textView.rightViewMode = .always
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let loader:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = .white
        indicator.style = .medium
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let loginButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("login.button.title".localized, for: .normal)
        button.backgroundColor = Colors.primaryRedBase
        button.layer.cornerRadius = Metrics.medium
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Typograph.subHeading
        button.translatesAutoresizingMaskIntoConstraints = false
       
        button.setTitle("", for: .disabled)
        return button
    }()
    
    
    override init(frame:CGRect){
        super.init(frame: frame)
        setupUI()
        setupGesture()
        
        emailTextField.text = "edgar@email.com"
        passwordTextField.text = "asdfasdf"
        
        setupDelegates()
   
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func exampleTapped(){
        print("Clicou na label")
    }
    
    private func setupDelegates(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setupUI(){
        self.backgroundColor = .white
        self.layer.cornerRadius = Metrics.small
        
        addSubview(handleArea)
        addSubview(title)
        addSubview(labelEmail)
        addSubview(emailTextField)
        addSubview(labelPassword)
        addSubview(passwordTextField)
        addSubview(loginButton)
        
        setupLoader()
        setupConstraints()
    }
    
    private func setupGesture(){
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        passwordTextField.rightView = eyeButton
        let exampleGesture = UITapGestureRecognizer(target: self, action: #selector(exampleTapped))
        title.addGestureRecognizer(exampleGesture)
        
        loginButton.addTarget(self, action: #selector(loginButtonDidTapped), for: .touchUpInside)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            handleArea.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.small),
            handleArea.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            handleArea.widthAnchor.constraint(equalToConstant: 40),
            handleArea.heightAnchor.constraint(equalToConstant: 6),
            
            title.topAnchor.constraint(equalTo: handleArea.bottomAnchor, constant: Metrics.medium),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.semiHuge),
            
            labelEmail.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: Metrics.huge),
            labelEmail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.semiHuge),
            
            emailTextField.topAnchor.constraint(equalTo: self.labelEmail.bottomAnchor, constant: Metrics.small),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.semiHuge),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.semiHuge),
            emailTextField.heightAnchor.constraint(equalToConstant: Metrics.inputSize),
    
            labelPassword.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: Metrics.medium),
            labelPassword.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.semiHuge),
            
            passwordTextField.topAnchor.constraint(equalTo: self.labelPassword.bottomAnchor, constant: Metrics.small),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.semiHuge),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.semiHuge),
            passwordTextField.heightAnchor.constraint(equalToConstant: Metrics.inputSize),
            
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.semiHuge),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.semiHuge),
            loginButton.heightAnchor.constraint(equalToConstant: Metrics.buttonSize),
            loginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Metrics.huge)
        ])
    }
    
    private func setupLoader(){
        loginButton.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: self.loginButton.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: self.loginButton.centerYAnchor)
        ])
       
    }
    
    private func showLoader(){
        loader.startAnimating()
        loginButton.imageView?.alpha = 0
        loginButton.isEnabled = false
    }
    
    private func hideLoader(){
        loader.stopAnimating()
        loginButton.imageView?.alpha = 1
        loginButton.isEnabled = true
        
    }
    
    @objc
    private func loginButtonDidTapped(){
        guard let user = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        self.showLoader()
        delegate?.sendLoginData(
            user: user,
            password: password,
            completion: {
                self.hideLoader()
            }
        )
    }
    
    @objc func togglePasswordVisibility(_ sender: UIButton) {
           guard let textField = sender.superview as? UITextField else { return }
           sender.isSelected.toggle()
           textField.isSecureTextEntry.toggle()
       }
 
}

extension LoginBottomSheetView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
