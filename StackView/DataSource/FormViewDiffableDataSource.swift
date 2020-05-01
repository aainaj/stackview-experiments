//
//  FormViewDiffableDataSource.swift
//  StackView
//
//  Created by Aaina Jain on 01/05/20.
//  Copyright © 2020 Aaina Jain. All rights reserved.
//

import UIKit

final class FormViewDiffableDataSource: UITableViewDiffableDataSource<FormSection, FormData>  {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return snapshot().sectionIdentifiers[section].rawValue
    }
}
