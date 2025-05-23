//
//  ButtonViewComponent.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 05/01/25.
//

import Foundation
import UIKit
import CoreFramework

class ButtonHomeView: UIView {
    var tapAction: (() -> Void)?

    private let iconView: UIView = {
        let view = UIView()
        view.backgroundColor = CFColors.gray600
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
        label.font = CFTypography.subHeading
        label.textColor = CFColors.gray100
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.font = CFTypography.body
        label.textColor = CFColors.gray200
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.forward")
        imageView.tintColor = CFColors.gray400
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    init(icon: UIImage?, title: String, description: String) {
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

    private func setupGesture() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(gestureRecognizer)
        isUserInteractionEnabled = true
    }

    @objc
    private func handleTap() {
        tapAction?()
    }

    private func setupClass() {
        backgroundColor = CFColors.gray700
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = CFColors.gray600.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 112).isActive = true
    }

    private func setupUI() {
        iconView.addSubview(iconImageView)
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(arrowImageView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CFMetrics.small),
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: CFMetrics.small),
            iconView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CFMetrics.small),
            iconView.widthAnchor.constraint(equalToConstant: 80),

            iconImageView.centerXAnchor.constraint(equalTo: iconView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 48),
            iconImageView.widthAnchor.constraint(equalToConstant: 48),

            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: CFMetrics.small),
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: CFMetrics.semiMedium),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CFMetrics.semiMedium),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: CFMetrics.small),
            descriptionLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: CFMetrics.semiMedium),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CFMetrics.semiMedium),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: CFMetrics.semiMedium),

            arrowImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CFMetrics.small)
        ])
    }

}
