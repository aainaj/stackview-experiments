//
//  TextViewCell.swift
//  StackView
//
//  Created by Aaina Jain on 29/04/20.
//  Copyright © 2020 Aaina Jain. All rights reserved.
//

import UIKit

final class TextViewCell: UITableViewCell {
    private var updateValueAction: ((String) -> ())?
    
    private lazy var textView: UITextView = {
        return UITextView.build(applyAttributes: { textView in
            textView.textAlignment = NSTextAlignment.justified
            textView.delegate = self
            textView.font = UIFont.systemFont(ofSize: 16 )
        })
    }()
    
    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with text: String, updateValueAction: @escaping (String) -> ()) {
        self.updateValueAction = updateValueAction
        textView.text = text
    }
}

extension TextViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard !textView.text.isEmpty else {
            return
        }
        updateValueAction?(textView.text)
    }
}

private extension TextViewCell {
    func applyConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            contentView.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16)
        ])
    }
    
    func setupViews() {
        contentView.addSubview(textView)
        applyConstraints()
    }
}
