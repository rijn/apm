//
//  StatusMenuController.swift
//  apm
//
//  Created by Rijn on 7/26/17.
//  Copyright © 2017 Rijn. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!

    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    func generateString(str: String) -> NSAttributedString {
        let font = NSFont(name: "InputMono", size: 11.0)
        return NSAttributedString(string: "APM", attributes: [NSFontAttributeName: font!])
    }
    
    override func awakeFromNib() {
        statusItem.attributedTitle = generateString(str: "APM")
        statusItem.menu = statusMenu
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
}
