//
//  SettingWindow.swift
//  apm
//
//  Created by Rijn on 7/26/17.
//  Copyright © 2017 Rijn. All rights reserved.
//

import Cocoa
import ServiceManagement
import os.log

class SettingWindow: NSWindow {
    @IBOutlet weak var toggleOpenLogin: NSButton!

    override func makeKeyAndOrderFront(_ sender: Any?) {
        super.makeKeyAndOrderFront(sender)
        if UserDefaults.standard.object(forKey: "appLoginStart") as! String == "false" {
            toggleOpenLogin.setNextState()
        }
    }
    
    @IBAction func toggleLaunchAtLogin(_ sender: NSButton) {
        os_log("Bool value: %@", UserDefaults.standard.object(forKey: "appLoginStart") as! String as CVarArg)
        if toggleOpenLogin.state == 1 {
            if !SMLoginItemSetEnabled("com.rijn.apmLauncher" as CFString, true) {
                self.print("The login item was not successfull")
                toggleOpenLogin.setNextState()
            } else {
                UserDefaults.standard.set("true", forKey: "appLoginStart")
            }
        }
        else {
            if !SMLoginItemSetEnabled("com.rijn.apmLauncher" as CFString, false) {
                self.print("The login item was not successfull")
                toggleOpenLogin.setNextState()
            } else {
                UserDefaults.standard.set("false", forKey: "appLoginStart")
            }
        }
    }
}
