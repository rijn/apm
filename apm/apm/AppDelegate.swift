//
//  AppDelegate.swift
//  apm
//
//  Created by Rijn on 7/26/17.
//  Copyright © 2017 Rijn. All rights reserved.
//

import Cocoa

protocol MainDelegate {
    func settingOpen()
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, MainDelegate {
    @IBOutlet weak var statusMenuController: StatusMenuController!
    @IBOutlet weak var settingWindow: SettingWindow!

    func settingOpen() {
        settingWindow?.makeKeyAndOrderFront(self)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Check if the launcher app is started
        var startedAtLogin = false
        for app in NSWorkspace.shared().runningApplications {
            if app.bundleIdentifier == "com.rijn.apmLauncher" {
                startedAtLogin = true
            }
        }
        
        // If the app's started, post to the notification center to kill the launcher app
        if startedAtLogin {
            DistributedNotificationCenter.default().postNotificationName(NSNotification.Name(rawValue: "killme"), object: Bundle.main.bundleIdentifier, userInfo: nil, options: DistributedNotificationCenter.Options.deliverImmediately)
        }
        
        statusMenuController.mainDelegate = self
    }

    @nonobjc func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
