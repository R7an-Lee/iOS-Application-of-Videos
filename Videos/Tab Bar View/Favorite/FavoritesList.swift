//
//  FavoriteList.swift
//  Videos
//
//  Created by Osman Balci on 3/20/23.
//  Modified by Yuxuan Li on 3/29/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI
import CoreData

struct FavoritesList: View {
    
    // ❎ Core Data managedObjectContext reference
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // ❎ Core Data FetchRequest returning all Video entities from the database
    @FetchRequest(fetchRequest: Video.allVideosFetchRequest()) var allVideos: FetchedResults<Video>
    
    // Subscribe to changes in Core Data database
    @EnvironmentObject var databaseChange: DatabaseChange
    
    @State private var toBeDeleted: IndexSet?
    @State private var showConfirmation = false
    
    var body: some View {
        NavigationView {
            List {
                /*
                 Each NSManagedObject has internally assigned unique ObjectIdentifier
                 used by ForEach to display the Videos in a dynamic scrollable list.
                 */
                ForEach(allVideos) { aVideo in
                    NavigationLink(destination: FavoriteDetails(video: aVideo)) {
                        FavoriteItem(video: aVideo)
                            .alert(isPresented: $showConfirmation) {
                                Alert(title: Text("Delete Confirmation"),
                                      message: Text("Are you sure to permanently delete the video? It cannot be undone."),
                                      primaryButton: .destructive(Text("Delete")) {
                                    /*
                                    'toBeDeleted (IndexSet).first' is an unsafe pointer to the index number of the array
                                     element to be deleted. It is nil if the array is empty. Process it as an optional.
                                    */
                                    if let index = toBeDeleted?.first {
                                       
                                        let voiceToDelete = allVideos[index]
                                        
                                        // ❎ Delete Selected video entity from the database
                                        managedObjectContext.delete(voiceToDelete)

                                        // ❎ Save Changes to Core Data Database
                                        PersistenceController.shared.saveContext()
                                        
                                        // Toggle database change indicator so that its subscribers can refresh their views
                                        databaseChange.indicator.toggle()
                                    }
                                    toBeDeleted = nil
                                }, secondaryButton: .cancel() {
                                    toBeDeleted = nil
                                }
                            )
                        }   // End of alert
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
                
            }   // End of List
            .navigationBarTitle(Text("Favorites"), displayMode: .inline)
            
            // Place the Edit button on left of the navigation bar
            .navigationBarItems(leading: EditButton())
            
        }   // End of NavigationView
        .customNavigationViewStyle()  // Given in NavigationStyle
        
    }   // End of body
    
    /*
     ---------------------------
     MARK: Delete Selected Video
     ---------------------------
     */
    func delete(at offsets: IndexSet) {
        
         toBeDeleted = offsets
         showConfirmation = true
     }
    
    /*
     -------------------------
     MARK: Move Selected Video
     -------------------------
     */
    private func move(from source: IndexSet, to destination: Int) {
        
        // Create an array of Video entities from allVideos fetched from the database
        var arrayOfAllVideos: [Video] = allVideos.map{ $0 }

        // ❎ Perform the move operation on the array
        arrayOfAllVideos.move(fromOffsets: source, toOffset: destination )

        /*
         'stride' returns a sequence from a starting value toward, and possibly including,
         an end value, stepping by the specified amount.
         
         Update the orderNumber attribute in reverse order starting from the end toward the first.
         */
        for index in stride(from: arrayOfAllVideos.count - 1, through: 0, by: -1) {
            
            arrayOfAllVideos[index].orderNumber = Int32(index) as NSNumber
        }
        
        // ❎ Save Changes to Core Data Database
        PersistenceController.shared.saveContext()
        
        // Toggle database change indicator so that its subscribers can refresh their views
        databaseChange.indicator.toggle()
    }
    
}   // End of struct


struct FavoritesList_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesList()
    }
}
