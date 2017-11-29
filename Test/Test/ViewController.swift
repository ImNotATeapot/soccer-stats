//
//  ViewController.swift
//  Test
//
//  Created by Pearl on 11/13/2560 BE.
//  Copyright © 2560 Pearl. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    var arrow:CAShapeLayer = CAShapeLayer()
    var startPoint:CGPoint = CGPoint()
    var endPoint:CGPoint = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(didPan)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didPan(_ panGestureRecognizer:UIPanGestureRecognizer) {
        let location = panGestureRecognizer.location(in: view)
        var arrowPath:UIBezierPath = UIBezierPath()
        
        switch panGestureRecognizer.state {
        case .began :
            startPoint = location
            arrowPath = Utility.init().drawArrow(start: startPoint, end: CGPoint(x: startPoint.x+1, y: startPoint.y+1))
            
            let arrowShape = CAShapeLayer()
            arrowShape.path = arrowPath.cgPath
            arrowShape.fillColor = UIColor.gray.cgColor
            arrowShape.strokeColor = UIColor.gray.cgColor
            
            arrow = arrowShape
            view.layer.addSublayer(arrow)
        case .changed :
            endPoint = location
            arrowPath = Utility.init().drawArrow(start: startPoint, end: endPoint)
            arrow.path = arrowPath.cgPath
        case .ended :
            endPoint = location
            arrowPath = Utility.init().drawArrow(start: startPoint, end: endPoint)
            arrow.path = arrowPath.cgPath
        default: break
        }
    }
}

