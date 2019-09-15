//
//  ViewController.swift
//  BasicAnimations
//
//  Created by James Pacheco on 1/30/19.
//  Copyright © 2019 James Pacheco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var label: UILabel!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
		
		configureLabel()
        configureButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // This ensures the label is centered on the screen to start
        label.center = self.view.center
    }
    
    func configureLabel() {
        label = UILabel(frame: CGRect(x: view.center.x, y: view.center.y, width: 200, height: 200))
        label.widthAnchor.constraint(equalTo: label.heightAnchor).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 12
        
        label.text = "👮‍♂️"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 96)
    }
    
    func configureButtons() {
        let rotateButton = UIButton(type: .system)
        rotateButton.translatesAutoresizingMaskIntoConstraints = false
        rotateButton.setTitle("Rotate", for: .normal)
        rotateButton.addTarget(self, action: #selector(rotateButtonTapped), for: .touchUpInside)
        
        let keyButton = UIButton(type: .system)
        keyButton.translatesAutoresizingMaskIntoConstraints = false
        keyButton.setTitle("Key", for: .normal)
        keyButton.addTarget(self, action: #selector(keyButtonTapped), for: .touchUpInside)
        
        let springButton = UIButton(type: .system)
        springButton.translatesAutoresizingMaskIntoConstraints = false
        springButton.setTitle("Spring", for: .normal)
        springButton.addTarget(self, action: #selector(springButtonTapped), for: .touchUpInside)
        
        let squashButton = UIButton(type: .system)
        squashButton.translatesAutoresizingMaskIntoConstraints = false
        squashButton.setTitle("Squash", for: .normal)
        squashButton.addTarget(self, action: #selector(squashButtonTapped), for: .touchUpInside)
        
        let anticButton = UIButton(type: .system)
        anticButton.translatesAutoresizingMaskIntoConstraints = false
        anticButton.setTitle("Antic", for: .normal)
        anticButton.addTarget(self, action: #selector(anticButtonTapped), for: .touchUpInside)
        
        let caButton = UIButton(type: .system)
        caButton.translatesAutoresizingMaskIntoConstraints = false
        caButton.setTitle("Core Anim.", for: .normal)
        caButton.addTarget(self, action: #selector(coreAnimationButtonTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [rotateButton,
                                                       keyButton,
                                                       springButton,
                                                       squashButton,
                                                       anticButton,
                                                       caButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ])
    }
    
  
    
    // MARK: - Actions
    
    @objc func rotateButtonTapped() {

//		UIView.animate(withDuration: 1.0) {
//			self.label.center = CGPoint(x: 300, y: 600)
//			self.label.alpha = 0
//		}) { (_) in
//
//			// Because we are performing this animation inside of the completion closure, it won't begin until the first animation finishes.
//
//			UIView.animate(withDuration: 1.0, animations: {
//				self.label.center = self.view.center
//				self.label.alpha = 1
//			})
//
//		}

		UIView.animate(withDuration: 2, animations: {

			self.label.transform =
				CGAffineTransform(rotationAngle: CGFloat.pi /
					4).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
			// what is isFinished for
		}) { (isFinished) in

			UIView.animate(withDuration: 2, animations: {
			self.label.transform = .identity
		})

		}
    }
    

	@objc func keyButtonTapped() {
		// Keyframes

		UIView.animateKeyframes(withDuration: 2, delay: 0, options: [], animations: {

			UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
				self.label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
			})

			UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
				self.label.transform = .identity
			})

			UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25, animations: {
				self.label.center = CGPoint(x: self.label.center.x, y:
				self.label.center.y - 100)
			})

			UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
				self.label.center = self.view.center
			})



		}, completion: nil)

        
    }
    
    @objc func springButtonTapped() {

		self.label.transform = CGAffineTransform(translationX: 0, y: -300)

		UIView.animate(withDuration: 1,
					   delay: 0,
					   usingSpringWithDamping: 0.9,
					   initialSpringVelocity: 0.1,
					   options: .curveEaseOut,
					   animations: {

						self.label.transform = .identity

		}, completion: nil)
    }
    
    @objc func squashButtonTapped() {
        
    }
    
    @objc func anticButtonTapped() {
        
    }
    
    @objc func coreAnimationButtonTapped() {

		// You have to animate each property individually

		let colorAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.borderColor))
		colorAnimation.fromValue = label.layer.borderColor

		let newBorderColor = randomColor()
		colorAnimation.toValue = newBorderColor
		colorAnimation.duration = 1.5

		// Set the borderColor to the 'toValue' in order for the color to stay changed after the animation finished
		label.layer.borderColor = newBorderColor
		// Timing is optional:
		colorAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)

		label.layer.add(colorAnimation, forKey: nil)

        
    }
    
    private func randomColor() -> CGColor {
        let red = CGFloat.random(in: 0...255)
        let green = CGFloat.random(in: 0...255)
        let blue = CGFloat.random(in: 0...255)
        
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1.0).cgColor
    }
    
}

