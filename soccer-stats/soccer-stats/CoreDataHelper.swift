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

class CoreDataHelper{
     
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
    
    func fetch(ID:NSManagedObjectID) -> NSManagedObject {
        let object = managedContext.object(with: ID)
        return object
    }
    
    func delete(ID:NSManagedObjectID) {
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
        
        let statEntity = NSEntityDescription.entity(forEntityName: "StatModel", in: managedContext)!
        let passStatObject = NSManagedObject(entity: statEntity, insertInto: managedContext)
        passStatObject.setValue("pass", forKey: "name")
        let tackleStatObject = NSManagedObject(entity: statEntity, insertInto: managedContext)
        tackleStatObject.setValue("tackle", forKey: "name")
        let headerStatObject = NSManagedObject(entity: statEntity, insertInto: managedContext)
        headerStatObject.setValue("header", forKey: "name")
        let goalStatObject = NSManagedObject(entity: statEntity, insertInto: managedContext)
        goalStatObject.setValue("goal", forKey: "name")
        let interceptionStatObject = NSManagedObject(entity: statEntity, insertInto: managedContext)
        interceptionStatObject.setValue("interception", forKey: "name")
        let assistStatObject = NSManagedObject(entity: statEntity, insertInto: managedContext)
        assistStatObject.setValue("assist", forKey: "name")
        
        person.setValue(NSSet(objects: passStatObject, tackleStatObject, headerStatObject, goalStatObject, interceptionStatObject, assistStatObject), forKey: "hasStats")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            //TODO: implement alert
        }
    }
    
    func addStat(ID:NSManagedObjectID, startPoint:CGPoint, endPoint:CGPoint, statName:String, isCircle:Bool) {
        let pointEntity = NSEntityDescription.entity(forEntityName: "PointModel", in: managedContext)!
        let lineEntity = NSEntityDescription.entity(forEntityName: "LineModel", in: managedContext)!
        let statEntity = NSEntityDescription.entity(forEntityName: "StatModel", in: managedContext)!

        let startPointObject:NSManagedObject = NSManagedObject(entity: pointEntity, insertInto: managedContext)
        startPointObject.setValue(Float(startPoint.x), forKey: "coordX")
        startPointObject.setValue(Float(startPoint.y), forKey: "coordY")

        let person:NSManagedObject = managedContext.object(with: ID)
        let stat:NSManagedObject = person.value(forKey: "hasStats") as! NSManagedObject
        
        if !isCircle {
            let endPointObject:NSManagedObject = NSManagedObject(entity: pointEntity, insertInto: managedContext)
            endPointObject.setValue(Float(endPoint.x), forKey: "coordX")
            endPointObject.setValue(Float(endPoint.y), forKey: "coordY")
            
            let lineObject:NSManagedObject = NSManagedObject(entity: lineEntity, insertInto: managedContext)
            lineObject.setValue(NSSet(objects: startPointObject, endPointObject), forKey: "hasPoints")
            let lines = stat.mutableSetValue(forKey: "hasLines")
            lines.add(lineObject)
        } else {
            let points = stat.mutableSetValue(forKey: "hasPoints")
            points.add(startPointObject)
        }
    }
}
