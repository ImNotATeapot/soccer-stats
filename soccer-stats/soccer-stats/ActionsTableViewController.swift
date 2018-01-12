//
//  ActionsTableViewController.swift
//  soccer-stats
//
//  Created by Pearl on 1/12/2561 BE.
//

import Foundation
import UIKit

class ActionsTableViewController:UITableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let parent = parent as? MainViewController {
            switch indexPath.section {
            case 0:
                parent.performSegue(withIdentifier: "toGameViewController", sender: parent)
            case 1:
                parent.performSegue(withIdentifier: "toGameViewController", sender: parent)
            case 2:
                if indexPath.row == 0 {
                    self.tabBarController?.selectedViewController = tabBarController!.viewControllers?[2]
                } else if indexPath.row == 1 {
                    self.tabBarController?.selectedViewController = tabBarController!.viewControllers?[1]
                }
            default: break
            }
        }
    }
}
