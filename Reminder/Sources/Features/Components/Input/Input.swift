//
//  ReminderInput.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 06/01/25.
//

import Foundation
import UIKit
import CoreFramework

class Input: UIView {
    private let labelInput: UILabel = {
        let label = UILabel()
        label.text = "login.email.label".localized
        label.font = CFTypography.label
        label.textColor = CFColors.gray100
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let textField: UITextField = {
        let textView = UITextField()
        textView.placeholder = "login.email.placeholder".localized
        textView.borderStyle = .roundedRect
        textView.layer.cornerRadius = CFMetrics.tiny
        textView.layer.borderColor = CFColors.gray400.cgColor
        textView.layer.borderWidth = 1
        textView.keyboardType = .emailAddress
        textView.autocapitalizationType = .none

        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: CFMetrics.small, height: 20))
        textView.leftView = paddingView
        textView.leftViewMode = .always

        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    init(label: String?, placeholder: String) {
        super.init(frame: .zero)
        labelInput.text = label
        textField.placeholder = placeholder
        setupUI()
        configurePlaceholder(placeholder: placeholder)
    }

    private func setupUI() {
        addSubview(labelInput)
        addSubview(textField)
        setupConstraints()

    }

    private func configurePlaceholder(placeholder: String) {
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: CFColors.gray200])
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 85),

            labelInput.topAnchor.constraint(equalTo: topAnchor),
            labelInput.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelInput.trailingAnchor.constraint(equalTo: trailingAnchor),

            textField.topAnchor.constraint(equalTo: labelInput.bottomAnchor, constant: CFMetrics.small),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: CFMetrics.inputSize)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getText() -> String {
        return textField.text ?? ""
    }

    func clear() {
        textField.text = ""
    }
}
