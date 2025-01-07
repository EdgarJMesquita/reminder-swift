//
//  UIImageView+Ext.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 31/12/24.
//

import Foundation
import UIKit

extension UIImageView {
    func loadRemoteImage(url:String){
        if let url = URL(string: "https://github.com/EdgarJMesquita.png"){
           URLSession.shared.dataTask(with: url) { data, _, _ in
               if let data = data, let image = UIImage(data: data){
                   DispatchQueue.main.async {
                      self.image = image
                  }
               }
           }.resume()
       }
    }
}
