//
//  ExperimentStackView.swift
//  StackView
//
//  Created by Aaina Jain on 28/04/20.
//  Copyright © 2020 Aaina Jain. All rights reserved.
//

import UIKit

final class ExperimentView: UIView {
    private let stackView: UIStackView = UIStackView.build()
    
    private lazy var leftLabelText: UILabel =  {
        return UILabel.build() { label in
            label.backgroundColor = .systemTeal
            label.numberOfLines = 0
        }
    }()
    
    private lazy var rightLabelText: UILabel =  {
        return UILabel.build() { label in
            label.backgroundColor = .systemGray5
            label.numberOfLines = 0
        }
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func relayoutStackView(with attributes: StackViewAttributes) {
        UIView.animate(withDuration: 0.25) { () -> Void in
            self.stackView.axis = attributes.axis
            self.stackView.alignment = attributes.alignment
            self.stackView.distribution = attributes.distribution
            self.stackView.spacing = attributes.spacing
            self.leftLabelText.text = attributes.leftLabel
            self.rightLabelText.text = attributes.rightLabel
        }
        constraints(for: stackView).forEach { print($0) }
    }
}

private extension ExperimentView {
    func setupStackView() {
        backgroundColor = .systemBlue
        
        stackView.addArrangedSubview(leftLabelText)
        stackView.addArrangedSubview(rightLabelText)
        addSubview(stackView)
        applyConstraints()
    }
    
    func applyConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(16)),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16)
        ])
    }
    
    func constraints(for view: UIView) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf: view.constraints)
        for subview in view.subviews {
            constraints.append(contentsOf: subview.constraints)
        }
        return constraints
    }
}
