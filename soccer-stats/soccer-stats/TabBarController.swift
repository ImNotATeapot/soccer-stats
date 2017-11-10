
//
//  TabBarController.swift
//  soccer-stats
//
//  Created by Pearl on 11/10/2560 BE.
//
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().barTintColor = UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        //        self.navigationBar.layer.shadowColor = UIColor.black.cgColor
        //        self.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        //        self.navigationBar.layer.shadowRadius = 4.0
        //        self.navigationBar.layer.shadowOpacity = 1.0
        //        self.navigationBar.layer.masksToBounds = false
    }
    
}
