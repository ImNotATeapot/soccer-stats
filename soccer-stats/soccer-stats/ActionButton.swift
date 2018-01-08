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
    
    var buttonSelected:UIButton = UIButton()
    var action:String?
    var color:UIColor = UIColor.init(red: 117/255, green: 224/255, blue: 51/255, alpha: 1)
    
    
    override func draw(_ rect: CGRect) {
        self.layer.borderWidth = 2.0
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = 12.0
        self.setTitleColor(UIColor.init(red: 83/255, green: 88/255, blue: 95/255, alpha: 1.0), for: .normal)
    }

    public func checkState() {
        if self.isSelected {
            self.layer.backgroundColor = color.cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
//    override func didch
//    override func setSelected
    
//    @IBAction func doSomething(sender: self, forEvent event: .TouchUpInside) {
//        
//    }
    
}
