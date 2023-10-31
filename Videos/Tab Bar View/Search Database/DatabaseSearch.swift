//
//  DatabaseSearch.swift
//  Videos
//  Created by Osman Balci on 3/20/23.
//  Modified by Yuxuan Li on 3/29/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI
import CoreData

var databaseSearchResults = [Video]()

var searchCategory = ""
var searchQuery = ""

fileprivate let managedObjectContext: NSManagedObjectContext = PersistenceController.shared.persistentContainer.viewContext

/*
 =====================
 MARK: Search Database
 =====================
 */
public func conductDatabaseSearch() {
    
    databaseSearchResults = [Video]()
    
    let fetchRequest = NSFetchRequest<Video>(entityName: "Video")
    
    fetchRequest.sortDescriptors = [
        NSSortDescriptor(key: "title", ascending: true),
    ]
    
    switch searchCategory {
    case "All":
            fetchRequest.predicate = NSPredicate(format: "title CONTAINS[c] %@ OR videoDescription CONTAINS[c] %@ OR category CONTAINS[c] %@ OR publishedAt CONTAINS[c] %@ OR channelTitle CONTAINS[c] %@ OR duration CONTAINS[c] %@", searchQuery, searchQuery, searchQuery, searchQuery, searchQuery, searchQuery)
        
    case "Title":
        fetchRequest.predicate = NSPredicate(format: "title CONTAINS[c] %@", searchQuery)
    case "Description":
        fetchRequest.predicate = NSPredicate(format: "videoDescription CONTAINS[c] %@", searchQuery)
    case "Category":
        fetchRequest.predicate = NSPredicate(format: "category CONTAINS[c] %@", searchQuery)
    case "Publication Date":
        fetchRequest.predicate = NSPredicate(format: "publishedAt CONTAINS[c] %@", searchQuery)
    case "Channel Title":
        fetchRequest.predicate = NSPredicate(format: "channelTitle CONTAINS[c] %@", searchQuery)
    case "Duration":
        fetchRequest.predicate = NSPredicate(format: "duration CONTAINS[c] %@", searchQuery)

    default:
        print("Search category is out of range!")
    }
    
    do {
        databaseSearchResults = try managedObjectContext.fetch(fetchRequest)
        
    } catch {
        print("fetchRequest failed!")
    }

}
