//
//  SplashView.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 24/12/24.
//

import Foundation
import UIKit

class SplashView: UIView {
    private let logoImageView:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Logo")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
 
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    private func setupUI(){
        self.addSubview(logoImageView)

        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    func animateLogoImageView(){
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            var translate = CGAffineTransform(translationX: 0, y: -(self.frame.height / 3))
            var scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.logoImageView.transform = translate.concatenating(scale)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
