//
//  Team.swift
//  soccer-stats
//
//  Created by Pearl on 11/10/2560 BE.
//
//

import Foundation
import UIKit
import CoreData

class ActiveTeam:NSObject{
    static let sharedInstance = ActiveTeam()
    
    var activeTeam:[NSManagedObject] = [NSManagedObject(), NSManagedObject(), NSManagedObject(), NSManagedObject()]
    
    func getPlayers()->[NSManagedObject]{
        return activeTeam
    }
    
    func changePlayers(players:[NSManagedObject]){
        activeTeam = players
    }
}
