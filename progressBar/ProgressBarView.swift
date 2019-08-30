//
//  ProgressBarVC.swift
//  progressBar
//
//  Created by Brandon Wood on 8/26/19.
//  Copyright © 2019 Brandon Wood. All rights reserved.
//

import UIKit

class ProgressBarView: UIView {

    var timer = Timer()
    
    var percentLabel = UILabel()

    var lineLayer = CAShapeLayer()
    var trackLayer = CAShapeLayer()

    // create new path
    var linePath = UIBezierPath()
    var trackPath = UIBezierPath()

    var strokeEndValue : CGFloat = 0
    
    var padding : CGFloat = 10
    
    
    // incoming props
    var width : CGFloat = 0
    var height : CGFloat = 0
    var percent : CGFloat = 0
    var animated : Bool = false
    var color : UIColor = .blue
    
    
    required init(animated: Bool, width: CGFloat, height: CGFloat, percent: CGFloat, color: UIColor) {
        super.init(frame: .zero)
        self.width = width - padding
        self.height = height
        self.percent = percent
        self.animated = animated
        self.color = color
        drawLine()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        drawLine()

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawLine()

    }
    
    func drawLine() {

        // set line start point
        linePath.move(to: CGPoint(x: padding, y: self.height/2))
        trackPath.move(to: CGPoint(x: padding, y: self.height/2))

        // add the line
        linePath.addLine(to: CGPoint(x:self.width, y:self.height/2))
        trackPath.addLine(to: CGPoint(x:self.width, y:self.height/2))

        // add line path to the shape layer
        lineLayer.path = linePath.cgPath
        trackLayer.path = trackPath.cgPath
        
        // set line attributes
        lineLayer.lineWidth = 10
        lineLayer.strokeColor = color.cgColor
        lineLayer.lineCap = .round
        
        if (animated) {
            lineLayer.strokeEnd = 0
        } else {
            strokeEndValue = (percent * width) / width
            print("strokeEndValue = \(strokeEndValue)")
            lineLayer.strokeEnd = strokeEndValue
        }
        
        trackLayer.lineWidth = 10
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineCap = .round
        trackLayer.strokeEnd = 1
        
        // add shape layer to view
        self.layer.addSublayer(trackLayer)
        self.layer.addSublayer(lineLayer)

        
        percentLabel = UILabel(frame: CGRect(x: padding, y: self.height/2, width: 100, height: 50))
        percentLabel.text = String(format: "%.0f", self.percent*100) + "%"
        percentLabel.textAlignment = .left
        percentLabel.font = .systemFont(ofSize: 30.0, weight: .bold)
        percentLabel.textColor = .black
        self.addSubview(percentLabel)
        
        
        if (animated) {
            percentLabel.text = String(format: "%.0f", 0) + "%"
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateBar), userInfo: nil, repeats: true)
        }
        
        
        
//        if (animated) {
//            // tell it to animate the strokeEnd attribute
//            let basicAnimationLine = CABasicAnimation(keyPath: "strokeEnd")
//
//            // animate strokeEnd all the way around to starting point for 2 seconds
//            basicAnimationLine.toValue = percent
//            basicAnimationLine.duration = 0.5
//
//            // keep the animation on screen when complete
//            basicAnimationLine.isRemovedOnCompletion = false
//            basicAnimationLine.fillMode = .forwards
//
//            // add the animation to the shape layer
//            lineLayer.add(basicAnimationLine, forKey: "blah")
//        }
    }
    
    
    @objc func updateBar() {
        let nextStrokeValue = lineLayer.strokeEnd + 0.05
        
//        let percentage = ((100 * lineLayer.strokeEnd)/100)
        let percentage = ((100 * nextStrokeValue)/100)
        print(percentage)
        
        if (percentage >= self.percent) {
            self.timer.invalidate()
            lineLayer.strokeEnd = self.percent
            percentLabel.text = String(format: "%.0f", self.percent*100) + "%"
        } else {
            lineLayer.strokeEnd = nextStrokeValue
            percentLabel.text = String(format: "%.0f", percentage*100) + "%"
        }
        

    }


}
