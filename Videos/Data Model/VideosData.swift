//
//  VideosData.swift
//  Videos
//
//  Created by Yuxuan Li on 3/29/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI
import CoreData

public func createVideosDatabase() {

    // ❎ Get object reference of Core Data managedObjectContext from the persistent container
    let managedObjectContext = PersistenceController.shared.persistentContainer.viewContext
    
    //----------------------------
    // ❎ Define the Fetch Request
    //----------------------------
    let fetchRequest = NSFetchRequest<Video>(entityName: "Video")
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    
    var listOfAllVideoEntitiesInDatabase = [Video]()
    
    do {
        //-----------------------------
        // ❎ Execute the Fetch Request
        //-----------------------------
        listOfAllVideoEntitiesInDatabase = try managedObjectContext.fetch(fetchRequest)
    } catch {
        print("Database Creation Failed!")
        return
    }
    
    if listOfAllVideoEntitiesInDatabase.count > 0 {
        print("Database has already been created!")
        return
    }
    
    print("Database will be created!")
    
    // Local variable arrayOfMovieStructs obtained from the JSON file to create the database
    var arrayOfVideoStructs = [VideoStruct]()
    
    arrayOfVideoStructs = decodeJsonFileIntoArrayOfStructs(fullFilename: "VideosData.json", fileLocation: "Main Bundle")

    for aVideo in arrayOfVideoStructs {
        /*
         =============================
         *   Video Entity Creation   *
         =============================
         */
        
        // 1️⃣ Create an instance of the Video entity in managedObjectContext
        let VideoEntity = Video(context: managedObjectContext)
        
        // 2️⃣ Dress it up by specifying its attributes
        VideoEntity.orderNumber = aVideo.orderNumber as NSNumber
        VideoEntity.title = aVideo.title
        VideoEntity.videoDescription = aVideo.description
        VideoEntity.publishedAt = aVideo.publishedAt
        VideoEntity.category = aVideo.category
        VideoEntity.channelTitle = aVideo.channelTitle
        VideoEntity.duration = aVideo.duration
        VideoEntity.thumbnailUrl = aVideo.thumbnailUrl
        VideoEntity.videoId = aVideo.videoId
        
        // 3️⃣ It has no relationship to another Entity
        
        /*
         *************************************
         ❎ Save Changes to Core Data Database
         *************************************
         */
        
        // The saveContext() method is given in Persistence.
        PersistenceController.shared.saveContext()
        
    }   // End of for loop

}
