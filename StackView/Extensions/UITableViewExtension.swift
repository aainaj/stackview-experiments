//
//  UITableViewExtension.swift
//  StackView
//
//  Created by Aaina Jain on 30/04/20.
//  Copyright © 2020 Aaina Jain. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T>(_ type: T.Type) where T: UITableViewCell {
        register(type, forCellReuseIdentifier: String(describing: type))
    }
}
