//
//  PlayersTableViewController.swift
//  soccer-stats
//
//  Created by Pearl on 1/9/2561 BE.
//

import Foundation
import UIKit
import CoreData

class PlayersTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var playersTableView: UITableView!
    
    let playerObjects:[NSManagedObject] = CoreDataHelper.init().fetch()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PlayerCell = tableView.dequeueReusableCell(withIdentifier: "playerCell") as! PlayerCell
        let player:NSManagedObject = playerObjects[indexPath.section]
        cell.player = player
        if let numLabel:UILabel = cell.viewWithTag(1) as? UILabel {
            let number:Int = player.value(forKey: "number") as? Int ?? 0
            numLabel.text = "\(number)"
        }
        if let positionLabel:UILabel = cell.viewWithTag(2) as? UILabel {
            positionLabel.text = player.value(forKey: "position") as? String
        }
        if let nameLabel:UILabel = cell.viewWithTag(3) as? UILabel {
            let firstName:String = player.value(forKey: "firstName") as? String ?? ""
            let lastName:String = player.value(forKey: "lastName") as? String ?? ""
            nameLabel.text = lastName + " " + firstName
        }
        return cell
    }
}
