//
//  SettingsViewController.swift
//  soccer-stats
//
//  Created by Pearl on 11/10/2560 BE.
//
//

import Foundation
import UIKit
import CoreData

class SettingsViewController: UIViewController {
    
    var displayedPlayers:[NSManagedObject] = ActiveTeam.sharedInstance.activeTeam
    
    // DO NOT TOUCH THIS
    /*@IBAction func syncButtonClicked(_ sender: Any) {
        Utility.init().save(first: "Patriya", last: "Piyawiroj", position: "Defender", number: 18)
        Utility.init().save(first: "Varis", last: "Shnatepaporn", position: "Forward", number: 23)
        Utility.init().save(first: "Fah", last: "Yoovidhya", position: "Midfieler", number: 6)
        Utility.init().save(first: "Puinoon", last: "na Nakorn", position: "Defender", number: 24)
        Utility.init().save(first: "Kate", last: "Kim", position: "Forward", number: 19)
        Utility.init().save(first: "Tony", last: "Lertvilaivithaya", position: "Midfielder", number: 11)
    }*/
    
    
}
