//
//  ApiSearchResultItem.swift
//  Videos
//
//  Created by Osman Balci on 3/20/23.
//  Modified by Yuxuan Li on 4/1/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI

struct ApiSearchResultItem: View {
    
    // Input Parameter
    let video: VideoStruct
    
    var body: some View {
        HStack {
            getImageFromUrl(url: video.thumbnailUrl , defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0)
            
            VStack(alignment: .leading) {
                Text(video.title)
                Text(video.publishedAt)
                Text(video.category)
                Text(video.duration)
            }
            .font(.system(size: 14))
            
        }   // End of HStack
    }
}
