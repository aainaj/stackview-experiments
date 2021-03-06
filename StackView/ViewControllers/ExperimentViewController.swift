//
//  ViewController.swift
//  StackView
//
//  Created by Aaina Jain on 25/04/20.
//  Copyright © 2020 Aaina Jain. All rights reserved.
//

import UIKit

final class ExperimentViewController: UIViewController {
    let formView: FormView = FormView.build()
    
    override func loadView() {
        view = UIView()
        setupViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "StackView Experiments"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .done, target: self, action: #selector(reLayoutStackView))
        formView.update(with: makeHomeDataList())
    }
    
    @objc func reLayoutStackView() {
        formView.relayoutStackView()
    }
}

// MARK: Private functions
private extension ExperimentViewController {
    func makeHomeDataList() -> [FormData] {
        let axisData = FormData(fieldType: .textField(dropDownElements: StackViewAxis.allCases.map { $0.rawValue }))
        let distributionData = FormData(fieldType: .textField(dropDownElements: StackViewDistribution.allCases.map { $0.rawValue }))
        let alignmentData = FormData(fieldType: .textField(dropDownElements: StackViewAlignment.allCases.map { $0.rawValue }))
        let sliderData = FormData(fieldType: .slider)
        let textViewData = FormData(fieldType: .textView(texts: ["Lorem Ipsum", "Lorem Ipsum"]))
        
        return [axisData, distributionData, alignmentData, sliderData, textViewData]
    }
    
    func setupViews() {
        view.addSubview(formView)
        applyConstraints()
    }
    
    func applyConstraints() {
        NSLayoutConstraint.activate([
            formView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            formView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: formView.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: formView.bottomAnchor)
        ])
    }
}
