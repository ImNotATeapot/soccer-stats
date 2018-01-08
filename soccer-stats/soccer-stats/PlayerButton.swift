//
//  PlayerButton.swift
//  soccer-stats
//
//  Created by Pearl on 1/7/2561 BE.
//

import Foundation
import UIKit
import CoreData

class PlayerButton: UIButton {
    
    var player:NSManagedObject?
    var number:Int?
    var _displayedPlayers:[NSManagedObject] = ActiveTeam.sharedInstance.activeTeam
    
    override func draw(_ rect: CGRect) {
        if let player = player {
            let firstName:String = player.value(forKey: "firstName") as? String ?? ""
            let lastName:String = player.value(forKey: "lastName") as? String ?? ""
            self.setTitleColor(UIColor.white, for: .normal)
            self.alpha = 1.0
            self.layer.backgroundColor = UIColor(red: 65/255, green: 96/255, blue: 115/255, alpha: 1.0).cgColor
            self.setTitle(lastName + " " + firstName, for: .normal)
        } else {
            self.setTitleColor(UIColor.white, for: .normal)
            self.alpha = 0.45
            self.layer.backgroundColor = UIColor(red: 50/255, green: 73/255, blue: 87/255, alpha: 0.45).cgColor
            self.setTitle("Pick Player", for: .normal)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if player != nil {
            player = nil
            self.setNeedsDisplay()
            if let number = number {
                _displayedPlayers[number] = NSManagedObject()
            }
        }
    }

}
