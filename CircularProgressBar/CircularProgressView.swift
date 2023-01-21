//
//  CircularProgressView.swift
//  CircularProgressBar
//
//  Created by Salman Biljeek on 1/19/23.
//

import UIKit

class CircularProgressView: UIView {
    
    let trackShapeLayer = CAShapeLayer()
    let progressShapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layout()
    }
    
    private func layout() {
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 35, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        let lineWidth: CGFloat = 6
        
        // Track Shape layer
        trackShapeLayer.path = circularPath.cgPath
        trackShapeLayer.strokeColor = UIColor.init(white: 0.5, alpha: 0.5).cgColor
        trackShapeLayer.lineWidth = lineWidth
        trackShapeLayer.fillColor = UIColor.clear.cgColor
        trackShapeLayer.lineCap = .round
        trackShapeLayer.position = self.center
        
        // To add a shadow, uncomment the below code:
        
//        trackShapeLayer.shadowColor = UIColor.black.cgColor
//        trackShapeLayer.shadowPath = trackShapeLayer.path?.copy(strokingWithWidth: 5, lineCap: .round, lineJoin: .round, miterLimit: 5)
//        trackShapeLayer.shadowOpacity = 1
//        trackShapeLayer.shadowOffset = CGSize.zero
//        trackShapeLayer.shadowRadius = 5
        
        // Progress Shape Layer
        progressShapeLayer.path = circularPath.cgPath
        progressShapeLayer.strokeColor = UIColor.white.cgColor
        progressShapeLayer.lineWidth = lineWidth
        progressShapeLayer.fillColor = UIColor.clear.cgColor
        progressShapeLayer.lineCap = .round
        progressShapeLayer.position = self.center
        progressShapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        progressShapeLayer.strokeEnd = 0
        
        self.layer.addSublayer(trackShapeLayer)
        self.layer.addSublayer(progressShapeLayer)
    }
    
    var progress: CGFloat? {
        didSet {
            if let progress = progress {
                self.progressShapeLayer.strokeEnd = progress
            }
        }
    }
}
