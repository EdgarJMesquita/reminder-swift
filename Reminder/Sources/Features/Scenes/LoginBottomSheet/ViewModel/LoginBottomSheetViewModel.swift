//
//  LoginBottomSheetViewModel.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 29/12/24.
//

import Foundation
import Firebase

class LoginBottomSheetViewModel {
//    var user: User?
    weak var delegate:LoginBottomSheetViewModelDelegate?
    
    init (){

//        self.user = Auth.auth().currentUser
//        print(self.user ?? "No User")

//       var handle = Auth.auth().addStateDidChangeListener {[weak self] auth, user in
//           if let user = user {
//               self?.user = user
//               self?.successResult?()
//           }
//        }
        
        
    }
    
    func doAuth(user:String, password:String, completion: (() -> Void)?=nil){
        print("User:\(user)\nPassword: \(password)")
        Auth.auth().signIn(withEmail: user, password: password) { [weak self] authResult, error in
            if error != nil  {
                self?.delegate?.onLoginFailure(message: "Erro ao realizar o login, verifique as credenciais digitadas.")
            } else {
                self?.delegate?.onLoginSuccess(userNameLogin: user)
            }
            completion?()
        }
    }
}
