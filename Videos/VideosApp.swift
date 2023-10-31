//
//  VideosApp.swift
//  Videos
//
//  Modified by Yuxuan Li on 3/29/23.
//

import SwiftUI

@main
struct MoviesApp: App {
    /*
     UserDefaults is a class that provides an interface to the user’s defaults database,
     where you store Key-Value pairs persistently across launches of your app.
 
     The @AppStorage is a property wrapper type that reflects a value from UserDefaults
     and invalidates a view on a change in value in that user default.
    
     We use 'private var darkMode' property wrapped with @AppStorage("darkMode")
     to change or read the value for the Key "darkMode" in UserDefaults database.
 
     Every view in the app is automatically updated / refreshed whenever
     the Key 'darkMode' value changes in UserDefaults database.
     */
    @AppStorage("darkMode") private var darkMode = false
    
    /*
     Use the UIApplicationDelegateAdaptor property wrapper to direct SwiftUI
     to use the AppDelegate class for the application delegate.
     */
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // ❎ Get object reference of CoreData managedObjectContext from the persistent container
    let managedObjectContext = PersistenceController.shared.persistentContainer.viewContext
    
    /*
     @Environment property wrapper for SwiftUI's pre-defined key scenePhase is declared to
     monitor changes of app's life cycle states such as active, inactive, or background.
     The \. indicates that we access scenePhase by its object reference, not by its value.
     */
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup {
            // ContentView is the root view to be shown first upon app launch
            ContentView()
                // Change the color mode of the entire app to Dark or Light
                .preferredColorScheme(darkMode ? .dark : .light)
            
                /*
                 Inject managedObjectContext into ContentView as an environment variable
                 so that it can be referenced in any SwiftUI view as
                    @Environment(\.managedObjectContext) var managedObjectContext
                 */
                .environment(\.managedObjectContext, managedObjectContext)
                /*
                 Inject an instance of DatabaseChange() class into the environment and
                 make it available to every View subscribing to it.
                 */
                .environmentObject(DatabaseChange())
        }
        .onChange(of: scenePhase) { _ in
            /*
             Save database changes if any whenever app life cycle state
             changes. The saveContext() method is given in Persistence.
             */
            PersistenceController.shared.saveContext()
        }
    }
    
}
