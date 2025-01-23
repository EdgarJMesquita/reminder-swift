//
//  RATableCellView.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 22/01/25.
//

import Foundation
import UIKit

class RemedyCell: UITableViewCell {
    static let identifier = "UITableViewCell"

    var onDeleteTapped: (()->Void)?

    
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.gray200
        label.font = Typograph.subHeading
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.trash, for: .normal)

        return button
    }()
    
    private lazy var timeChip: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = Colors.gray500
        stackView.layer.cornerRadius = 12
        stackView.layer.masksToBounds = true
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.layoutMargins = UIEdgeInsets(top: 7, left: 8, bottom: 7, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var timeIcon: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .clock
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var timeLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.gray100
        label.font = Typograph.tag
        return label
    }()
    
    private lazy var recurrenceChip: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = Colors.gray500
        stackView.layer.cornerRadius = 12
        stackView.layer.masksToBounds = true
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.layoutMargins = UIEdgeInsets(top: 7, left: 8, bottom: 7, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var recurrenceIcon: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .repeat
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var recurrenceLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.gray100
        label.font = Typograph.tag
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(remedy: Remedy){
        titleLabel.text = remedy.name
        timeLabel.text = remedy.time
        recurrenceLabel.text = remedy.recurrence

        deleteButton.tag = remedy.id
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        titleLabel.text = nil
        timeLabel.text = nil
        recurrenceLabel.text = nil
        deleteButton.tag = -1
    }
    
    @objc
    private func didTapDeleteButton(sender: Any){
        onDeleteTapped?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 10))
    }
    
    private func setup(){
        contentView.backgroundColor = Colors.gray700
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Colors.gray600.cgColor
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        backgroundColor = .clear
        
        deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteButton)
        
        contentView.addSubview(timeChip)
        timeChip.addArrangedSubview(timeIcon)
        timeChip.addArrangedSubview(timeLabel)
        
        contentView.addSubview(recurrenceChip)
        recurrenceChip.addArrangedSubview(recurrenceIcon)
        recurrenceChip.addArrangedSubview(recurrenceLabel)
        
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            deleteButton.heightAnchor.constraint(equalToConstant: 16),
            deleteButton.widthAnchor.constraint(equalToConstant: 16),
            
            timeChip.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            timeChip.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            timeChip.heightAnchor.constraint(equalToConstant: 28),
            
            timeIcon.heightAnchor.constraint(equalToConstant: 14),
            timeIcon.widthAnchor.constraint(equalToConstant: 14),
            
            recurrenceChip.topAnchor.constraint(equalTo: timeChip.topAnchor),
            recurrenceChip.leadingAnchor.constraint(equalTo: timeChip.trailingAnchor, constant: 8),
            recurrenceChip.heightAnchor.constraint(equalToConstant: 28),
            
            recurrenceIcon.heightAnchor.constraint(equalToConstant: 14),
            recurrenceIcon.widthAnchor.constraint(equalToConstant: 14),
        ])
    }
}
