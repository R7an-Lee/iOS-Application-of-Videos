//
//  Video.swift
//  Videos
//
//  Modified by Yuxuan Li on 3/29/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import Foundation
import CoreData

// ❎ Core Data Company entity public class
public class Video: NSManagedObject, Identifiable {
    
    @NSManaged public var videoId: String?
    @NSManaged public var orderNumber: NSNumber?
    @NSManaged public var title: String?
    @NSManaged public var videoDescription: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var thumbnailUrl: String?
    @NSManaged public var category: String?
    @NSManaged public var channelTitle: String?
    @NSManaged public var duration: String?
 

}
extension Video{
    /*
     ❎ CoreData @FetchRequest in FavoritesList.swift invokes this class method
        to fetch all of the Company entities from the database.
        The 'static' keyword designates the func as a class method invoked by using the
        class name as Company.allCompaniesFetchRequest() in any .swift file in your project.
     */
    static func allVideosFetchRequest() -> NSFetchRequest<Video> {
        /*
         Create a fetchRequest to fetch Company entities from the database.
         Since the fetchRequest's 'predicate' property is not set to filter,
         all of the Company entities will be fetched.
         */
        let fetchRequest = NSFetchRequest<Video>(entityName: "Video")

        fetchRequest.sortDescriptors = [
            // List the fetched Company entities in ascending order with respect to orderNumber
            NSSortDescriptor(key: "orderNumber", ascending: true)
        ]
        
        return fetchRequest
    }

}

