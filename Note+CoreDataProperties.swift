//
//  Note+CoreDataProperties.swift
//  GiorgiPilishvili_Homework26
//
//  Created by GIORGI PILISSHVILI on 26.08.22.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var date: Date?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var id: UUID?

}

extension Note : Identifiable {

}
