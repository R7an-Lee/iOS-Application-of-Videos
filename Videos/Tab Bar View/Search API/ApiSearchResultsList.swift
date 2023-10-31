//
//  ApiSearchResultsList.swift
//  Videos
//
//  Created by Osman Balci on 3/20/23.
//  Modified by Yuxuan Li on 4/1/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI

struct ApiSearchResultsList: View {
    var body: some View {
        List {
            ForEach(nowVideosList, id:\.videoId ) { aVideo in
                NavigationLink(destination: ApiSearchResultDetails(video: aVideo)) {
                    ApiSearchResultItem(video: aVideo)
                }
            }
        }   // End of List
        .navigationBarTitle(Text("Search Result"), displayMode: .inline)
    }
}


struct ApiSearchResultsList_Previews: PreviewProvider {
    static var previews: some View {
        ApiSearchResultsList()
    }
}
