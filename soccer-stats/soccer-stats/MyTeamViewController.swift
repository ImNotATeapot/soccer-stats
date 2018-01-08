//
//  myTeamViewController.swift
//  soccer-stats
//
//  Created by Pearl on 12/26/2560 BE.
//

import UIKit
import Foundation
import CoreData

//TODO implement search bar
class MyTeamViewController: UIViewController {

    var _playerObjects:[NSManagedObject] = [NSManagedObject]()
    var _displayedPlayers:[NSManagedObject] = ActiveTeam.sharedInstance.activeTeam
    
    @IBOutlet weak var _player1Button: PlayerButton!
    @IBOutlet weak var _player2Button: PlayerButton!
    @IBOutlet weak var _player3Button: PlayerButton!
    @IBOutlet weak var _player4Button: PlayerButton!
    
    @IBOutlet weak var _newPlayerNumber: UIPickerView!
    @IBOutlet weak var _newPlayerPosition: UIPickerView!
    @IBOutlet weak var _newPlayerName: UITextField!
    @IBOutlet weak var _cancelNewPlayerButton: UIButton!
    @IBOutlet weak var _confirmNewPlayerButton: UIButton!
    
    @IBOutlet weak var _playersTableView: UITableView!
    
    let _positions:[String] = ["Forward", "Midfielder", "GoalKeeper"]
    var playerButtonArray:[PlayerButton] = []
    
    @IBAction func addPlayer(_ sender: Any) {
        hideNewPlayer(hide:false)
    }
    
    @IBAction func deletePlayer(_ sender: Any) {
        _playersTableView.isEditing ? _playersTableView.setEditing(false, animated: false) : _playersTableView.setEditing(true, animated: false)
    }
    

    @IBAction func confirmNewPlayer(_ sender: Any) {
        if let name = _newPlayerName.text {
            if let index = name.index(of: " ") {
                let nextIndex:String.Index? = name.index(after: index)
                let firstName:String = String(name[..<index])
                let lastName:String = String(name[index...])
                let position:String = _positions[_newPlayerPosition.selectedRow(inComponent: 0)]
                let number:Int = _newPlayerNumber.selectedRow(inComponent: 0) + 1
                
                CoreDataHelper.init().save(first: firstName, last: lastName, position: position, number: number)
                _playerObjects = CoreDataHelper.init().fetch()
                _playersTableView.reloadData()
                
                hideNewPlayer(hide:true)
                
                //TODO: dispatch reload, improve efficiency of fetching
                return
            }
        }
         //you may have messed something up here
            let alert = UIAlertController(title: "Alert", message: "Please enter a first and last name for the new player", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelNewPlayer(_ sender: Any) {
        hideNewPlayer(hide:true)
        _newPlayerNumber.selectRow(0, inComponent: 0, animated: false)
        _newPlayerPosition.selectRow(0, inComponent: 0, animated: false)
        _newPlayerName.text = nil
    }
    
    override func viewDidLoad() {
        _playersTableView.delegate = self
        _playersTableView.dataSource = self
        _newPlayerPosition.delegate = self
        _newPlayerPosition.dataSource = self
        _newPlayerNumber.delegate = self
        _newPlayerNumber.dataSource = self
        
        _playerObjects = CoreDataHelper.init().fetch()
        _playersTableView.reloadData()
        
        _player1Button.number = 0
        _player2Button.number = 1
        _player3Button.number = 2
        _player4Button.number = 3
        
        if _displayedPlayers.count > 0 {
            _player1Button.player = _displayedPlayers[0]
            if _displayedPlayers.count > 1 {
                _player2Button.player = _displayedPlayers[1]
                if _displayedPlayers.count > 2 {
                    _player3Button.player = _displayedPlayers[2]
                    if _displayedPlayers.count > 3 {
                        _player4Button.player = _displayedPlayers[3]
                    }
                }
            }
        }

        
        if _playerObjects.count == 0 {
            let alert = UIAlertController(title: "No players", message: "You can add a player by selecting the + sign above", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        playerButtonArray.append(_player1Button)
        playerButtonArray.append(_player2Button)
        playerButtonArray.append(_player3Button)
        playerButtonArray.append(_player4Button)
        for playerButton in playerButtonArray {
            playerButton.addTarget(self, action: #selector(didSelectPlayerButton(_:)), for: .touchUpInside)
        }
    }
    
    @objc func didSelectPlayerButton(_ playerButton: PlayerButton) {
        if playerButton.player != nil {
            playerButton.player = nil
            _displayedPlayers.remove(at: playerButton.number!)
            /*
            0, 1, 2, 3
            a, b, c, d
             
             selected index 1
             
             0, 1, 2, 3
             a, c, c, d
             
             0, 1, 3, 4
             a, c, d, d
             
             0, 1, 2, 3
             a, c, d
 
 */
            for i in /*start index*/1...2/*end index*/ {
                playerButtonArryay[i].player = playerButtonArray[i+1].player
            }
            for i in /*end index*/2..3 {
                
            
            /*let numberToMoveDown:Int = _displayedPlayers.count - playerButton.number!
            var indexOfPlayerButton:Int = 0
            for i in 0...3 {
                if playerButtonArray[i] == playerButton {
                    indexOfPlayerButton = i
                }
            }
            for i in 0...numberToMoveDown {
                playerButtonArray[i].player = playerButtonArray[i+1].player
            }
            playerButton.setNeedsDisplay()
            if let number = playerButton.number {
                _displayedPlayers[number] = NSManagedObject()
 */
            }
        }
    }
    
    func hideNewPlayer(hide:Bool) {
        _newPlayerName.isHidden = hide
        _newPlayerName.text = nil
        _newPlayerPosition.isHidden = hide
        _newPlayerNumber.isHidden = hide
        _confirmNewPlayerButton.isHidden = hide
        _cancelNewPlayerButton.isHidden = hide
        
        if !hide {
            _newPlayerName.becomeFirstResponder()
        }
    }
}

//TDOO: stop the highlighting
extension MyTeamViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return _playerObjects.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view:UIView = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PlayerCell = tableView.dequeueReusableCell(withIdentifier: "playerCell") as! PlayerCell
        let player:NSManagedObject = _playerObjects[indexPath.section]
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let playerCell:PlayerCell = tableView.cellForRow(at: indexPath) as! PlayerCell
            let player:NSManagedObject = playerCell.player!
            if let playerButton = _player1Button.player {
                if playerButton == player {
                    didSelectPlayerButton(_player1Button)
                }
            } else if let playerButton = _player2Button.player {
                if playerButton == player {
                    didSelectPlayerButton(_player2Button)
                }
            } else if let playerButton = _player3Button.player {
                if playerButton == player {
                    didSelectPlayerButton(_player3Button)
                }
            } else if let playerButton = _player4Button.player {
                if playerButton == player {
                    didSelectPlayerButton(_player4Button)
                }
            }
            let objectID:NSManagedObjectID = player.objectID
            CoreDataHelper.init().delete(ID: objectID)
            _playerObjects.remove(at: indexPath.section)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if _displayedPlayers.count == 0 {
            let playerCell:PlayerCell = tableView.cellForRow(at: indexPath) as! PlayerCell
            _player1Button.player = playerCell.player
            _player1Button.setNeedsDisplay()
            _displayedPlayers.append(playerCell.player!)
        } else if _displayedPlayers.count == 1 {
            let playerCell:PlayerCell = tableView.cellForRow(at: indexPath) as! PlayerCell
            _player2Button.player = playerCell.player
            _player2Button.setNeedsDisplay()
            _displayedPlayers.append(playerCell.player!)
        } else if _displayedPlayers.count == 2 {
            let playerCell:PlayerCell = tableView.cellForRow(at: indexPath) as! PlayerCell
            _player3Button.player = playerCell.player
            _player3Button.setNeedsDisplay()
            _displayedPlayers.append(playerCell.player!)
        } else if _displayedPlayers.count == 3 {
            let playerCell:PlayerCell = tableView.cellForRow(at: indexPath) as! PlayerCell
            _player4Button.player = playerCell.player
            _player4Button.setNeedsDisplay()
            _displayedPlayers.append(playerCell.player!)
        }
    }
    
}

extension MyTeamViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return 99
        } else if pickerView.tag == 2 {
            return _positions.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return String(row + 1)
        } else if pickerView.tag == 2 {
            return _positions[row]
        }
        return ""
    }
}
