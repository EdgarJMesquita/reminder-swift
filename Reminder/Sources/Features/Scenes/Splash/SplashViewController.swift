//
//  SplashViewController.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 24/12/24.
//

import Foundation
import UIKit
import CoreFramework

class SplashViewController: UIViewController {
    let contentView: SplashView
    public weak var delegate: SplashFlowDelegate?

    init(contentView: SplashView, delegate: SplashFlowDelegate) {
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
        startBreathingAnimation()
    }

    private func setupUI() {
        self.view.addSubview(contentView)
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = CFColors.primaryRedBase
        setupConstraints()
    }

    private func setupConstraints() {
        self.setupContentViewToBounds(contentView: contentView)
    }

    private func decideFlow() {
       if let user = UserDefaultsManager.loadUser(), user.isUserSaved {
           self.delegate?.navigateToHome()
       } else {
           self.animateLogoUp()
           self.delegate?.openLoginBottomSheet()
       }
   }
}

// MARK: - Animations
extension SplashViewController {
    private func startBreathingAnimation() {
        self.view.layoutIfNeeded()
        UIView.animate(
            withDuration: 1.5,
            delay: 0.0,
            animations: {
                let scale = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.contentView.logoImageView.transform = scale
            },
            completion: {_ in
                self.decideFlow()
            }
        )
    }

    private func animateLogoUp() {
        UIView.animate(
                withDuration: 0.5,
                delay: 0.0,
                options: [.curveEaseOut],
                animations: {
                    let translate = CGAffineTransform(translationX: 0, y: -(self.view.frame.height / 4))
                    let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    self.contentView.logoImageView.transform = translate.concatenating(scale)
                }
        )
    }
}
