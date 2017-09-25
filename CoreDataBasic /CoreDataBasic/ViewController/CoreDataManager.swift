//
//  CoreDataManager.swift
//  CoreDataBasic
//
//  Created by Gurdeep on 23/09/17.
//  Copyright © 2017 Appinventiv Technologies. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    class func save(entityName : String, enterData:[String:String])  {
        
        var person: Person?
        if person == nil {
            
            let personEntity = NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
            person = Person(entity: personEntity!, insertInto: managedObjectContext)
            
        }
        
        person?.name = enterData["name"]
        person?.email = enterData["email"]
        person?.contact = enterData["contact"]
        person?.city = enterData["city"]
        
        do{
            
            try managedObjectContext.save()
            
        }
        catch{
            
        }
        
    }
    
    class func fetch() -> [Person] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = Person.personFetchRequest()
        request.returnsObjectsAsFaults = false
        
        var personArray = [Person]()
        
        do {
            let results = try context.fetch(request)
            
            for result in results {
                
                personArray.append(result)
            }
            
        } catch {
            
        }
        
        return personArray
    }
}
