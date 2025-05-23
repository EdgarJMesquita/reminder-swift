//
//  MyReceiptsView.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 22/01/25.
//

import Foundation
import UIKit
import CoreFramework

class MyReceiptsView: UIView {
    weak var delegate: MyReceiptsViewDelegate?

    private lazy var headerBackground: UIView = {
        let view = UIView()
        view.backgroundColor = CFColors.gray600
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage.arrowLeft
        button.tintColor = CFColors.gray100
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit

        return button
    }()

    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.addButton, for: .normal)
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "myReceipt.title".localized
        label.font = CFTypography.heading
        label.textColor = CFColors.blueBase
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "myReceipt.description".localized
        label.font = CFTypography.body
        label.textColor = CFColors.gray200
        label.numberOfLines = 0
        return label
    }()

    private lazy var contentBackground: UIView = {
        let view = UIView()
        view.backgroundColor = CFColors.gray800
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var customTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RemedyCell.self, forCellReuseIdentifier: RemedyCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false

        return tableView
    }()

    private lazy var emptyMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nenhum remédio adicionado"
        label.font = CFTypography.body
        label.textColor = CFColors.gray200
        label.numberOfLines = 0
        label.alpha = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func goBack() {
        delegate?.goBack()
    }

    @objc
    private func didTapNewReceipt() {
        delegate?.navigateToMyReceipts()
    }

    func showEmptyMessage() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.emptyMessage.alpha = 1
        }
    }

    func hideEmptyMessage() {
        emptyMessage.alpha = 0
    }

    private func setupView() {
        setupHierarchy()
        setupConstraints()

        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(didTapNewReceipt), for: .touchUpInside)
    }

    private func setupHierarchy() {
        addSubview(headerBackground)
        headerBackground.addSubview(backButton)
        headerBackground.addSubview(addButton)
        headerBackground.addSubview(titleLabel)
        headerBackground.addSubview(descriptionLabel)

        addSubview(contentBackground)
        contentBackground.addSubview(customTableView)
        contentBackground.addSubview(emptyMessage)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerBackground.topAnchor.constraint(equalTo: topAnchor),
            headerBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerBackground.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35),

            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CFMetrics.semiHuge),
            backButton.heightAnchor.constraint(equalToConstant: 32),
            backButton.widthAnchor.constraint(equalToConstant: 32),

            addButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CFMetrics.semiHuge),

            titleLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: CFMetrics.medium),
            titleLabel.leadingAnchor.constraint(equalTo: headerBackground.leadingAnchor, constant: CFMetrics.semiHuge),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: CFMetrics.tiny),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: headerBackground.trailingAnchor, constant: -CFMetrics.semiHuge),

            contentBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentBackground.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.77),

            customTableView.topAnchor.constraint(equalTo: contentBackground.topAnchor, constant: 40),
            customTableView.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: CFMetrics.semiHuge),
            customTableView.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -22),
            customTableView.bottomAnchor.constraint(equalTo: contentBackground.bottomAnchor),

            emptyMessage.topAnchor.constraint(equalTo: contentBackground.topAnchor, constant: 40),
            emptyMessage.centerXAnchor.constraint(equalTo: contentBackground.centerXAnchor)

        ])
    }
}

protocol MyReceiptsViewDelegate: AnyObject {
    func goBack()
    func navigateToMyReceipts()
}
