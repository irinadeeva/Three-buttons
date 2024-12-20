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

        thirdButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc func buttonTapped() {

        let vc = SheetController()
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
}

class CustomButton: UIButton {
    private var scaleDownAnimator: UIViewPropertyAnimator?
    private var scaleUpAnimator: UIViewPropertyAnimator?

    override var isHighlighted: Bool {
        get {
            return false
        }
        set {
            // Do nothing to prevent the default highlighting behavior
        }
    }

    override func tintColorDidChange() {
        super.tintColorDidChange()

        switch tintAdjustmentMode {
        case .dimmed:
            self.backgroundColor = .systemGray2
            self.imageView?.tintColor = .systemGray3
            self.titleLabel?.textColor = .systemGray3
        default:
            self.backgroundColor = .systemBlue
            self.imageView?.tintColor = .white
            self.titleLabel?.textColor = .white
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupButton() {
        configuration = .borderedProminent()
        configuration?.contentInsets = .init(top: 10, leading: 14, bottom: 10, trailing: 14)
        configuration?.titleAlignment = .center
        configuration?.imagePlacement = .trailing
        configuration?.image = UIImage(systemName: "arrow.forward.circle.fill")
        configuration?.imagePadding = 8

        layer.cornerRadius = 12

        addTarget(self, action: #selector(handleTouchDown), for: .touchDown)
        addTarget(self, action: #selector(handleTouchUp), for: [.touchUpInside, .touchUpOutside])
    }

    @objc private func handleTouchDown() {
        scaleUpAnimator?.stopAnimation(true)

        scaleDownAnimator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.5) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        scaleDownAnimator?.startAnimation()
    }

    @objc private func handleTouchUp() {
        scaleDownAnimator?.stopAnimation(true)

        scaleUpAnimator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.5) {
            self.transform = .identity
        }
        scaleUpAnimator?.startAnimation()
    }
}

final class SheetController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemCyan
    }
}
