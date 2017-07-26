//
//  StatusMenuController.swift
//  apm
//
//  Created by Rijn on 7/26/17.
//  Copyright © 2017 Rijn. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject, KeyboardDelegate {
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var menuItemTrusted: NSMenuItem!
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    var keyboard: Keyboard!

    func generateString(str: String) -> NSAttributedString {
        let font = NSFont(name: "InputMono", size: 11.0)
        return NSAttributedString(string: "APM", attributes: [NSFontAttributeName: font!])
    }
    
    func accessibilityTrusted() -> Bool {
        let options : NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
        return AXIsProcessTrustedWithOptions(options)
    }
    
    override func awakeFromNib() {
        statusItem.attributedTitle = generateString(str: "APM")
        statusItem.menu = statusMenu
        
        menuItemTrusted.title = "Trusted: " + accessibilityTrusted().description
        
        keyboard = Keyboard(delegate: self)
        keyboard.registerListener()
    }
    
    func keyboardDataDidUpdate(data: KeyboardData) {
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
}
