//
//  CoreGraphicsHelper.swift
//  soccer-stats
//
//  Created by Pearl on 1/6/2561 BE.
//

import UIKit
import Foundation

class CoreGraphicsHelper {
    private var screenHeight:CGFloat = UIScreen.main.bounds.height
    private var screenWidth:CGFloat = UIScreen.main.bounds.width
    
    func drawCircle(selectedPosition:CGPoint, tappedImage:UIImageView) {
        
        let shapeLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: selectedPosition.x,y: selectedPosition.y), radius: CGFloat(5), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        shapeLayer.path = circlePath.cgPath
        //change the fill color
        shapeLayer.fillColor = UIColor.blue.cgColor
        //change the stroke color
        shapeLayer.strokeColor = UIColor.blue.cgColor
        tappedImage.layer.addSublayer(shapeLayer)
    }
    
    func drawArrow(start:CGPoint, end:CGPoint) -> UIBezierPath {
        
        let changeInX:CGFloat = end.x - start.x
        let changeInY:CGFloat = end.y - start.y
        let angle:CGFloat = atan(changeInY/changeInX)
        
        var multiplier:CGFloat = 1
        if changeInX < 0 {
            multiplier = -1
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
        
        return arrowPath
    }
}
