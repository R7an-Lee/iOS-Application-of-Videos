//
//  VideoStruct.swift
//  Videos
//
//  Created by Yuxuan Li on 3/29/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import SwiftUI

struct VideoStruct: Decodable, Hashable {

    
    var orderNumber: Int32
    var videoId: String        // Storage Type: String, Use Type (format): UUID
    var title: String
    var description: String
    var publishedAt: String
    var thumbnailUrl: String
    var category: String
    var channelTitle: String
    var duration: String
}

/*
 {
     "orderNumber": 1,
     "videoId": "6-kviptjtXk",
     "title": "Apple Park: The New $5 Billion Headquarters",
     "description": "In this video, we go over the new Apple Campus 2 in Cupertino, California. For more Apple Headquarters, megaproject, and engineering content be sure to subscribe to Top Luxury. Thanks for watching this video.",
     "publishedAt": "2020-09-25 11:40:57",
     "thumbnailUrl": "https://i.ytimg.com/vi/6-kviptjtXk/mqdefault.jpg",
     "category": "Entertainment",
     "channelTitle": "Top Luxury",
     "duration": "10:06"
 },
 */
