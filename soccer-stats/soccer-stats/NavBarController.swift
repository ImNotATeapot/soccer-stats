//
//  NavBarController.swift
//  soccer-stats
//
//  Created by Pearl on 11/10/2560 BE.
//
//

import UIKit

@IBDesignable
class NavBarController: UINavigationController {
    
    var RED_FULL:UIColor = UIColor(red: 163.0/255.0, green: 34.0/255.0, blue: 48.0/255.0, alpha: 0.95)
    let RED_FADED:UIColor = UIColor(red: 146.0/255.0, green: 82.0/255.0, blue: 97.0/255.0, alpha: 0.53)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = [RED_FULL.cgColor, RED_FADED.cgColor]
        gradientLayer.frame = CGRect(x: 0.0,
                                     y: -20.0,
                                     width: navigationBar.bounds.width,
                                     height: navigationBar.bounds.height+20)
        self.navigationBar.layer.addSublayer(gradientLayer)
        
        self.navigationBar.barTintColor = UIColor.clear
        self.navigationBar.backgroundColor = UIColor.clear
        
//        self.navigationBar.layer.shadowColor = UIColor.black.cgColor
//        self.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        self.navigationBar.layer.shadowRadius = 4.0
//        self.navigationBar.layer.shadowOpacity = 1.0
        self.navigationBar.layer.masksToBounds = false

    }

}

