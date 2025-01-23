//
//  NewReceiptViewController.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 06/01/25.
//

import Foundation
import UIKit

class NewReceiptViewController:UIViewController {
    private let contentView: NewReceiptView
    weak var delegate:NewReceiptFlowDelegate?
    private let viewModel: NewReceiptViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
    
    init(contentView: NewReceiptView,viewModel: NewReceiptViewModel, delegate: NewReceiptFlowDelegate) {
        self.contentView = contentView
        self.delegate = delegate
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.contentView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        view.addSubview(contentView)
        view.backgroundColor = Colors.gray800
        navigationController?.navigationBar.isHidden = true
        setupConstraints()
    }
    
    private func setupConstraints(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}


extension NewReceiptViewController:NewReceiptViewDelegate {
    func didTapAddButton() {
        let remedy = contentView.remedyInput.getText()
        let time = contentView.timeInput.getText()
        let recurrence = contentView.recurrenceInput.getText()
        let takeNow = contentView.checkbox.isSelected
   
        viewModel.addReceipt(remedy: remedy,
                             time: time,
                             recurrence: recurrence,
                             takeNow: takeNow)

        contentView.playSuccessAnimation()
    }
    
    func didTapGoBack() {
        delegate?.goBack()
    }
}
