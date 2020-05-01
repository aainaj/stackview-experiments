
//
//  File.swift
//  StackView
//
//  Created by Aaina Jain on 28/04/20.
//  Copyright © 2020 Aaina Jain. All rights reserved.
//

import UIKit

final class TextFieldCell: UITableViewCell {
    private var pickerElements = [String]()
    private var updateValueAction: ((String) -> ())?

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.inputView = pickerView
        return textField
    }()
    
    private lazy var pickerView: UIPickerView = {
        return UIPickerView.build(applyAttributes: { picker in
            picker.delegate =  self
            picker.dataSource = self
        })
    }()
    
    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with elements: [String], updateValueAction: @escaping (String) -> ()) {
        self.updateValueAction = updateValueAction
        pickerElements = elements
        textField.text = pickerElements.first
    }
}

extension TextFieldCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerElements[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let element = pickerElements[row]
        updateValueAction?(element)
        textField.text = element
        textField.resignFirstResponder()
    }
}

extension TextFieldCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerElements.count
    }
}

private extension TextFieldCell {
    func applyConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16)
        ])
    }
    
    func setupViews() {
        contentView.addSubview(textField)
        applyConstraints()
    }
}
