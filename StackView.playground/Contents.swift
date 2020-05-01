import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 500.0))

containerView.backgroundColor = UIColor.green

let stackView = UIStackView()
stackView.axis = .vertical
stackView.distribution = .fillEqually
stackView.alignment = .center
stackView.spacing = 10
stackView.translatesAutoresizingMaskIntoConstraints = false

containerView.addSubview(stackView)

NSLayoutConstraint.activate([
    stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
    stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
    stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
    stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
])

for i in 0 ..< 5 {
//    let button = UIButton(type: .system)
//    button.backgroundColor = .brown
//    button.setTitle("view \(i)", for: .normal)
    
    let button = UILabel()
       button.backgroundColor = .brown
       button.text = """
/(stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor))
"""
    
    stackView.addArrangedSubview(button)
}

PlaygroundPage.current.liveView = containerView
