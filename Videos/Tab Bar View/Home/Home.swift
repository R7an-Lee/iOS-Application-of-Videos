//
//  Home.swift
//  Videos
//
//  Modified by Yuxuan Li on 3/29/23.
//  Created by Osman Balci on 3/20/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//
import SwiftUI

fileprivate let imageNames = ["photo1", "photo2", "photo3", "photo4", "photo5", "photo6", "photo7", "photo8", "photo9"]
fileprivate let numberOfImages = 9
fileprivate let imageCaptions = ["Technology is best when it brings people together – Matt Mullenweg, Social Media Entrepreneur", "It has become appallingly obvious that our technology has exceeded our humanity – Albert Einstein, Scientist", "It is only when they go wrong that machines remind you how powerful they are – Clive James, Broadcaster and Journalist", "The Web as I envisaged it, we have not seen it yet. The future is still so much bigger than the past – Tim Berners-Lee, Inventor of the World Wide Web", "If it keeps up, man will atrophy all his limbs but the push-button finger – Frank Lloyd Wright, Architect", "Once a new technology rolls over you, if you're not part of the steamroller, you're part of the road – Stewart Brand, Writer", "It is not a faith in technology. It is faith in people – Steve Jobs, Co-founder of Apple", "Technology is a useful servant but a dangerous master – Christian Lous Lange, Historian", "The advance of technology is based on making it fit in so that you don't really even notice it, so it's part of everyday life – Bill Gates, Co-founder of Microsoft"]



struct Home: View {
    
    @State private var index = 0
    @State private var timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {

        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Image("Welcome")
                    .padding()
                
                Image(imageNames[index])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: 300, maxWidth: 500, alignment: .center)
                    .padding()
                
                // Subscribe to the timer publisher
                    .onReceive(timer) { _ in
                        index += 1
                        if index > numberOfImages - 1 {
                            index = 0
                        }
                    }
                
                Text(imageCaptions[index])
                    .font(.system(size: 14, weight: .light, design: .serif))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                Text("Powered By")
                    .font(.system(size: 18, weight: .light, design: .serif))
                    .italic()
                    .padding(.top, 30)
                    .padding(.bottom, 20)
                Link(destination: URL(string: "https://developers.google.com/youtube/v3")!) {
                    HStack {
                        Image("YouTubeLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        Text("YouTube Data API")
                    }  // End of HStack
                }

                
            }   // End of VStack
            
        }   // End of ScrollView
        .onAppear() {
            startTimer()
        }
        .onDisappear() {
            stopTimer()
        }

    }   // End of body var
    
    func startTimer() {
        timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    }
    
    func stopTimer() {
        timer.upstream.connect().cancel()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

