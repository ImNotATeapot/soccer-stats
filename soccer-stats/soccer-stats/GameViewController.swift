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

class GameViewController:UIViewController, ActionButtonDelegate {
    
    @IBOutlet weak var fieldImageView: UIImageView!
    @IBOutlet weak var failButton: ActionButton!
    @IBOutlet weak var successButton: ActionButton!
    @IBOutlet weak var assistButton: ActionButton!
    @IBOutlet weak var interceptionButton: ActionButton!
    @IBOutlet weak var headerButton: ActionButton!
    @IBOutlet weak var tackleButton: ActionButton!
    @IBOutlet weak var shotButton: ActionButton!
    @IBOutlet weak var passButton: ActionButton!
    var buttonArray:[ActionButton] = [ActionButton]()
    
    var positionIsSelected:Bool = false;
    var actionIsSelected:Bool = false;
    var playerIsSelected:Bool = false;
    var outcomeIsSelected:Bool = false;
    
    var selectedPosition:CGPoint = CGPoint(x: 0.0, y: 0.0)
    var selectedPlayer:Player = Player()
    var selectedActionButton:ActionButton = ActionButton()
    var selectedOutcome:ActionButton = ActionButton()
    var count:Int = 0
    
    var arrow:CAShapeLayer = CAShapeLayer()
    var startPoint:CGPoint = CGPoint()
    var endPoint:CGPoint = CGPoint()
    
    var displayedPlayers:[NSManagedObject] = ActiveTeam.sharedInstance.activeTeam
    
    func didSelectButton(_ actionButton: ActionButton) {
        if actionIsSelected {
            if actionButton.isSelected {
                count -= 1
                actionIsSelected = false
                actionButton.isSelected = false
                actionButton.checkState()
                selectedActionButton = ActionButton()
            } else {
                actionButton.isSelected = true
                actionButton.checkState()
                selectedActionButton.isSelected = false
                selectedActionButton.checkState()
                selectedActionButton = actionButton
            }
        } else {
            count += 1
            actionIsSelected = true
            actionButton.isSelected = true
            actionButton.checkState()
            selectedActionButton = actionButton
        }
        
        if count == 4 {
            save()
        }
    }
    
    
    override func viewDidLoad() {
        fieldImageView.isUserInteractionEnabled = true
        fieldImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.positionTapped)))
        fieldImageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.positionPanned)))
        
        successButton.color = UIColor(red: 81/255, green: 167/255, blue: 249/255, alpha: 1.0)
        failButton.color = UIColor(red: 236/255, green: 93/255, blue: 87/255, alpha: 1.0)
        
        buttonArray.append(assistButton)
        buttonArray.append(interceptionButton)
        buttonArray.append(headerButton)
        buttonArray.append(tackleButton)
        buttonArray.append(shotButton)
        buttonArray.append(passButton)
        
        for button in buttonArray {
            button.ActionButtonDelegate = self
        }
    }
    
    @objc func positionTapped(_ tapGestureRecognizer: UITapGestureRecognizer){
        if positionIsSelected == false {
            positionIsSelected = true
            count += 1
        } else {
            for layer in fieldImageView.layer.sublayers! {
                layer.removeFromSuperlayer()
            }
        }
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        selectedPosition = tapGestureRecognizer.location(in: tappedImage)
        
        CoreGraphicsHelper.init().drawCircle(selectedPosition: selectedPosition, tappedImage: tappedImage)
        
        if count == 4 {
            save()
        }
    }
    
    func save() {
        //TODO: implement this
    }
    
    @objc func positionPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
        
        let location = panGestureRecognizer.location(in: fieldImageView)
        var arrowPath:UIBezierPath = UIBezierPath()
        
        switch panGestureRecognizer.state {
        case .began :

            if positionIsSelected == false {
                positionIsSelected = true
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
    }
    
    @IBAction func clearSelection(_ sender: Any) {
        count = 0
        if positionIsSelected {
            for layer in fieldImageView.layer.sublayers! {
                layer.removeFromSuperlayer()
            }
        }
        if actionIsSelected {
            actionIsSelected = false
            selectedActionButton.isSelected = false
            selectedActionButton.checkState()
            selectedActionButton = ActionButton()
            
        }
        if playerIsSelected {
            
        }
    }
}
