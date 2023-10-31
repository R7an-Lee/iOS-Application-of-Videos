//
//  SearchResultDetails.swift
//  Videos
//
//  Created by Osman Balci on 3/20/23.
//  Created by Yuxuan Li on 4/1/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI

struct SearchResultDetails: View {
    
    let video: Video
    
    //---------------
    // Alert Messages
    //---------------
    @State private var showAlertMessage = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        Form {
            Group {
                
                Section(header: Text("VIDEO TITLE")) {
                    Text(video.title ?? "")
                }
                
                Section(header: Text("VIDEO THUMBNAIL IMAGE")) {
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
                } // end of Section
                
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
        .navigationBarTitle(Text("Details"), displayMode: .inline)
        .font(.system(size: 14))
        
    }   // end of body var
}

