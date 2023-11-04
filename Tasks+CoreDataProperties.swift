//
//  Tasks+CoreDataProperties.swift
//  3-ToDoTask
//
//  Created by Yorgi Del Rio on 10/20/23.
//
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var task: String?
    @NSManaged public var done: Bool

}

extension Tasks : Identifiable {

}
