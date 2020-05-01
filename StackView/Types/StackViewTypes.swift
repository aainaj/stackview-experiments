//
//  StackViewTypes.swift
//  StackView
//
//  Created by Aaina Jain on 27/04/20.
//  Copyright © 2020 Aaina Jain. All rights reserved.
//

import Foundation
import UIKit

enum StackViewAxis: String, CaseIterable {
    case horizontal = "horizontal"
    case vertical = "vertical"
    
    var toUIStackViewAxis: NSLayoutConstraint.Axis {
        switch self {
        case .horizontal:
            return .horizontal
        case .vertical:
            return .vertical
        }
    }
}

enum StackViewDistribution: String, CaseIterable {
    case fill = "fill"
    case fillEqually = "fillEqually"
    case fillProportionally = "fillProportionally"
    case equalSpacing = "equalSpacing"
    case equalCentering = "equalCentering"
    
    var toUIStackViewDistribution: UIStackView.Distribution {
        switch self {
        case .fill:
            return .fill
        case .fillEqually:
            return .fillEqually
        case .fillProportionally:
            return .fillProportionally
        case .equalSpacing:
            return .equalSpacing
        case .equalCentering:
            return .equalCentering
        }
    }
}

enum StackViewAlignment: String, CaseIterable {
    case fill = "fill"
    case leading = "leading"
    case top = "top"
    case firstBaseline = "firstBaseline"
    case center = "center"
    case trailing = "trailing"
    case lastBaseline = "lastBaseline"
    case bottom = "bottom"

    
    var toUIStackViewAlignment: UIStackView.Alignment {
        switch self {
        case .fill:
            return .fill
        case .leading:
            return .leading
        case .top:
            return .top
        case .firstBaseline:
            return .firstBaseline
        case .center:
            return .center
        case .trailing:
            return .trailing
        case .lastBaseline:
            return .lastBaseline
        case .bottom:
            return .bottom
        }
    }
}
