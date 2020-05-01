//
//  SliderCell.swift
//  StackView
//
//  Created by Aaina Jain on 29/04/20.
//  Copyright © 2020 Aaina Jain. All rights reserved.
//

import UIKit

final class SliderCell: UITableViewCell {
    var pickerElements = [String]()
    private var updateValueAction: ((String) -> ())?
    
    private lazy var label: UILabel = {
        return UILabel.build(applyAttributes: { label in
            label.textColor = .black
        })
    }()
    
    private lazy var slider: UISlider = {
        return UISlider.build(applyAttributes: { slider in
            slider.minimumValue = -20
            slider.value = 0
            slider.maximumValue = 100
            slider.addTarget(self, action: #selector(SliderCell.onValueChanged), for: .valueChanged)
        })
    }()
    
    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with valueAction: @escaping (String) -> ()) {
        self.updateValueAction = valueAction
    }
    
    @objc func onValueChanged() {
        let sliderValue = String(round(slider.value))
        label.text = sliderValue
        updateValueAction?(sliderValue)
    }
}

private extension SliderCell {
    func applyConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 16),
            slider.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            slider.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: slider.bottomAnchor, constant: 16)
        ])
    }
    
    func setupViews() {
        contentView.addSubview(label)
        contentView.addSubview(slider)
        
        applyConstraints()
        
        onValueChanged()
    }
}
