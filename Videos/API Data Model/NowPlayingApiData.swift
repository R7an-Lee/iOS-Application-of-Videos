//
//  NowPlayingApiData.swift
//  Videos
//  Created by Osman Balci on 3/20/23.
//  Modified by Yuxuan Li on 4/1/23.
//  Copyright © 2023 Yuxuan Li. All rights reserved.
//

import Foundation

var nowVideosList = [VideoStruct]()

let myYoutubeApiKey = "AIzaSyA1P-Tj59uNGyjlbAEmhzzSXtfr3WuNOyw"

/*
    *************************************
    *   YouTube Data API HTTP Headers   *
    *************************************
    */
   let youTubeDataApiHeaders = [
       "accept": "application/json",
       "cache-control": "no-cache",
       "connection": "keep-alive",
       "host": "www.googleapis.com"
   ]
let youTubeVideoCategoriesDictionary = ["1": "Film & Animation", "2": "Autos & Vehicles", "3": "", "4": "", "5": "", "6": "", "7": "", "8": "", "9": "", "10": "Music", "11": "", "12": "", "13": "", "14": "", "15": "Pets & Animals", "16": "", "17": "Sports", "18": "Short Movies", "19": "Travel & Events", "20": "Gaming", "21": "Videoblogging", "22": "People & Blogs", "23": "Comedy", "24": "Entertainment", "25": "News & Politics", "26": "Howto & Style", "27": "Education", "28": "Science & Technology", "29": "Nonprofits & Activism", "30": "Movies", "31": "Anime/Animation", "32": "Action/Adventure", "33": "Classics", "34": "Comedy", "35": "Documentary", "36": "Drama", "37": "Family", "38": "Foreign", "39": "Horror", "40": "Sci-Fi/Fantasy", "41": "Thriller", "42": "Shorts", "43": "Shows", "44": "Trailers"]




/*
 ================================================
 |   Fetch and Process JSON Data from the API   |
 |   for Videos Currently Playing in Theaters   |
 ================================================
*/
public func getVideosFromApi(number: String, query: String) {

    // Initialize the global variable to contain the API search results
    nowVideosList = [VideoStruct]()
    var orderint = 1
    let nowPlayingApiUrl = "https://www.googleapis.com/youtube/v3/search?type=video&maxResults=\(number)&q=\(query)&key=\(myYoutubeApiKey)"
    
    /*
    ***************************************************
    *   Fetch JSON Data from the API Asynchronously   *
    ***************************************************
    */
    var jsonDataFromApi: Data
    
    let jsonDataFetchedFromApi = getJsonDataFromApi(apiHeaders: youTubeDataApiHeaders, apiUrl: nowPlayingApiUrl, timeout: 20.0)
    
    if let jsonData = jsonDataFetchedFromApi {
        jsonDataFromApi = jsonData
    } else {
        return
    }

    /*
    **************************************************
    *   Process the JSON Data Fetched from the API   *
    **************************************************
    */
    do {
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi,
                                                            options: JSONSerialization.ReadingOptions.mutableContainers)
        
        //-----------------------------
        // Obtain Top Level JSON Object
        //-----------------------------
        
        var jsonDataDictionary = [String: Any]()
        var videoID = ""
        if let jsonObject = jsonResponse as? [String: Any] {
            jsonDataDictionary = jsonObject
        } else {
            return
        }
        
        
        if let items = jsonDataDictionary["items"] as? [[String: Any]] {
            for item in items {
                var publish = ""
                var titl = ""
                var dest = ""
                var picurl = ""
                var chtitle = ""
                var category = ""
                if let videoId = item["id"] as? [String: Any]? {
                    if let videoIdValue = videoId?["videoId"] as? String {
                        videoID = videoIdValue
                    }
                }
                
                
                let attriUrl = "https://www.googleapis.com/youtube/v3/videos?part=snippet&id=\(videoID)&key=\(myYoutubeApiKey)"
                
                /*
                 ***************************************************
                 *   Fetch JSON Data from the API Asynchronously   *
                 ***************************************************
                 */
                var jsonDataFromApi1: Data
                
                let jsonDataFetchedFromApi1 = getJsonDataFromApi(apiHeaders: youTubeDataApiHeaders, apiUrl: attriUrl, timeout: 20.0)
                
                if let jsonData1 = jsonDataFetchedFromApi1 {
                    jsonDataFromApi1 = jsonData1
                } else {
                    return
                }
                do{
                    let jsonResponse1 = try JSONSerialization.jsonObject(with: jsonDataFromApi1,
                                                                         options: JSONSerialization.ReadingOptions.mutableContainers)
                    
                    
                    // Access the first item in the items array
                    if let jsonObject1 = jsonResponse1 as? [String: Any] {
                        if let items = jsonObject1["items"] as? [[String: Any]], let item = items.first {
                            // Access the snippet object
                            if let snippet = item["snippet"] as? [String: Any] {
                                // Access the desired attributes
                                if let publishedAt = snippet["publishedAt"] as? String {
                                    publish = publishedAt
                                }
                                if let title = snippet["title"] as? String {
                                    titl = title
                                }
                                if let description = snippet["description"] as? String {
                                    dest = description
                                }
                                if let thumbnails = snippet["thumbnails"] as? [String: Any], let medium = thumbnails["medium"] as? [String: Any], let url = medium["url"] as? String {
                                    picurl = url
                                }
                                if let channelTitle = snippet["channelTitle"] as? String {
                                    chtitle = channelTitle
                                }
                                if let categoryId = snippet["categoryId"] as? String {
                                    category = categoryId
                                }
                            }
                        }
                    }
                } catch {
                    return
                }
                
                //=============================================================
                var dur = ""
                let durApiUrl = "https://www.googleapis.com/youtube/v3/videos?part=contentDetails&id=\(videoID)&key=\(myYoutubeApiKey)"
                
                /*
                 ***************************************************
                 *   Fetch JSON Data from the API Asynchronously   *
                 ***************************************************
                 */
                var jsonDataFromdurApi: Data
                
                let jsonDataFetchedFromdurApi = getJsonDataFromApi(apiHeaders: youTubeDataApiHeaders, apiUrl: durApiUrl, timeout: 20.0)
                
                if let durJsonData = jsonDataFetchedFromdurApi {
                    jsonDataFromdurApi = durJsonData
                } else {
                    return
                }
                
                /*
                 **************************************************
                 *   Process the JSON Data Fetched from the API   *
                 **************************************************
                 */
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromdurApi,
                                                                        options: JSONSerialization.ReadingOptions.mutableContainers)
                    
                    if let jsonObject = jsonResponse as? [String: Any] {
                        
                        if let items = jsonObject["items"] as? [[String: Any]], let item = items.first {
                            // Access the contentDetails object
                            if let contentDetails = item["contentDetails"] as? [String: Any] {
                                // Access the duration attribute
                                if let duration = contentDetails["duration"] as? String {
                                    dur = duration
                                }
                            }
                        }
                    }
                }  catch { return }
                
                let newVideo = VideoStruct(orderNumber: Int32(orderint), videoId: videoID, title: titl, description: dest, publishedAt: formatTimestamp(timestamp: publish), thumbnailUrl: picurl, category: getCategoryString(for: category), channelTitle: chtitle, duration: formatYouTubeVideoDuration(inputDuration: dur))
                
                nowVideosList.append(newVideo)
                orderint += 1
            }   // End of for loop
        }
    }
     catch { return }

}

/*
*******************************
MARK: Format ISO 8601 Timestamp
*******************************
*/
public func formatTimestamp(timestamp: String) -> String {
    /*
     ISO 8601 Timestamp comes from the API in different formats after seconds:
         2023-01-20T15:58:17Z
         2023-01-19T15:00:11+00:00
         2023-01-15T18:53:26.2988181Z
    
    formet: 2023-01-20 15:58:17
     */
    if !timestamp.contains("T") { return "Invalid Timestamp" }
   
    let inputDateFormatter = DateFormatter()
    inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxxxx"
 
    var sortableDateAndTime = ""
   
    if let dateFromStringInInputFormat = inputDateFormatter.date(from: timestamp) {
       
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
       
        sortableDateAndTime = outputDateFormatter.string(from: dateFromStringInInputFormat)
    }
   
    return sortableDateAndTime
}

/*
***********************************
MARK: Format YouTube Video Duration
***********************************
*/
public func formatYouTubeVideoDuration(inputDuration: String) -> String {
    /*
     inputDuration is in the ISO 8601 format, e.g., "PT5H16M20S"
     PT stands for Period of Time, H = hours, M = minutes, S = seconds
     */
   
    let convertedInputDuration = inputDuration.replacingOccurrences(of: "PT", with: "").replacingOccurrences(of: "H", with:":").replacingOccurrences(of: "M", with: ":").replacingOccurrences(of: "S", with: "")
      
    let components = convertedInputDuration.components(separatedBy: ":")
    var duration = ""
    for aComponent in components {
        duration = duration.count > 0 ? duration + ":" : duration
        if aComponent.count < 2 {
            duration += "0" + aComponent
            continue
        }
        duration += aComponent
    }
   
    return duration
}

public func getCategoryString(for category: String) -> String {
    if let categoryString = youTubeVideoCategoriesDictionary[category] {
        return categoryString
    } else {
        return "Unknown Category"
    }
}
