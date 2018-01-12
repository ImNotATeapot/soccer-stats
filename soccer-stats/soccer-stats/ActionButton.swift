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
    
    override func draw(_ rect: CGRect) {
        
        self.setTitleColor(UIColor.white, for: .normal)
        if self.tag == 0 {
            self.layer.borderWidth = 3.0
            self.layer.borderColor = UIColor.init(red: 27/255, green: 165/255, blue: 92/255, alpha: 1.0).cgColor
            if self.isSelected {
                self.layer.backgroundColor = UIColor.init(red: 27/255, green: 165/255, blue: 92/255, alpha: 1.0).cgColor
            } else {
                self.layer.backgroundColor = UIColor.clear.cgColor
            }
        } else if self.tag == 1 {
            self.layer.backgroundColor = UIColor.init(red: 0/255, green: 201/255, blue: 203/255, alpha: 1.0).cgColor
        } else if self.tag == 2 {
            self.layer.backgroundColor = UIColor.init(red: 184/255, green: 19/255, blue: 0/255, alpha: 1.0).cgColor
        }
        if self.isSelected {
            self.alpha = 1.0
        } else {
            self.alpha = 0.56
        }
    }

}
