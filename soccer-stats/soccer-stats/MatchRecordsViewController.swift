//
//  MatchRecordsViewController.swift
//  soccer-stats
//
//  Created by Pearl on 1/13/2561 BE.
//

import Foundation
import UIKit
import CoreData

class MatchRecordsViewController:UIViewController {
    
    @IBOutlet weak var fieldImageView: UIImageView!
    
    var selectedPlayer:NSManagedObject = NSManagedObject()
    
    override func viewDidLoad() {
        //make sure you handle null cases
        let points = CoreDataHelper.init().fetch(player: selectedPlayer, stat: "shots")
        for point in points {
            CoreGraphicsHelper.init().drawCircle(selectedPosition: point, tappedImage: fieldImageView)
        }
    }
}
