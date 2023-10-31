//
//  FavoriteItem.swift
//  Videos
//
//  Created by Osman Balci on 3/20/23
//  Created by Yuxuan Li on 3/29/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI

struct FavoriteItem: View {
    
    // ✳️ Input parameter: Core Data Video Entity instance reference
    let video: Video
    
    // Subscribe to changes in Core Data database
    @EnvironmentObject var databaseChange: DatabaseChange
    
    var body: some View {
        HStack {
            getImageFromUrl(url: video.thumbnailUrl ?? "", defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0)
            
            VStack(alignment: .leading) {
                Text(video.title ?? "")
                Text(video.publishedAt ?? "")
                Text(video.category ?? "")
                Text(video.duration ?? "")
            }
            // Set font and size for the whole VStack content
            .font(.system(size: 14))
            
        }   // End of HStack
    }
}
