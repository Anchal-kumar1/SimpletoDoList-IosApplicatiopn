//
//  ToDoList+CoreDataProperties.swift
//  DemotodoList
//
//  Created by Anchal on 05/06/23.
//
//

import Foundation
import CoreData


extension ToDoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoList> {
        return NSFetchRequest<ToDoList>(entityName: "ToDoList")
    }

    @NSManaged public var name: String?
    @NSManaged public var date: Date?

}

extension ToDoList : Identifiable {

}
