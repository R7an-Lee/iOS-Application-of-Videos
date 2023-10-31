//
//  FavoriteDetails.swift
//  Videos
//  Created by Osman Balci on 3/20/23.
//  Modified by Yuxuan Li on 3/29/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI

struct FavoriteDetails: View {
    
    let video: Video
    
    
    var body: some View {
        Form {
            Group {
                Section(header: Text("VIDEO TITLE")) {
                    Text(video.title ?? "")
                }
                
                Section(header: Text("VIDEO THUMBNAIL IMAGE")) {
                    // Public function getImageFromUrl is given in UtilityFunctions.swift
                    getImageFromUrl(url: video.thumbnailUrl ?? "", defaultFilename: "ImageUnavailable")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 300, maxWidth: 500, alignment: .center)
                    
                }
                
                Section(header: Text("VIDEO DESCRIPTION")) {
                    Text(video.videoDescription ?? "")
                }
                
                Section(header: Text("PLAY VIDEO")) {
                    NavigationLink(destination: WebView(url: "http://www.youtube.com/embed/\(video.videoId ?? "")"))
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
                    Text(video.duration ?? "")
                }
                
                Section(header: Text("VIDEO RELEASE DATE AND TIME")) {
                    Text(video.publishedAt ?? "")
                }
                
                Section(header: Text("VIDEO CATEGORY")) {
                    Text(video.category ?? "")
                }
                
                Section(header: Text("VIDEO CHANNEL TITLE")) {
                    Text(video.channelTitle ?? "")
                }
                
            }
            
        }   // end of Form
        .navigationBarTitle(Text("Video Details"), displayMode: .inline)
        .font(.system(size: 14))
        
    }   // end of body var
}

