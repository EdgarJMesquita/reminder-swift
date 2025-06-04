//
//  NewReceipt.swift
//  Reminder
//
//  Created by Edgar Jonas Mesquita da Silva on 06/01/25.
//

import Foundation
import UIKit
import Lottie
import CoreFramework
import Combine

class NewReceiptView: UIView {
    weak var delegate: NewReceiptViewDelegate?

    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = CFColors.gray100
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "newReceipt.title".localized
        label.textColor = CFColors.primaryRedBase
        label.font = CFTypography.heading

        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "newReceipt.description".localized
        label.textColor = CFColors.gray200
        label.numberOfLines = 0
        label.font = CFTypography.body

        return label
    }()

    private let stackView: UIStackView = {
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

    let checkboxold: Checkbox = {
        let checkbox = Checkbox()
        checkbox.setTitle(title: "Tomar agora")
        return checkbox
    }()

    let checkbox: CFToggleCheckBox = {
        let checkbox = CFToggleCheckBox(
            title: "Tomar agora",
            checked: .checked,
            unchecked: .unchecked
        )
        return checkbox
    }()

    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("+ Adicionar", for: .normal)
        button.titleLabel?.font = CFTypography.subHeading
        button.backgroundColor = CFColors.primaryRedBase
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

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        addTapGesture()
        bindCheckboxAccessibility()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        setupHierarchy()
        setupConstraints()
        setupTimeInput()
        setupRecurrenceInput()

        setupObservers()
        validateInputs()

    }

    private func clearFields() {
        checkbox.isSelected = false
        remedyInput.clear()
        timeInput.clear()
        recurrenceInput.clear()
        addButton.isEnabled = false
        addButton.backgroundColor = CFColors.gray500
    }

    private func setupTimeInput() {
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
    private func didSelectTime() {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        timeInput.textField.text = formatter.string(from: timePicker.date)
        timeInput.textField.resignFirstResponder()
        validateInputs()
    }

    private func setupRecurrenceInput() {
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

    func playSuccessAnimation() {
        successAnimationView.isHidden = false
        clearFields()
        successAnimationView.play { [weak self] finished in
            if finished {
                self?.successAnimationView.isHidden = true
            }
        }
    }

    @objc
    private func didSelectRecurrence() {
        let selectedRow = recurrencePicker.selectedRow(inComponent: 0)
        recurrenceInput.textField.text = SelectOptions.recurrence[selectedRow].label
        recurrenceInput.textField.resignFirstResponder()
        validateInputs()
    }

    private func addTapGesture() {
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)

    }

    @objc
    private func didTapBackButton() {
        delegate?.didTapGoBack()
    }

    @objc
    private func didTapAddButton() {
        delegate?.didTapAddButton()
    }

    @objc
    private func validateInputs() {
        let isRemedyFilled = !(remedyInput.textField.text ?? "").isEmpty
        let isTimeFilled = !(timeInput.textField.text ?? "").isEmpty
        let isIntervalFilled = !(recurrenceInput.textField.text ?? "").isEmpty

        addButton.isEnabled = isRemedyFilled && isTimeFilled && isIntervalFilled
        addButton.backgroundColor = addButton.isEnabled ? CFColors.primaryRedBase : CFColors.gray500
    }

    @objc
    private func didTap() {
        delegate?.didTapAddButton()
    }

    private func setupObservers() {
        remedyInput.textField.addTarget(self, action: #selector(validateInputs), for: .editingChanged)

    }

    private func setupHierarchy() {
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

    private func setupConstraints() {

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CFMetrics.semiHuge),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),

            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: CFMetrics.medium),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CFMetrics.semiHuge),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CFMetrics.semiHuge),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: CFMetrics.tiny),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CFMetrics.semiHuge),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CFMetrics.semiHuge),

            stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CFMetrics.semiHuge),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CFMetrics.semiHuge),

            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CFMetrics.semiHuge),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CFMetrics.semiHuge),
            addButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -14),
            addButton.heightAnchor.constraint(equalToConstant: CFMetrics.buttonSize),

            successAnimationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            successAnimationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            successAnimationView.heightAnchor.constraint(equalToConstant: 240),
            successAnimationView.widthAnchor.constraint(equalToConstant: 240)
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

// MARK: Accessibility
extension NewReceiptView {
    private func bindCheckboxAccessibility() {
        checkbox.isAccessibilityElement = true
        checkbox.accessibilityLabel = "Checkbox para tomar o remédio na hora atual."
        checkbox.accessibilityHint = "Toque neste component que é um quadrado, para alternar se você tomou o remédio agora, ou não."
        checkbox.accessibilityTraits = [.button]

        checkbox.addTarget(self, action: #selector(didTapCheckbox), for: .touchUpInside)
    }

    @objc
    private func didTapCheckbox() {
        if checkbox.isSelected {
            checkbox.accessibilityTraits = [.button, .selected]
            UIAccessibility.post(notification: .announcement, argument: "Checkbox marcado")
        } else {
            checkbox.accessibilityTraits = [.button]
            UIAccessibility.post(notification: .announcement, argument: "Checkbox desmarcado")
        }
    }
}
