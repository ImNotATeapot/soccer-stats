//
//  Utility.swift
//  Football
//
//  Created by Pearl on 7/12/2560 BE.
//  Copyright © 2560 com. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Utility{
    
//********************************************************************************************
// Drawing
//********************************************************************************************
    
    private var screenHeight:CGFloat = UIScreen.main.bounds.height
    private var screenWidth:CGFloat = UIScreen.main.bounds.width
    
    func drawCircle(selectedPosition:CGPoint, tappedImage:UIImageView) {
        
        let shapeLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: selectedPosition.x,y: selectedPosition.y), radius: CGFloat(5), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        shapeLayer.path = circlePath.cgPath
        //change the fill color
        shapeLayer.fillColor = UIColor.blue.cgColor
        //change the stroke color
        shapeLayer.strokeColor = UIColor.blue.cgColor
        tappedImage.layer.addSublayer(shapeLayer)
    }
    
    func drawArrow(start:CGPoint, end:CGPoint) -> UIBezierPath {
        
        let changeInX:CGFloat = end.x - start.x
        let changeInY:CGFloat = end.y - start.y
        let angle:CGFloat = atan(changeInY/changeInX)
        
        var multiplier:CGFloat = 1
        if changeInX < 0 {
            multiplier = -1
        }
        
        let ARROW_ANGLE:CGFloat = 0.5
        let AcoordX:CGFloat = end.x-multiplier*10.0*cos(angle-ARROW_ANGLE)
        let AcoordY:CGFloat = end.y-multiplier*10.0*sin(angle-ARROW_ANGLE)
        let BcoordX:CGFloat = end.x-multiplier*10.0*cos(angle+ARROW_ANGLE)
        let BcoordY:CGFloat = end.y-multiplier*10.0*sin(angle+ARROW_ANGLE)
        
        let arrowPath = UIBezierPath()
        arrowPath.move(to: start)
        arrowPath.addLine(to:end) //angled to top right
        arrowPath.addLine(to:CGPoint(x:AcoordX, y:AcoordY))
        arrowPath.addLine(to:CGPoint(x:BcoordX, y:BcoordY))
        arrowPath.addLine(to:end)
        arrowPath.close()        
        
        return arrowPath
    }
    
//******************************************************************************************
// Core Data
//******************************************************************************************
    
    let managedContext:NSManagedObjectContext = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
    
    func fetch() -> [NSManagedObject]{
        var arrayTemp:[NSManagedObject] = [NSManagedObject]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PlayerModel")
        do {
            arrayTemp = try managedContext.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return arrayTemp
    }
    
    func fetch(player:NSManagedObject) -> NSManagedObject{
        var object:NSManagedObject = NSManagedObject()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PlayerModel")
        
        let first:String = player.value(forKey: "firstName") as! String
        let number:Int = player.value(forKey: "number") as! Int
        let firstPredicate = NSPredicate(format: "firstName == %@", first)
        let numberPredicate = NSPredicate(format: "number == %@", number)
        let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [firstPredicate, numberPredicate])
        fetchRequest.predicate = andPredicate
        fetchRequest.fetchLimit = 1
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            object = objects[0]
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return object
    }
    
    func delete(ID:NSManagedObjectID){
        //        let entityDescription = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext);
        //        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"PlayerModel")
        //        fetchRequest.predicate = NSPredicate(format: "objectID = %i", ID)
        //        let objects = try! managedContext.fetch(fetchRequest)
        let object = managedContext.object(with: ID)
        managedContext.delete(object)
        
        do {
            try managedContext.save()
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
    }
    
    func save(first:String, last:String, position:String, number:Int) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "PlayerModel", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        person.setValue(first, forKeyPath: "firstName")
        person.setValue(last, forKeyPath: "lastName")
        person.setValue(position, forKeyPath: "position")
        person.setValue(number, forKeyPath: "number")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
