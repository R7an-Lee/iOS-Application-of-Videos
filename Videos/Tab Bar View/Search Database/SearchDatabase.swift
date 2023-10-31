//
//  SearchDatabase.swift
//  Videos
//
//  Created by Osman Balci on 3/20/23.
//  Created by Yuxuan Li on 4/1/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI

struct SearchDatabase: View {
    
    
    //---------------
    // Alert Messages
    //---------------
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var searchFieldValue = ""
    @State private var searchCompleted = false
    @State private var selectedIndex = 3
    let searchCategories = ["Title", "Description", "Category", "Publication Date", "Channel Title", "Duration", "All"]

    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
            Form {
                Section(header: Text("")) {
                    HStack {
                        Spacer()
                        VStack {
                            Image("SearchDatabase")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 80)
                        }
                        Spacer()
                    }
                }  // end of section
                
                Section(header: Text("Select A SEARCH CATEGORY")) {
                    Picker("", selection: $selectedIndex) {
                        ForEach(0 ..< searchCategories.count, id: \.self) {
                            Text(searchCategories[$0])
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                }  //end of section
                
                Section(header: Text("Search Query")) {
                    HStack {
                        TextField("Enter Search Query", text: $searchFieldValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                        // Button to clear the text field
                        Button(action: {
                            searchCompleted = false
                            searchFieldValue = ""
                        }) {
                            Image(systemName: "clear")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                        
                    }   // End of HStack
                }  //end of section
                
                
                Section(header: Text("Search Database")) {
                    HStack {
                        Spacer()
                        Button(searchCompleted ? "Search Completed" : "Search") {
                            if inputDataValidated() {
                                searchDB()
                                searchCompleted = true
                            } else {
                                showAlertMessage = true
                                alertTitle = "Missing Input Data!"
                                alertMessage = "Please enter a database search query!"
                            }
                        }
                        .tint(.blue)
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.capsule)
                        
                        Spacer()
                    }   // End of HStack
                }  //end of search database section
                if searchCompleted {
                    Section(header: Text("List Videos Found")) {
                        NavigationLink(destination: showSearchResults) {
                            HStack {
                                Image(systemName: "list.bullet")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                                Text("List Videos Found")
                                    .font(.system(size: 16))
                            }
                            .foregroundColor(.blue)
                        }
                    }
                }

            }   // end of Form
                .navigationBarTitle(Text("Search Database"), displayMode: .inline)
                .alert(alertTitle, isPresented: $showAlertMessage, actions: {
                      Button("OK") {}
                    }, message: {
                      Text(alertMessage)
                    })
                
            }   // end of ZStack
            
        }   // end of NavigationView
            .customNavigationViewStyle()
        
    }   // end of body var
    
    
    
    
    /*
     -------------------------
     MARK: Show Search Results
     -------------------------
     */
    var showSearchResults: some View {
        
        // Global array databaseSearchResults is given in DatabaseSearch.swift
        if databaseSearchResults.isEmpty {
            return AnyView(
                NotFound(message: "Database Search Produced No Results!\n\nThe database did not return any value for the given search query!")
            )
        }
        
        return AnyView(SearchResultsList())
    }
    
    /*
     ---------------------
     MARK: Search Database
     ---------------------
     */
    func searchDB() {
        // Remove spaces
        let queryTrimmed = searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        /*
         searchCategory and searchQuery are global search parameters defined in DatabaseSearch.swift
         */
        searchCategory = searchCategories[selectedIndex]
        searchQuery = queryTrimmed

        // Public function conductDatabaseSearch is given in DatabaseSearch.swift
        conductDatabaseSearch()
    }
    
    
    
    /*
     ---------------------------
     MARK: Input Data Validation
     ---------------------------
     */
    func inputDataValidated() -> Bool {
        
        // Remove spaces
        let queryTrimmed = searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if queryTrimmed.isEmpty {
            return false
        }
        
        return true
    }
    
}

struct SearchDatabase_Previews: PreviewProvider {
    static var previews: some View {
        SearchDatabase()
    }
}

