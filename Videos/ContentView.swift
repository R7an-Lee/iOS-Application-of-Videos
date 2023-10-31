//
//  ContentView.swift
//  Videos
//
//  Created by Yuxuan Li on 3/29/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            FavoritesList()
                .tabItem{
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
            SearchDatabase()
                .tabItem{
                    Image(systemName: "magnifyingglass")
                    Text("Search Database")
                }
            ApiSearchHome()
                .tabItem{
                    Image(systemName: "magnifyingglass.circle")
                    Text("Search API")
                }
            Settings()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            
        } 
            .font(.headline)
            .imageScale(.medium)
            .font(Font.title.weight(.regular))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
