//
//  AppDelegate.swift
//  apmLauncher
//
//  Created by Rijn on 7/26/17.
//  Copyright © 2017 Rijn. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let mainAppIdentifier = "com.rijn.apm"
        let running = NSWorkspace.shared().runningApplications
        var alreadyRunning = false

        // loop through running apps - check if the Main application is running
        for app in running {
            if app.bundleIdentifier == mainAppIdentifier {
                alreadyRunning = true
                break
            }
        }
        
        if !alreadyRunning {
            // Register for the notification killme
            DistributedNotificationCenter.default().addObserver(self, selector: #selector(self.terminate), name: NSNotification.Name(rawValue: "killme"), object: mainAppIdentifier)
            
            // Get the path of the current app and navigate through them to find the Main Application
            let path = Bundle.main.bundlePath as NSString
            var components = path.pathComponents
            components.removeLast(3)
            components.append("MacOS")
            components.append("APM")
            
            let newPath = NSString.path(withComponents: components)
            
            // Launch the Main application
            NSWorkspace.shared().launchApplication(newPath)
        }
        else {
            // Main application is already running
            self.terminate()
        }
        
    }
    
    func terminate() {
        print("Terminate application")
        NSApp.terminate(nil)
    }
}

