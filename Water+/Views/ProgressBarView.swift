//
//  ProgressBarView.swift
//  Water+
//
//  Created by Илья Кузнецов on 26.06.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class ProgressBarView: UIView {

    var bgPath: UIBezierPath!
    var shapeLayer: CAShapeLayer!
    var progressLayer: CAShapeLayer!
    var maxProgress: Float!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            bgPath = UIBezierPath()
            self.simpleShape()
        }
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            bgPath = UIBezierPath()
            self.simpleShape()
        }
    
        
        func simpleShape() {
            createCirclePath()
            //риусем не заполненный круг
            shapeLayer = CAShapeLayer()
            shapeLayer.path = bgPath.cgPath
            shapeLayer.lineWidth = 15
            shapeLayer.fillColor = nil
            shapeLayer.strokeColor = UIColor.lightGray.cgColor
            
            //риусем слой прогресса
            progressLayer = CAShapeLayer()
            progressLayer.path = bgPath.cgPath
            progressLayer.lineCap = CAShapeLayerLineCap.round
            progressLayer.lineWidth = 15
            progressLayer.fillColor = nil
            progressLayer.strokeColor = UIColor.init(red: 30/255, green: 144/255, blue: 255/255, alpha: 1).cgColor
            progressLayer.strokeEnd = 0

            self.layer.addSublayer(shapeLayer)
            self.layer.addSublayer(progressLayer)
        }
        
        private func createCirclePath() {
            let x = self.frame.width/2
            let y = self.frame.height/2
            let center = CGPoint(x: x, y: y)
            bgPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)
            bgPath.close()
        }
    
func updateProgress(with value: Float) {
    if value > maxProgress! {
        progressLayer.strokeEnd = 1.0
            return
        }
    progressLayer.strokeEnd = CGFloat(value / maxProgress!)
    UserSettings.userProgress = Float(progressLayer.strokeEnd)
    }
}


