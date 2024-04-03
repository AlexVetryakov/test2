//
//  CommonInputField.swift
//  PillReminder
//
//  Created by Александр Ветряков on 27.12.2023.
//

import UIKit

final class CommonInputField: BaseView {
    
    struct Configurator {
        let font: UIFont?
        let toolBarTitle: String?
        let keyboardType: UIKeyboardType
        let returnKeyType: UIReturnKeyType
        let isKeyboardNeeded: Bool
        let enablePaste: Bool
        let allowedRegex: String?
        
        init(
            font: UIFont? = R.font.openSansSemiBold(size: 16.0),
            toolBarTitle: String? = "",
            keyboardType: UIKeyboardType = .default,
            returnKeyType: UIReturnKeyType = .done,
            isKeyboardNeeded: Bool = true,
            enablePaste: Bool = true,
            allowedRegex: String? = nil
        ) {
            self.font = font
            self.toolBarTitle = toolBarTitle
            self.keyboardType = keyboardType
            self.returnKeyType = returnKeyType
            self.isKeyboardNeeded = isKeyboardNeeded
            self.enablePaste = enablePaste
            self.allowedRegex = allowedRegex
        }
    }

    var onTextChanged: ((String) -> Void)?
    var didSelectDateHandler: ((Date) -> Void)?
    
    let textField: CustomTextField = CustomTextField()
    private let containerView: UIView = UIView()
    private let configurator: Configurator
    
    // MARK: - Init

    init(configurator: Configurator) {
        self.configurator = configurator
        
        super.init()
        
        backgroundColor = .clear
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.addCornerRadius(12.0)
    }
    
    func setupDatePicker(inputDate: Date? = nil, maxDate: Date? = nil, minDate: Date? = nil) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "uk_UA")
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
        datePicker.date = inputDate ?? Date()
        
        textField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        datePicker.preferredDatePickerStyle = .wheels
        textField.tintColor = .clear
        textField.enablePaste = false
        addDoneButton()
    }
    
    @objc
    func handleDatePicker(sender: UIDatePicker) {
        didSelectDateHandler?(sender.date)
     }
    
    // MARK: - UI
    
    private func setupViews() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.backgroundColor = R.color.backgroundPrimary()
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = R.color.divider()?.cgColor
        
        containerView.addSubview(textField)
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().offset(-8.0)
            $0.top.bottom.equalToSuperview().inset(4.0)
            $0.height.equalTo(40.0)
        }
        
        textField.font = configurator.font
        textField.textColor = R.color.textPrimary()
        textField.tintColor =  R.color.textPrimary()
        textField.textAlignment = .left
        textField.backgroundColor = .clear

        if configurator.keyboardType == .numberPad {
            addDoneButton()
        }
        textField.returnKeyType = configurator.returnKeyType
        textField.keyboardType = configurator.keyboardType
        textField.enablePaste = configurator.enablePaste
        textField.font = R.font.openSansRegular(size: 14.0)
        textField.delegate = self
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    private func addDoneButton() {
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(
            title: configurator.toolBarTitle,
            style: .done,
            target: self,
            action: #selector(self.doneButtonAction)
        )
        done.tintColor = R.color.backgroundSecondary()

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        textField.inputAccessoryView = doneToolbar
    }
    
    // MARK: - Actions
    
    @objc
    private func doneButtonAction(_ sender: UITextField) {
        textField.resignFirstResponder()
    }
    
    @objc
    private func editingChanged(_ sender: UITextField) {
        onTextChanged?(sender.text ?? "")
    }
}

extension CommonInputField: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        
        if let pattern = configurator.allowedRegex {
            let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
            if predicate.evaluate(with: newString) {
                onTextChanged?(newString)
            }
            return predicate.evaluate(with: newString)
        } else {
            onTextChanged?(newString)
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        configurator.isKeyboardNeeded
    }
}
