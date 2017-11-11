//
//  ActionButton.swift
//  soccer-stats
//
//  Created by Pearl on 11/11/2560 BE.
//
//

import Foundation
import UIKit

class ActionButton:UIButton {
    
    var action:String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.init(red: 117/255, green: 224/255, blue: 51/255, alpha: 1).cgColor
        self.layer.cornerRadius = 12.0
        self.setTitleColor(UIColor.init(red: 83/255, green: 88/255, blue: 95/255, alpha: 1.0), for: .normal)
        
    }
}
