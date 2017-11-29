//
//  PushButton.swift
//  Test
//
//  Created by Pearl on 11/15/2560 BE.
//  Copyright © 2560 Pearl. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class PushButton:UIButton{
    
    private struct Constants {
        static let plusLineWidth: CGFloat = 3.0
        static let plusButtonScale: CGFloat = 0.6
        static let halfPointShift: CGFloat = 0.5
    }
    
    private var halfWidth: CGFloat {
        return bounds.width / 2
    }
    
    private var halfHeight: CGFloat {
        return bounds.height / 2
    }
    
    
    override func draw(_ rect:CGRect) {
        let arrow = UIBezierPath()
        arrow.move(to: CGPoint(x:0, y:frame.height))
        arrow.addLine(to:CGPoint(x:0, y:0))
        arrow.addLine(to:CGPoint(x:3, y:4))
        arrow.addLine(to:CGPoint(x:-3, y:4))
        arrow.addLine(to:CGPoint(x:0, y:0))
        arrow.close()
        
        UIColor.green.setStroke()
        UIColor.green.setFill()
        
        let triangle = CAShapeLayer()
        triangle.path = arrow.cgPath
        triangle.fillColor = UIColor.gray.cgColor
        triangle.strokeColor = UIColor.black.cgColor
        self.layer.addSublayer(triangle)
        
        triangle.setAffineTransform(CGAffineTransform(rotationAngle: .pi))
    }
    
}
