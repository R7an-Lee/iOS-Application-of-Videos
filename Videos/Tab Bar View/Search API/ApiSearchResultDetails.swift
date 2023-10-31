//
//  ApiSearchResultDetails.swift
//  Videos
//
//  Created by Osman Balci on 3/20/23.
//  Created by Yuxuan Li on 4/1/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI
import CoreData

struct ApiSearchResultDetails: View {
    //---------------
    // Alert Messages
    //---------------
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    let video: VideoStruct
    
    // Enable this view to be dismissed to go back to the previous view
    @Environment(\.dismiss) private var dismiss
    
    // ✳️ Core Data managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // ❎ Core Data FetchRequest returning all Video entities from the database
    @FetchRequest(fetchRequest: Video.allVideosFetchRequest()) var allVideos: FetchedResults<Video>
    
    // Subscribe to changes in Core Data database
    @EnvironmentObject var databaseChange: DatabaseChange
    

    
    var body: some View {
        Form {
            Group {
                Section(header: Text("VIDEO TITLE")) {
                    Text(video.title)
                }
                
                Section(header: Text("VIDEO THUMBNAIL IMAGE")) {
                    // Public function getImageFromUrl is given in UtilityFunctions.swift
                    getImageFromUrl(url: video.thumbnailUrl, defaultFilename: "ImageUnavailable")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 300, maxWidth: 500, alignment: .center)
                    
                }
                
                Section(header: Text("VIDEO DESCRIPTION")) {
                    Text(video.description)
                }
                
                Section(header: Text("PLAY VIDEO")) {
                    NavigationLink(destination: WebView(url: "http://www.youtube.com/embed/\(video.videoId)"))
                    {
                        HStack {
                            Image(systemName: "play.rectangle.fill")
                                .foregroundColor(.red)
                                .font(Font.title.weight(.regular))
                            Text("Play YouTube Video")
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                
                Section(header: Text("VIDEO DURATION")) {
                    Text(video.duration)
                }
                
                Section(header: Text("VIDEO RELEASE DATE AND TIME")) {
                    Text(video.publishedAt)
                }
                Section(header: Text("VIDEO CATEGORY")) {
                    Text(video.category)
                }
                Section(header: Text("VIDEO CHANNEL TITLE")) {
                    Text(video.channelTitle)
                }
                Section(header: Text("ADD VIDEO TO DATABASE AS A FAVORITE")) {
                    Button(action: {
                        saveVideoToDatabaseAsFavorite()
                        
                        showAlertMessage = true
                        alertTitle = "Video Added!"
                        alertMessage = "Selected video is added to your database as favorite."
                    }) {
                        HStack {
                            Image(systemName: "plus")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                            Text("Add Video to Database")
                                .font(.system(size: 16))
                        }
                        .foregroundColor(.blue)
                    }
                }  //end of section
                
            }  //end of group1
            
        }   // End of Form
        .navigationBarTitle(Text("YouTube Video Details"), displayMode: .inline)
        .font(.system(size: 14))
        
        .alert(alertTitle, isPresented: $showAlertMessage, actions: {
            Button("OK") {
                if alertTitle == "Video Added!" {
                    // Dismiss this view and go back to the previous view
                    dismiss()
                }
            }
        }, message: {
            Text(alertMessage)
        })
    }   // End of body var

    /*
     ----------------------------------------
     MARK: Save Video to Database as Favorite
     ----------------------------------------
     */
    func saveVideoToDatabaseAsFavorite() {
        
        // 1️⃣ Create an instance of the Video entity in managedObjectContext
        let videoEntity = Video(context: managedObjectContext)
        
        // 2️⃣ Dress it up by specifying its attributes
        videoEntity.orderNumber = (allVideos.count + 1) as NSNumber
        videoEntity.title = video.title
        videoEntity.videoId = video.videoId
        videoEntity.videoDescription = video.description
        videoEntity.publishedAt = video.publishedAt
        videoEntity.thumbnailUrl = video.thumbnailUrl
        videoEntity.category = video.category
        videoEntity.channelTitle = video.channelTitle
        videoEntity.duration = video.duration
        
        // 3️⃣ It has no relationship to another Entity
        
        // ❎ Save Changes to Core Data Database
        PersistenceController.shared.saveContext()
        
        // Toggle database change indicator so that its subscribers can refresh their views
        databaseChange.indicator.toggle()
    }
    
}
