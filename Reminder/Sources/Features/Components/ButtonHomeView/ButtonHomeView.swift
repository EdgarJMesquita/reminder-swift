//
//  ButtonViewComponent.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 05/01/25.
//

import Foundation
import UIKit

class ButtonHomeView:UIView {
    var tapAction: (()->Void)?
    
    private let iconView:UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray600
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = Typograph.subHeading
        label.textColor = Colors.gray100
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.font = Typograph.body
        label.textColor = Colors.gray200
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.forward")
        imageView.tintColor = Colors.gray400
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    init(icon: UIImage?, title: String, description:String){
        super.init(frame: .zero)
        iconImageView.image = icon
        titleLabel.text = title
        descriptionLabel.text = description
        
        setupUI()
        setupClass()
        setupConstraints()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGesture(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(gestureRecognizer)
        isUserInteractionEnabled = true
    }
    
    @objc
    private func handleTap(){
        tapAction?()
    }
    
    private func setupClass(){
        backgroundColor = Colors.gray700
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = Colors.gray600.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 112).isActive = true
    }
    
    private func setupUI(){
        iconView.addSubview(iconImageView)
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(arrowImageView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.small),
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.small),
            iconView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metrics.small),
            iconView.widthAnchor.constraint(equalToConstant: 80),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 48),
            iconImageView.widthAnchor.constraint(equalToConstant: 48),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.small),
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: Metrics.semiMedium),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.semiMedium),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.small),
            descriptionLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: Metrics.semiMedium),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.semiMedium),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: Metrics.semiMedium),
            
            arrowImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.small),
        ])
    }
    
    
}
