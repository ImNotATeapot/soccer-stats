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
