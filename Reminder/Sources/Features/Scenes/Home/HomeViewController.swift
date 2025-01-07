//
//  HomeViewController.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 31/12/24.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    let contentView:HomeView
    weak var delegate: HomeFlowDelegate?
    
    init(contentView:HomeView, delegate: HomeFlowDelegate) {
        self.delegate = delegate
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
        self.contentView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNavigationBar()
        setupUserData()
        setupActionForNewReceipt()
    }
    
    private func setupUserData(){
        if UserDefaultsManager.loadUser() != nil {
            contentView.nameTextField.text = UserDefaultsManager.loadUserName()
            
            if let image = UserDefaultsManager.loadUserPhoto() {
                contentView.avatarView.image = image
            }
        }
    }
 

    
    private func setupNavigationBar(){
        let logoutButton = UIBarButtonItem(image: UIImage(named: "Logout"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(logoutAction)
        )
        logoutButton.tintColor = Colors.primaryRedBase
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.rightBarButtonItem = logoutButton
    }
    
    private func setupActionForNewReceipt(){
        contentView.addPrescription.tapAction = { [weak self] in
            self?.didTapAddPrescription()
        }
    }
    
    @objc
    private func logoutAction(){
        UserDefaultsManager.removeUser()
        self.delegate?.logout()
        
    }
    
    private func setup(){
        self.view.addSubview(contentView)
        self.view.backgroundColor = Colors.gray600
        buildHierarchy()
    }
    
    private func buildHierarchy(){
        self.setupContentViewToBounds(contentView: contentView)
    }
}

extension HomeViewController:HomeViewDelegate {
    func didTapAvatar() {
      
        let alertController = UIAlertController(title: "Origem da foto", message: "Selecione a origem da foto", preferredStyle: .actionSheet)
        
        let libraryAction = UIAlertAction(title: "Galeria", style: .default,handler: { _ in
            self.selectProfileImage(from: .photoLibrary)
        })
        let cameraAction = UIAlertAction(title: "Câmera", style: .default, handler: { _ in
            self.selectProfileImage(from: .camera)
        })
        let cancelAction = UIAlertAction(title: "Cancelar", style: .destructive)
        
        alertController.addAction(libraryAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
      
    }
    
    func didTapAddPrescription() {
        delegate?.navigateToNewReceipt()
    }
}


extension HomeViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func selectProfileImage(from sourceType: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            contentView.avatarView.image = editedImage
            UserDefaultsManager.saveUserPhoto(photo: editedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            contentView.avatarView.image = originalImage
            UserDefaultsManager.saveUserPhoto(photo: originalImage)
        }
        self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}
