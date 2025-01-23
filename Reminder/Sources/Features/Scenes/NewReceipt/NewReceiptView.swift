//
//  NewReceipt.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 06/01/25.
//

import Foundation
import UIKit
import Lottie

class NewReceiptView: UIView {
    weak var delegate: NewReceiptViewDelegate?
    
    private let backButton:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = Colors.gray100
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "newReceipt.title".localized
        label.textColor = Colors.primaryRedBase
        label.font = Typograph.heading
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "newReceipt.description".localized
        label.textColor = Colors.gray200
        label.numberOfLines = 0
        label.font = Typograph.body
        
        return label
    }()
    
    
    private let stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        return stackView
    }()
    
    let remedyInput: Input = {
        let input = Input(label: "Remédio", placeholder: "Nome do medicamento")
        return input
    }()
    
    let timeInput: Input = {
        let input = Input(label: "Horário", placeholder: "00:00")
        return input
    }()
    
    let recurrenceInput: Input = {
        let input = Input(label: "Recorrência", placeholder: "Selecione")
        return input
    }()
    
    let checkbox:Checkbox = {
        let checkbox = Checkbox()
        checkbox.setTitle(title: "Tomar agora")
        return checkbox
    }()
    
    let addButton:UIButton = {
        let button = UIButton()
        button.setTitle("+ Adicionar", for: .normal)
        button.titleLabel?.font = Typograph.subHeading
        button.backgroundColor = Colors.primaryRedBase
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private lazy var recurrencePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private lazy var successAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "success")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.isHidden = true
        
        return animationView
    }()
    
//    let recurrenceOptions = [
//        "De hora em hora",
//        "2 em 2 horas",
//        "4 em 4 horas",
//        "6 em 6 horas",
//        "12 em 12 horas",
//        "Um por dia"
//    ]
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        addTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        setupHierarchy()
        setupConstraints()
        setupTimeInput()
        setupRecurrenceInput()
        
        setupObservers()
        validateInputs()
        
    
    }
    
    private func clearFields(){
        checkbox.isSelected = false
        remedyInput.clear()
        timeInput.clear()
        recurrenceInput.clear()
        addButton.isEnabled = false
        addButton.backgroundColor = Colors.gray500
    }
    
   
    private func setupTimeInput(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, 
                                         target: self,
                                         action: #selector(didSelectTime))
        
        toolbar.setItems([doneButton], animated: true)
        
        timeInput.textField.inputView = timePicker
        timeInput.textField.inputAccessoryView = toolbar
    }
    
    @objc
    private func didSelectTime(){
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        timeInput.textField.text = formatter.string(from: timePicker.date)
        timeInput.textField.resignFirstResponder()
        validateInputs()
    }
    
    private func setupRecurrenceInput(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(didSelectRecurrence))
        
        toolbar.setItems([doneButton], animated: true)
        recurrenceInput.textField.inputView = recurrencePicker
        recurrenceInput.textField.inputAccessoryView = toolbar
        
        recurrencePicker.delegate = self
        recurrencePicker.dataSource = self
    }
    
    func playSuccessAnimation(){
        successAnimationView.isHidden = false
        clearFields()
        successAnimationView.play() { [weak self] finished in
            if finished {
                self?.successAnimationView.isHidden = true
            }
        }
    }
    
    @objc
    private func didSelectRecurrence(){
        let selectedRow = recurrencePicker.selectedRow(inComponent: 0)
        recurrenceInput.textField.text = SelectOptions.recurrence[selectedRow].label
        recurrenceInput.textField.resignFirstResponder()
        validateInputs()
    }
    
    private func addTapGesture(){
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapBackButton(){
        delegate?.didTapGoBack()
    }
    
    @objc
    private func didTapAddButton(){
        delegate?.didTapAddButton()
    }
    
    @objc
    private func validateInputs(){
        let isRemedyFilled = !(remedyInput.textField.text ?? "").isEmpty
        let isTimeFilled = !(timeInput.textField.text ?? "").isEmpty
        let isIntervalFilled = !(recurrenceInput.textField.text ?? "").isEmpty
        
        addButton.isEnabled = isRemedyFilled && isTimeFilled && isIntervalFilled
        addButton.backgroundColor = addButton.isEnabled ? Colors.primaryRedBase : Colors.gray500
    }
    
    private func setupObservers(){
        remedyInput.textField.addTarget(self, action: #selector(validateInputs), for: .editingChanged)

    }
    
    private func setupHierarchy(){
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(addButton)
        addSubview(stackView)
        stackView.addArrangedSubview(remedyInput)
        stackView.addArrangedSubview(timeInput)
        stackView.addArrangedSubview(recurrenceInput)
        stackView.addArrangedSubview(checkbox)
        
        addSubview(successAnimationView)
    }
    
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.semiHuge),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Metrics.medium),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.semiHuge),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.semiHuge),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.tiny),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.semiHuge),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.semiHuge),
            
            stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.semiHuge),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.semiHuge),
            
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant:Metrics.semiHuge),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -Metrics.semiHuge),
            addButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -14),
            addButton.heightAnchor.constraint(equalToConstant: Metrics.buttonSize),
            
            successAnimationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            successAnimationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            successAnimationView.heightAnchor.constraint(equalToConstant: 240),
            successAnimationView.widthAnchor.constraint(equalToConstant: 240),
        ])
    }
}

extension NewReceiptView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SelectOptions.recurrence.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SelectOptions.recurrence[row].label
    }
}


extension NewReceiptView: UIPickerViewDelegate {
    
}
