//
//  FormView.swift
//  StackView
//
//  Created by Aaina Jain on 25/04/20.
//  Copyright © 2020 Aaina Jain. All rights reserved.
//

import UIKit

final class FormView: UIView {
    private let stackViewAttributesBuilder = StackViewAttributes.Builder()
    private let experimentView: ExperimentView = ExperimentView.build()
    var currentStackViewAttributes: StackViewAttributes
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var dataSource = makeDataSource()
    var snapshot = NSDiffableDataSourceSnapshot<FormSection, FormData>()
    
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
        tableView.dataSource = dataSource
    }
    
    func update(with list: FormDataList) {
        snapshot.appendSections(FormSection.allCases)
        
        snapshot.appendItems(list.axis, toSection: .axis)
        snapshot.appendItems(list.distribution, toSection: .distribution)
        snapshot.appendItems(list.alignment, toSection: .alignment)
        snapshot.appendItems(list.spacing, toSection: .spacing)
        snapshot.appendItems(list.labelContent, toSection: .labelContent)

        dataSource.apply(snapshot, animatingDifferences: true)
        experimentView.relayoutStackView(with: currentStackViewAttributes)
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

extension FormView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
            trailingAnchor.constraint(equalTo: tableView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            experimentView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            experimentView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: experimentView.trailingAnchor),
            bottomAnchor.constraint(equalTo: experimentView.bottomAnchor)
        ])
    }
}

private extension FormView {
    func makeDataSource() -> UITableViewDiffableDataSource<FormSection, FormData> {
        return FormViewDiffableDataSource(
            tableView: tableView,
            cellProvider: { [unowned self] tableView, indexPath, formData in
                let section = self.snapshot.sectionIdentifiers[indexPath.section]
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
                case .textView(let text):
                    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TextViewCell.self), for: indexPath) as! TextViewCell
                    cell.update(with: text, updateValueAction: { [weak self] element in
                        self?.updateText(element: element, row: indexPath.row)
                    })
                    return cell
                }
        }
        )
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

