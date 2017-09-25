//
//  Person+CoreDataProperties.swift
//  CoreDataBasic
//
//  Created by Gurdeep on 23/09/17.
//  Copyright © 2017 Appinventiv Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func personFetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var city: String?
    @NSManaged public var contact: String?
    @NSManaged public var email: String?
    @NSManaged public var name: String?

}
