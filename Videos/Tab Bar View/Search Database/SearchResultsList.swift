//
//  SearchResultsList.swift
//  Videos
//  Created by Osman Balci on 3/20/23.
//  Modified by Yuxuan Li on 3/29/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI

struct SearchResultsList: View {
    var body: some View {
        
        List {
            ForEach(databaseSearchResults) { aVideo in
                NavigationLink(destination: SearchResultDetails(video: aVideo)) {
                    SearchResultItem(video: aVideo)
                }
            }
        }
        .navigationBarTitle(Text("Database Search Results"), displayMode: .inline)
    }
}

struct SearchResultsList_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsList()
    }
}
