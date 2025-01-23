//
//  Checkbox.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 07/01/25.
//

import Foundation
import UIKit

class Checkbox: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        setImage(UIImage(named: "Unchecked"), for: .normal)
        setImage(UIImage(named: "checked"), for: .selected)
        addTarget(self, action: #selector(toogleCheck), for: .touchUpInside)
        
        contentHorizontalAlignment = .leading
        
        setTitleColor(Colors.gray200, for: .normal)
        setTitleColor(Colors.gray200, for: .selected)
        titleLabel?.font = Typograph.input
        
        var configuration = Configuration.plain()
        configuration.automaticallyUpdateForSelection = false
        configuration.imagePadding = 12
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 5)
        configuration.baseBackgroundColor = .clear
        
        self.configuration = configuration
        
        
    }
        
    @objc
    private func toogleCheck(){
        self.isSelected.toggle()
    }
    
    func setTitle(title:String) {
        setTitle(title, for: .normal)
        setTitle(title, for: .selected)
    }
}
