//
//  SplashViewController.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 24/12/24.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    let contentView:SplashView
    public weak var delegate: SplashFlowDelegate?
    
    init(contentView: SplashView,delegate: SplashFlowDelegate) {
        self.delegate = delegate
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        decideFlow()
    }
    
    private func setupUI(){
        self.view.addSubview(contentView)
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = Colors.primaryRedBase
        setupConstraints()
    }
    
    private func setupConstraints(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func decideFlow() {
       DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
           self?.contentView.animateLogoImageView()
           self?.delegate?.decideFlow()
       }
   }
}
