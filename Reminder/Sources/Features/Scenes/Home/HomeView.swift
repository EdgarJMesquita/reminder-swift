//
//  HomeView.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 31/12/24.
//

import Foundation
import UIKit
import CoreFramework

class HomeView: UIView {
    public weak var delegate: HomeViewDelegate?

    private let profileBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let contentBackground: UIView = {
        let view = UIView()
        view.backgroundColor = CFColors.gray800
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = CFMetrics.homeAvatarSize / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = CFColors.blueBase.cgColor

        imageView.isUserInteractionEnabled = true

        imageView.image = UIImage(systemName: "person.fill")

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let welcomeTitle: UILabel = {
        let label = UILabel()
        label.text = "home.welcome.message".localized
        label.font = Typograph.input
        label.textColor = CFColors.gray200
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.font = CFTypography.heading
        textField.textColor = CFColors.gray100
        textField.placeholder = "Insira seu nome"
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let feedbackButton: CFButton = {
        let button = CFButton(title: "home.welcome.button".localized,
                              icon: .star,
                              iconPosition: .leading,
                              backgroundColor: CFColors.gray100)
        return button
    }()

    let myPrescriptions: ButtonHomeView = {
        let buttonHomeView = ButtonHomeView(icon: UIImage(named: "Paper"),
                                            title: "Minhas receitas",
                                            description: "Acompanhe os medicamentos e gerencie lembretes")
        return buttonHomeView
    }()

    let addPrescription: ButtonHomeView = {
        let buttonHomeView = ButtonHomeView(icon: UIImage(named: "Medicine"),
                                            title: "Nova receita",
                                            description: "Cadastre novos lembretes de receitas")
        return buttonHomeView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        setupDelegates()
    }

    private func setupDelegates() {
        nameTextField.delegate = self
        feedbackButton.delegate = self
    }

    private func setupUI() {
        addSubview(profileBackground)
        profileBackground.addSubview(avatarView)
        profileBackground.addSubview(welcomeTitle)
        profileBackground.addSubview(nameTextField)

        contentBackground.addSubview(feedbackButton)
        contentBackground.addSubview(stackView)

        stackView.addArrangedSubview(myPrescriptions)
        stackView.addArrangedSubview(addPrescription)

        addSubview(contentBackground)

        setupConstraints()
        setupImageGesture()

    }

    private func setupImageGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapAvatar))
        avatarView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc
    private func didTapAvatar() {
        self.delegate?.didTapAvatar()
    }

    @objc
    private func didTapAddPrescription() {
        self.delegate?.didTapAddPrescription()
    }

    @objc
    private func didTapMyPrescription() {
        self.delegate?.didTapMyPrescription()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            profileBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            profileBackground.topAnchor.constraint(equalTo: self.topAnchor),
            profileBackground.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.30),

            avatarView.topAnchor.constraint(equalTo: profileBackground.topAnchor, constant: CFMetrics.homeHeaderPadding),
            avatarView.leadingAnchor.constraint(equalTo: profileBackground.leadingAnchor, constant: CFMetrics.homeHeaderPadding),
            avatarView.widthAnchor.constraint(equalToConstant: CFMetrics.homeAvatarSize),
            avatarView.heightAnchor.constraint(equalToConstant: CFMetrics.homeAvatarSize),

            welcomeTitle.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: CFMetrics.semiMedium),
            welcomeTitle.leadingAnchor.constraint(equalTo: profileBackground.leadingAnchor, constant: CFMetrics.homeHeaderPadding),
            welcomeTitle.trailingAnchor.constraint(equalTo: profileBackground.trailingAnchor, constant: -CFMetrics.homeHeaderPadding),

            nameTextField.topAnchor.constraint(equalTo: welcomeTitle.bottomAnchor, constant: CFMetrics.semiTiny),
            nameTextField.leadingAnchor.constraint(equalTo: profileBackground.leadingAnchor, constant: CFMetrics.homeHeaderPadding),
            nameTextField.trailingAnchor.constraint(equalTo: profileBackground.trailingAnchor, constant: -CFMetrics.homeHeaderPadding),

            contentBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentBackground.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75),

            feedbackButton.bottomAnchor.constraint(equalTo: contentBackground.bottomAnchor, constant: -CFMetrics.homeHeaderPadding),
            feedbackButton.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: CFMetrics.homeHeaderPadding),
            feedbackButton.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -CFMetrics.homeHeaderPadding),
            feedbackButton.heightAnchor.constraint(equalToConstant: CFMetrics.buttonSize),

            stackView.topAnchor.constraint(equalTo: contentBackground.topAnchor, constant: CFMetrics.semiHuge),
            stackView.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: CFMetrics.semiHuge),
            stackView.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -CFMetrics.semiHuge)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let userName = nameTextField.text ?? ""
        UserDefaultsManager.saveUserName(name: userName)
        return true
    }
}

extension HomeView: CFButtonDelegate {
    func buttonAction() {
        if
            let url = URL(string: "itms-apps://itunes.apple.com/app/6450132001?action=write-review"),
            UIApplication.shared.canOpenURL(url) {

            UIApplication.shared.open(url)
        } else {
            print("Not possible to open url")
        }

    }
}
