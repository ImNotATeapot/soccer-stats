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
    @IBOutlet weak var assistButton: ActionButton!
    @IBOutlet weak var interceptionButton: ActionButton!
    @IBOutlet weak var headerButton: ActionButton!
    @IBOutlet weak var tackleButton: ActionButton!
    @IBOutlet weak var shotButton: ActionButton!
    @IBOutlet weak var passButton: ActionButton!
    @IBOutlet weak var player1Button: PlayerButton!
    @IBOutlet weak var player2Button: PlayerButton!
    @IBOutlet weak var player3Button: PlayerButton!
    @IBOutlet weak var player4Button: PlayerButton!
    
    
    var actionButtonArray:[ActionButton] = [ActionButton]()
    var playerButtonArray:[PlayerButton] = [PlayerButton]()
    
    var selectedPlayerButton:PlayerButton?
    var selectedActionButton:ActionButton?
    var selectedOutcomeButton:ActionButton?
    var count:Int = 0
    
    var positionIsSelected:Bool = false
    var isCircle:Bool = true
    var arrow:CAShapeLayer = CAShapeLayer()
    var startPoint:CGPoint = CGPoint()
    var endPoint:CGPoint = CGPoint()
    
    override func viewDidLoad() {
        fieldImageView.isUserInteractionEnabled = true
        fieldImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.didTapPosition)))
        fieldImageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.didPanPosition)))
        
        successButton.addTarget(self, action: #selector(didSelectOutcome(_:)), for: .touchUpInside)
        failButton.addTarget(self, action: #selector(didSelectOutcome(_:)), for: .touchUpInside)
        
        actionButtonArray.append(assistButton)
        actionButtonArray.append(interceptionButton)
        actionButtonArray.append(headerButton)
        actionButtonArray.append(tackleButton)
        actionButtonArray.append(shotButton)
        actionButtonArray.append(passButton)
        
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
        playerButtonArray.append(player1Button)
        playerButtonArray.append(player2Button)
        playerButtonArray.append(player3Button)
        playerButtonArray.append(player4Button)
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
        isCircle = true
        if !positionIsSelected {
            count += 1
        } else {
            for layer in fieldImageView.layer.sublayers! {
                layer.removeFromSuperlayer()
            }
        }
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        startPoint = tapGestureRecognizer.location(in: tappedImage)
        
        CoreGraphicsHelper.init().drawCircle(selectedPosition: startPoint, tappedImage: tappedImage)
        
        if count == 4 {
            save()
        }
    }
    
    @objc func didPanPosition(_ panGestureRecognizer: UIPanGestureRecognizer) {
        isCircle = false
        let location = panGestureRecognizer.location(in: fieldImageView)
        var arrowPath:UIBezierPath = UIBezierPath()
        
        switch panGestureRecognizer.state {
        case .began :

            if !positionIsSelected {
                count += 1
            } else {
                for layer in fieldImageView.layer.sublayers! {
                    layer.removeFromSuperlayer()
                }
            }

            startPoint = location
            arrowPath = CoreGraphicsHelper.init().drawArrow(start: startPoint, end: CGPoint(x: startPoint.x+1, y: startPoint.y+1))
            
            let arrowShape = CAShapeLayer()
            arrowShape.path = arrowPath.cgPath
            arrowShape.fillColor = UIColor.blue.cgColor
            arrowShape.strokeColor = UIColor.blue.cgColor
            
            arrow = arrowShape
            fieldImageView.layer.addSublayer(arrow)
        case .changed :
            endPoint = location
            arrowPath = CoreGraphicsHelper.init().drawArrow(start: startPoint, end: endPoint)
            arrow.path = arrowPath.cgPath
        case .ended :
            endPoint = location
            arrowPath = CoreGraphicsHelper.init().drawArrow(start: startPoint, end: endPoint)
            arrow.path = arrowPath.cgPath
        default: break
        }
        
        if count == 4 {
            save()
        }
    }
    
    func save() {
        CoreDataHelper.init().addStat(ID: (selectedPlayerButton?.player?.objectID)!, startPoint: startPoint, endPoint: endPoint, statName: (selectedActionButton?.action)!, isCircle: isCircle)
    }
    
    @IBAction func clearSelection(_ sender: Any) {
        count = 0
        if positionIsSelected {
            for layer in fieldImageView.layer.sublayers! {
                layer.removeFromSuperlayer()
            }
            positionIsSelected = false
            isCircle = false
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
