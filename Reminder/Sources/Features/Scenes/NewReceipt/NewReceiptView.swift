//
//  NewReceipt.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 06/01/25.
//

import Foundation
import UIKit

class NewReceiptView: UIView {
    weak var delegate: NewReceiptViewDelegate?
    
    private let backButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = Colors.gray100
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "newReceipt.title".localized
        label.textColor = Colors.primaryRedBase
        label.font = Typograph.heading
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "newReceipt.description".localized
        label.textColor = Colors.gray200
        label.numberOfLines = 0
        label.font = Typograph.body
        
        return label
    }()
    
    
    private let stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        return stackView
    }()
    
    private let medicineTextField: Input = {
        let input = Input(label: "Remédio", placeholder: "Nome do medicamento")
        return input
    }()
    
    private let timeTextField: Input = {
        let input = Input(label: "Horário", placeholder: "00:00")
        return input
    }()
    
    private let intervalTextField: Input = {
        let input = Input(label: "Recorrência", placeholder: "Selecione")
        return input
    }()
    
    private let checkbox:Checkbox = {
        let checkbox = Checkbox()
        checkbox.setTitle(title: "Tomar agora")
        return checkbox
    }()
    
    private let addButton:UIButton = {
        let button = UIButton()
        button.setTitle("+ Adicionar", for: .normal)
        button.titleLabel?.font = Typograph.subHeading
        button.backgroundColor = Colors.primaryRedBase
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        addTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(addButton)
        addSubview(stackView)
        stackView.addArrangedSubview(medicineTextField)
        stackView.addArrangedSubview(timeTextField)
        stackView.addArrangedSubview(intervalTextField)
        stackView.addArrangedSubview(checkbox)
        setupConstraints()
       
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.semiHuge),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Metrics.medium),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.semiHuge),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.semiHuge),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.tiny),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.semiHuge),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.semiHuge),
            
            stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.semiHuge),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.semiHuge),
            
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant:Metrics.semiHuge),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -Metrics.semiHuge),
            addButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -14),
            addButton.heightAnchor.constraint(equalToConstant: Metrics.buttonSize),
        ])
    }
    
    private func addTapGesture(){
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapBackButton(){
        delegate?.didTapGoBack()
    }
}
