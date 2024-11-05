//
//  ViewController.swift
//  Task2_Buttons
//
//  Created by Irina Deeva on 04/11/24.
//

import UIKit

final class ViewController: UIViewController {
    var firstButton = CustomButton()
    var secondButton = CustomButton()
    var thirdButton = CustomButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        [firstButton, secondButton, thirdButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            firstButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            firstButton.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),

            secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 12),
            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            secondButton.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),

            thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: 12),
            thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thirdButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            thirdButton.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16)
        ])

        firstButton.setTitle("First Button", for: .normal)
        secondButton.setTitle("Second Medium", for: .normal)
        thirdButton.setTitle("Third Button", for: .normal)

        firstButton.addTarget(self, action: #selector(animate(sender: )), for: .touchUpInside)
        thirdButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

    }

    @objc func animate(sender: UIButton) {

    }

    @objc func buttonTapped() {
        [firstButton, secondButton, thirdButton].forEach {
            $0.backgroundColor = .systemGray2
            $0.imageView?.tintColor = .systemGray3
            $0.titleLabel?.textColor = .systemGray3
        }

        let vc = SheetController()
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
}

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupButton() {
        layer.cornerRadius = 12

        configuration = .borderedProminent()
        configuration?.contentInsets = .init(top: 10, leading: 14, bottom: 10, trailing: 14)
        configuration?.titleAlignment = .center
        configuration?.imagePlacement = .trailing
        configuration?.image = UIImage(systemName: "arrow.forward.circle.fill")
        configuration?.imagePadding = 8
    }
}

final class SheetController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemCyan
    }
}
