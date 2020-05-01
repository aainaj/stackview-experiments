//
//  StackViewAttributes.swift
//  StackView
//
//  Created by Aaina Jain on 30/04/20.
//  Copyright © 2020 Aaina Jain. All rights reserved.
//

import Foundation
import UIKit

struct StackViewAttributes: Hashable {
    let axis: NSLayoutConstraint.Axis
    let distribution: UIStackView.Distribution
    let alignment: UIStackView.Alignment
    let spacing: CGFloat
    let leftLabel: String
    let rightLabel: String

    class Builder {
        var axis: NSLayoutConstraint.Axis = .horizontal
        var distribution: UIStackView.Distribution = .fill
        var alignment: UIStackView.Alignment = .fill
        var spacing: CGFloat = 0
        var leftLabel: String = "Lorem Ipsum"
        var rightLabel: String = "Lorem Ipsum Dolor"
        
        func set(axis newValue: NSLayoutConstraint.Axis?) {
            self.axis = newValue ?? axis
        }
        
        func set(alignment newValue: UIStackView.Alignment?) {
            self.alignment = newValue ?? alignment
        }
        
        func set(distribution newValue: UIStackView.Distribution?) {
            self.distribution = newValue ?? distribution
        }
        
        func set(spacing newValue: CGFloat?) {
            self.spacing = newValue ?? spacing
        }
        
        func set(leftLabel newValue: String?) {
            self.leftLabel = newValue ?? leftLabel
        }
        
        func set(rightLabel newValue: String?) {
            self.rightLabel = newValue ?? rightLabel
        }
        
        func build() -> StackViewAttributes {
            return StackViewAttributes(axis: axis, distribution: distribution, alignment: alignment, spacing: spacing, leftLabel: leftLabel, rightLabel: rightLabel)
        }
    }
}
