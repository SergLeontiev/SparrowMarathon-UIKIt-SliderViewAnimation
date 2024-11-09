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
        let view = UIView(frame: CGRect(x: view.layoutMargins.left, y: 100, width: 70, height: 70))
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        return view
    }()
    private(set) lazy var slider: UISlider = {
        let slider = UISlider(
            frame: CGRect(
                x: view.layoutMargins.left,
                y: 220,
                width: view.frame.maxX - view.layoutMargins.left - view.layoutMargins.right,
                height: 30
            )
        )
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        view.addSubview(resultView)
        view.addSubview(slider)
        
        animator.addAnimations {
            self.resultView.transform = CGAffineTransform(rotationAngle: .pi / 2).scaledBy(x: 1.5, y: 1.5)
            self.resultView.center.x = self.view.frame.maxX - self.view.layoutMargins.right - (self.resultView.frame.width / 2)
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
