//
//  Player.swift
//  soccer-stats
//
//  Created by Pearl on 11/9/2560 BE.
//
//

import Foundation

class Player:NSObject{
    
    var firstName:String = ""
    var lastName:String = ""
    var position:String = ""
    var number:Int = 0
    
    override init() {
        
    }
    
    init(firstName:String, lastName:String, position:String, number:Int){
        self.firstName = firstName;
        self.lastName = lastName;
        self.position = position;
        self.number = number;
    }
    
}
