//
//  AppDelegate.swift
//  Movies
//
//  Created by Osman Balci on 3/20/23.
//  Modified by Yuxuan Li on 3/29/23
//  Copyright © 2023 Osman Balci. All rights reserved.
//

import SwiftUI
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /*
        ******************************
        *   Create Movies Database   *
        ******************************
        */
        createVideosDatabase()      // Given in VideosData.swift
        
        
        return true
    }
}
