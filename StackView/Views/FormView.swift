//
//  FormView.swift
//  StackView
//
//  Created by Aaina Jain on 25/04/20.
//  Copyright © 2020 Aaina Jain. All rights reserved.
//

import UIKit

final class FormView: UIView {
    private var formDataList: [FormData]?
    private let stackViewAttributesBuilder = StackViewAttributes.Builder()
    private let experimentView: ExperimentView = ExperimentView.build()
    private var currentStackViewAttributes: StackViewAttributes
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 120
        return view
    }()
    
    override init(frame: CGRect) {
        currentStackViewAttributes = stackViewAttributesBuilder.build()
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(tableView)
        addSubview(experimentView)
        
        applyConstraints()

        registerCells()
    }
    
    func update(with formDataList: [FormData]) {
        self.formDataList = formDataList
        experimentView.relayoutStackView(with: currentStackViewAttributes)
    }
}

extension FormView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard FormSection.allCases[section] == .labelContent else {
            return 1
        }
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return FormSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return FormSection.allCases[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let formData = formDataList?[indexPath.section] else {
             fatalError()
        }
        let section = FormSection.allCases[indexPath.section]
        switch formData.fieldType {
        case .textField(let pickerElements):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TextFieldCell.self), for: indexPath) as! TextFieldCell
            cell.update(with: pickerElements, updateValueAction: { [weak self] element in
                self?.updateValue(section: section, element: element)
            })
            return cell
        case .slider:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SliderCell.self), for: indexPath) as! SliderCell
            cell.update(with: { [weak self] element in
                self?.updateValue(section: section, element: element)
            })
            return cell
        case .textView(let texts):
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TextViewCell.self), for: indexPath) as! TextViewCell
            cell.update(with: texts[indexPath.row], updateValueAction: { [weak self] element in
                self?.updateText(element: element, row: indexPath.row)
            })
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func relayoutStackView() {
        let stackViewAttributes = self.stackViewAttributesBuilder.build()
        guard currentStackViewAttributes.hashValue != stackViewAttributes.hashValue else {
            return
        }
        experimentView.relayoutStackView(with: stackViewAttributes)
        currentStackViewAttributes = stackViewAttributes
    }
}

private extension FormView {
    func registerCells() {
        tableView.register(TextFieldCell.self)
        tableView.register(TextViewCell.self)
        tableView.register(SliderCell.self)
    }

    func applyConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            experimentView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            experimentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            experimentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAnchor.constraint(equalTo: experimentView.bottomAnchor)
        ])
    }
    
    func updateValue(section: FormSection, element: String) {
        switch section {
        case .axis:
            stackViewAttributesBuilder.set(axis: StackViewAxis(rawValue: element)?.toUIStackViewAxis)
        case .alignment:
            stackViewAttributesBuilder.set(alignment: StackViewAlignment(rawValue: element)?.toUIStackViewAlignment)
        case .distribution:
            stackViewAttributesBuilder.set(distribution: StackViewDistribution(rawValue: element)?.toUIStackViewDistribution)
        case .spacing:
            stackViewAttributesBuilder.set(spacing:  CGFloat((element as NSString).floatValue))
        default: break
        }
    }
    
    func updateText(element: String, row: Int) {
        if row == 0 {
            stackViewAttributesBuilder.set(leftLabel: element)
        } else {
            stackViewAttributesBuilder.set(rightLabel: element)
        }
    }
}
