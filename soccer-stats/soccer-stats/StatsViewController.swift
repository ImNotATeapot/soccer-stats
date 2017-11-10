//
//  StatsViewController.swift
//  soccer-stats
//
//  Created by Pearl on 11/9/2560 BE.
//
//

import Foundation
import UIKit
import CoreData

class StatsViewController: UIViewController {
    
    var displayedPlayers:[NSManagedObject] = ActiveTeam.sharedInstance.activeTeam
    var playerObjects:[NSManagedObject] = Utility.init().fetch()

    override func viewDidLoad() {
         
    }
}
