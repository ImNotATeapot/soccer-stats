//
//  GameViewController.swift
//  soccer-stats
//
//  Created by Pearl on 11/10/2560 BE.
//
//

import Foundation
import CoreData
import UIKit

class GameViewController:UIViewController {
    
    @IBOutlet weak var fieldImageView: UIImageView!
    @IBOutlet weak var failButton: ActionButton!
    @IBOutlet weak var successButton: ActionButton!
    

    @IBOutlet weak var tacklingButton: ActionButton!
    @IBOutlet weak var dribblingButton: ActionButton!
    @IBOutlet weak var distributionButton: ActionButton!
    @IBOutlet weak var communicationButton: ActionButton!
    @IBOutlet weak var shotButton: ActionButton!
    @IBOutlet weak var throughButton: ActionButton!
    @IBOutlet weak var longButton: ActionButton!
    @IBOutlet weak var shortButton: ActionButton!
    
    @IBOutlet weak var player1Button: PlayerButton!
    @IBOutlet weak var player2Button: PlayerButton!
    @IBOutlet weak var player3Button: PlayerButton!
    @IBOutlet weak var player4Button: PlayerButton!
    
    
    var selectedPlayerButton:PlayerButton?
    var selectedActionButton:ActionButton?
    var selectedOutcomeButton:ActionButton?
    var count:Int = 0
    
    var positionIsSelected:Bool = false
    var point:CGPoint = CGPoint()
    
    override func viewDidLoad() {
        
        if ActiveTeam.sharedInstance.activeTeam.count == 0 {
            let alert = UIAlertController(title: "No players selected", message: "Click OK to go to the players page", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in
                self.tabBarController?.selectedViewController = self.tabBarController!.viewControllers?[1]
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        fieldImageView.isUserInteractionEnabled = true
        fieldImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.didTapPosition)))
        
        successButton.addTarget(self, action: #selector(didSelectOutcome(_:)), for: .touchUpInside)
        failButton.addTarget(self, action: #selector(didSelectOutcome(_:)), for: .touchUpInside)
        
        let actionButtonArray:[ActionButton] = [tacklingButton, dribblingButton, distributionButton, communicationButton, shotButton, throughButton, shortButton, longButton]

        for button in actionButtonArray {
            button.addTarget(self, action: #selector(didSelectButton(_:)), for: .touchUpInside)
        }
        
        
        if ActiveTeam.sharedInstance.activeTeam.count > 0 {
            player1Button.player = ActiveTeam.sharedInstance.activeTeam[0]
            if ActiveTeam.sharedInstance.activeTeam.count > 1 {
                player2Button.player = ActiveTeam.sharedInstance.activeTeam[1]
                if ActiveTeam.sharedInstance.activeTeam.count > 2 {
                    player3Button.player = ActiveTeam.sharedInstance.activeTeam[2]
                    if ActiveTeam.sharedInstance.activeTeam.count > 3 {
                        player4Button.player = ActiveTeam.sharedInstance.activeTeam[3]
                    }
                }
            }
        }
        
        let playerButtonArray:[PlayerButton] = [player1Button, player2Button, player3Button, player4Button]
        for button in playerButtonArray {
            button.addTarget(self, action: #selector(didSelectPlayer(_:)), for: .touchUpInside)
        }
    }
    
    @objc func didSelectButton(_ actionButton: ActionButton) {
        if selectedActionButton != nil {
            if actionButton.isSelected {
                count -= 1
                actionButton.isSelected = false
                selectedActionButton = nil
            } else {
                actionButton.isSelected = true
                selectedActionButton!.isSelected = false
                selectedActionButton = actionButton
            }
        } else {
            count += 1
            actionButton.isSelected = true
            selectedActionButton = actionButton
        }
        
        if count == 4 {
            save()
        }
    }
    
    @objc func didSelectOutcome(_ outcomeButton: ActionButton) {
        if selectedOutcomeButton != nil{
            if outcomeButton.isSelected {
                count -= 1
                outcomeButton.isSelected = false
                selectedActionButton = nil
            } else {
                outcomeButton.isSelected = true
                selectedOutcomeButton!.isSelected = false
                selectedOutcomeButton = outcomeButton
            }
        } else {
            count += 1
            outcomeButton.isSelected = true
            selectedOutcomeButton = outcomeButton
        }
        
        if count == 4 {
            save()
        }
    }
    
    @objc func didSelectPlayer(_ playerButton:PlayerButton) {
        if selectedPlayerButton != nil {
            if playerButton.isSelected {
                count -= 1
                playerButton.isSelected = false
                selectedPlayerButton = nil
            } else {
                selectedPlayerButton!.isSelected = false
                selectedPlayerButton!.setNeedsDisplay()
                playerButton.isSelected = true
                selectedPlayerButton = playerButton
            }
        } else {
            count += 1
            playerButton.isSelected = true
            selectedPlayerButton = playerButton
        }

        if count == 4 {
            save()
        }
    }
    
    @objc func didTapPosition(_ tapGestureRecognizer: UITapGestureRecognizer){
        if !positionIsSelected {
            count += 1
        } else {
            for layer in fieldImageView.layer.sublayers! {
                layer.removeFromSuperlayer()
            }
        }
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        point = tapGestureRecognizer.location(in: tappedImage)
        
        CoreGraphicsHelper.init().drawCircle(selectedPosition: point, tappedImage: tappedImage)
        
        if count == 4 {
            save()
        }
    }
    
    func save() {
        CoreDataHelper.init().addStat(ID: (selectedPlayerButton?.player?.objectID)!, startPoint: point, statName: (selectedActionButton?.action)!)
    }
    
    @IBAction func clearSelection(_ sender: Any) {
        count = 0
        if positionIsSelected {
            for layer in fieldImageView.layer.sublayers! {
                layer.removeFromSuperlayer()
            }
            positionIsSelected = false
        }
        if selectedActionButton != nil {
            selectedActionButton!.isSelected = false
            selectedActionButton = nil
        }
        if selectedOutcomeButton != nil {
            
        }
        if selectedPlayerButton != nil {
            
        }
    }
}
