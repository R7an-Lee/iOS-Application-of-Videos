//
//  ApiSearchHome.swift
//  Videos
//
//  Created by Osman Balci on 3/20/23.
//  Modified by Yuxuan Li on 4/3/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//


import SwiftUI

struct ApiSearchHome: View {
    //---------------
    // Alert Messages
    //---------------
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var searchFieldValue = ""
    @State private var searchCompleted = false
    @State private var selectedIndex = 1
    let numberOfSearchResults = ["10","20", "30", "40", "50"]


    var body: some View {
        NavigationView {
            
            Form {
                Section(header: Text("")) {
                    HStack {
                        Spacer()
                        VStack {
                            Image("YouTubeLogo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120)
                        }
                        Spacer()
                    }
                }
                
                Section(header: Text("SELECT NUMBER")) {
                    Picker("", selection: $selectedIndex) {
                        ForEach(0 ..< numberOfSearchResults.count, id: \.self) {
                            Text(numberOfSearchResults[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("ENTER API SEARCH QUERY")) {
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
                }
                
                
                Section(header: Text("Search API")) {
                    HStack {
                        Spacer()
                        Button(searchCompleted ? "Search Completed" : "Search") {
                            if inputDataValidated() {
                                searchAPI()
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
                }
                
                if searchCompleted {
                    Section(header: Text("List YouTube Videos Found")) {
                        NavigationLink(destination: showSearchAPIResults) {
                            HStack {
                                Image(systemName: "list.bullet")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                                Text("List YouTube Videos Found")
                                    .font(.system(size: 16))
                            }
                            .foregroundColor(.blue)
                        }
                    }
                }
                
            }   // End of Form
            .alert(alertTitle, isPresented: $showAlertMessage, actions: {
                Button("OK") {}
            }, message: {
                Text(alertMessage)
            })
        }
    }   // End of body var
    
    
    /*
     -------------------------
     MARK: Show Search Results
     -------------------------
     */
    var showSearchAPIResults: some View {
        if nowVideosList.isEmpty {
            return AnyView(
                NotFound(message: "No Video Found!\n\nThe entered query \(searchFieldValue) did not return any video from the API! Please enter another search query.")
            )
        }
        
        return AnyView(ApiSearchResultsList())
    }
    
    /*
     ----------------
     MARK: Search API
     ----------------
     */
    func searchAPI() {
        // Remove spaces, if any, at the beginning and at the end of the entered search query string
        let queryCleaned = searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Each space in the query should be converted to +
        let queryWithNoSpace = queryCleaned.replacingOccurrences(of: " ", with: "+")
        getVideosFromApi(number:numberOfSearchResults[selectedIndex],query: queryWithNoSpace)
    }
    
    
    
    /*
     ---------------------------
     MARK: Input Data Validation
     ---------------------------
     */
    func inputDataValidated() -> Bool {
        
        // Remove spaces, if any, at the beginning and at the end of the entered search query string
        let queryTrimmed = searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if queryTrimmed.isEmpty {
            return false
        }
        return true
    }
    
}

struct ApiSearchHome_Previews: PreviewProvider {
    static var previews: some View {
        ApiSearchHome()
    }
}
