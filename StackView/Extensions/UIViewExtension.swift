//
//  UIViewExtension.swift
//  StackView
//
//  Created by Aaina Jain on 30/04/20.
//  Copyright © 2020 Aaina Jain. All rights reserved.
//

import UIKit

extension UIView {
    @inline(__always) static func build<T>(applyAttributes: ((T) -> Void)? = nil) -> T where T: UIView {
        let uiComponent = T(frame: .zero)
        uiComponent.translatesAutoresizingMaskIntoConstraints = false
        applyAttributes?(uiComponent)
        return uiComponent
    }
}
