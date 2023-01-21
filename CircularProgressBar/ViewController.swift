//
//  ViewController.swift
//  CircularProgressBar
//
//  Created by Salman Biljeek on 1/19/23.
//

import UIKit

class ViewController: UIViewController {
    
    let circularProgressView = CircularProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        view.addSubview(circularProgressView)
        circularProgressView.translatesAutoresizingMaskIntoConstraints = false
        circularProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circularProgressView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        
        let startButton: UIButton = {
            var configuration = UIButton.Configuration.filled()
            var container = AttributeContainer()
            container.font = .boldSystemFont(ofSize: 18)
            container.foregroundColor = .white
            configuration.attributedTitle = AttributedString("Start", attributes: container)
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25)
            configuration.baseBackgroundColor = .systemIndigo
            configuration.cornerStyle = .capsule
            
            let button = UIButton(configuration: configuration, primaryAction: nil)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(self.handleStart), for: .touchUpInside)
            return button
        }()
        
        let resetButton: UIButton = {
            var configuration = UIButton.Configuration.filled()
            var container = AttributeContainer()
            container.font = .boldSystemFont(ofSize: 18)
            container.foregroundColor = .black
            configuration.attributedTitle = AttributedString("Reset", attributes: container)
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25)
            configuration.baseBackgroundColor = .white
            configuration.cornerStyle = .capsule
            
            let button = UIButton(configuration: configuration, primaryAction: nil)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(self.handleReset), for: .touchUpInside)
            return button
        }()
        
        let buttonsStackView = UIStackView(arrangedSubviews: [
            startButton,
            resetButton
        ])
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 10
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(buttonsStackView)
        buttonsStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        buttonsStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    var progress: CGFloat = 0
    var repeatTimer: Timer?
    
    @objc fileprivate func handleStart() {
        let delay: Double = 0.7
        let timeInterval: Double = 0.05
        
        repeatTimer?.invalidate()
        repeatTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { (timer) in
            DispatchQueue.main.async {
                let current = self.progress
                let duration = CGFloat(delay / timeInterval)
                let add = (1 / duration)
                let newProgress = current + add
                self.progress = newProgress
                self.circularProgressView.progress = self.progress
            }
            let progressComplete = self.progress >= 1
            if progressComplete {
                timer.invalidate()
            }
        }
        if let repeatTimer = repeatTimer {
            RunLoop.current.add(repeatTimer, forMode: .common)
        }
    }
    
    @objc fileprivate func handleReset() {
        repeatTimer?.invalidate()
        self.progress = 0
        self.circularProgressView.progress = self.progress
    }
}

