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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
    }
    
    init(contentView: NewReceiptView, delegate: NewReceiptFlowDelegate) {
        self.contentView = contentView
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        self.contentView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        view.addSubview(contentView)
        view.backgroundColor = Colors.gray800
        setupConstraints()
    }
    
    private func setupActions(){
        
    }
    
    private func setupConstraints(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}


extension NewReceiptViewController:NewReceiptViewDelegate {
    func didTapGoBack() {
        delegate?.goBack()
    }
}
