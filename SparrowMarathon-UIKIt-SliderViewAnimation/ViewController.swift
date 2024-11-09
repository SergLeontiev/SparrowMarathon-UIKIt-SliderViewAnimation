//
//  ViewController.swift
//  SparrowMarathon-UIKIt-SliderViewAnimation
//
//  Created by Sergey Leontiev on 7.11.24..
//

import UIKit

class ViewController: UIViewController {
    private(set) var animator: UIViewPropertyAnimator = {
        let animator = UIViewPropertyAnimator(duration: 1, curve: .linear)
        animator.pausesOnCompletion = true
        return animator
    }()
    private(set) lazy var resultView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        return view
    }()
    private(set) lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(resultView)
        view.addSubview(slider)
        
        let heightConstaint = resultView.heightAnchor.constraint(equalToConstant: 70)
        let widthConstraint = resultView.widthAnchor.constraint(equalToConstant: 70)
        let leadingConstraint = resultView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        let trailingConstraint = resultView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        
        NSLayoutConstraint.activate([
            resultView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            leadingConstraint,
            heightConstaint,
            widthConstraint,
            slider.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
            slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
        
       
        animator.addAnimations {
            self.resultView.transform = CGAffineTransform(rotationAngle: .pi / 2)
            
            heightConstaint.constant *= 1.5
            widthConstraint.constant *= 1.5
            
            leadingConstraint.isActive = false
            trailingConstraint.isActive = true
        
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func sliderChanged(_ sender: UISlider, for event: UIEvent) {
        guard let touchEvent = event.allTouches?.first else { return }
        switch touchEvent.phase {
        case .moved:
            animator.fractionComplete = CGFloat(sender.value)
        case .ended:
            sender.setValue(1, animated: true)
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0.2)
        default:
            return
        }
    }
}
