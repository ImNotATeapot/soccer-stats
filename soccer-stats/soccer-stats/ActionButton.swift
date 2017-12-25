//
//  ActionButton.swift
//  soccer-stats
//
//  Created by Pearl on 11/11/2560 BE.
//
//

import Foundation
import UIKit

protocol ActionButtonDelegate {
    func didSelectButton(_ actionButton:ActionButton)
}

class ActionButton:UIButton {
    
    var ActionButtonDelegate:ActionButtonDelegate?
    var buttonSelected:UIButton = UIButton()
    var action:String?
    var color:UIColor = UIColor.init(red: 117/255, green: 224/255, blue: 51/255, alpha: 1)
    
    
    override func draw(_ rect: CGRect) {
        self.layer.borderWidth = 2.0
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = 12.0
        self.setTitleColor(UIColor.init(red: 83/255, green: 88/255, blue: 95/255, alpha: 1.0), for: .normal)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        checkState()
        if let actualDelegate = ActionButtonDelegate {
            actualDelegate.didSelectButton(self)
        }
    }
    
    public func checkState() {
        if self.state == .selected {
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
    
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        
//        self.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
//    }
//    
//    func buttonClicked() {
//    }
}
