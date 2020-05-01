//
//  FormSection.swift
//  StackView
//
//  Created by Aaina Jain on 30/04/20.
//  Copyright © 2020 Aaina Jain. All rights reserved.
//

import Foundation

enum FormSection: String, CaseIterable {
    case axis = "Axis"
    case distribution = "Distribution"
    case alignment = "Alignment"
    case spacing = "Spacing"
    case labelContent = "Label Content"
}

enum FormFieldType: Equatable, Hashable {
    case textField(dropDownElements: [String])
    case textView(text: String)
    case slider
}

struct FormData: Hashable {
    let fieldType: FormFieldType
}

struct FormDataList {
    let axis: [FormData]
    let distribution: [FormData]
    let alignment: [FormData]
    let spacing: [FormData]
    let labelContent: [FormData]
}
  
