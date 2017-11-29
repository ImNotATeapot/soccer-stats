//
//  Utility.swift
//  Test
//
//  Created by Pearl on 11/16/2560 BE.
//  Copyright © 2560 Pearl. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    
    private var screenHeight:CGFloat = UIScreen.main.bounds.height
    private var screenWidth:CGFloat = UIScreen.main.bounds.width
    
    private class arrow {
        
    }
    
    func drawCircle(point:CGPoint, color:UIColor) -> CAShapeLayer {
        let circle = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: point.x,y: point.y), radius: CGFloat(5), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        circle.path = circlePath.cgPath
        //change the fill color
        circle.fillColor = color.cgColor
        //change the stroke color
        circle.strokeColor = color.cgColor
        return circle
    }
    
    func drawArrow(start:CGPoint, end:CGPoint) -> UIBezierPath{
        
        let changeInX:CGFloat = end.x - start.x
        let changeInY:CGFloat = end.y - start.y
        let angle:CGFloat = atan(changeInY/changeInX)
        
        let direction = end.x-start.x //if end > start positive to the right
        var multiplier:CGFloat = 1.0
        if direction < 0 {
            multiplier = -1.0
        }
        
        let ARROW_ANGLE:CGFloat = 0.5

        let AcoordX:CGFloat = end.x-multiplier*10.0*cos(angle-ARROW_ANGLE)
        let AcoordY:CGFloat = end.y-multiplier*10.0*sin(angle-ARROW_ANGLE)
        let BcoordX:CGFloat = end.x-multiplier*10.0*cos(angle+ARROW_ANGLE)
        let BcoordY:CGFloat = end.y-multiplier*10.0*sin(angle+ARROW_ANGLE)

        
        let arrowPath = UIBezierPath()
        arrowPath.move(to: start)
        arrowPath.addLine(to:end) //angled to top right
        arrowPath.addLine(to:CGPoint(x:AcoordX, y:AcoordY))
        arrowPath.addLine(to:CGPoint(x:BcoordX, y:BcoordY))
        arrowPath.addLine(to:end)
        arrowPath.close()
        
//        let rotation = CGAffineTransform(rotationAngle: angle)
//        arrowPath.apply(rotation)
        
        return arrowPath
        
//        let arrowShape = CAShapeLayer()
//        arrowShape.path = arrowPath.cgPath
//        arrowShape.fillColor = UIColor.gray.cgColor
//        arrowShape.strokeColor = UIColor.gray.cgColor
//        arrowShape.setAffineTransform(CGAffineTransform(rotationAngle: angle))
//        return arrowShape
    }
}
