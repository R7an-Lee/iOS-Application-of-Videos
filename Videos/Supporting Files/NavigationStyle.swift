//
//  NavigationStyle.swift
//  Movies
//
//  Created by Osman Balci on 3/20/23.
//  Copyright © 2023 Osman Balci. All rights reserved.
//

import SwiftUI

extension View {
    
    public func customNavigationViewStyle() -> some View {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            // Device is an iPhone
            // Use single column navigation view for iPhone
            return AnyView(navigationViewStyle(StackNavigationViewStyle()))
        } else {
            // Device is an iPad
            return AnyView(GeometryReader { device in
                // iPad height > iPad width indicates portrait device orientation
                if device.size.height > device.size.width {
                    // Use single column navigation view for iPad in portrait device orientation
                    navigationViewStyle(StackNavigationViewStyle())
                } else {
                    // Use double column navigation view (Split View) for iPad in landscape device orientation
                    navigationViewStyle(DoubleColumnNavigationViewStyle())
                }
            })
        }
    }
 
}
