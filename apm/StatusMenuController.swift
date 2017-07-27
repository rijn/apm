//
//  StatusMenuController.swift
//  apm
//
//  Created by Rijn on 7/26/17.
//  Copyright © 2017 Rijn. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject, KeyboardDelegate {
    var mainDelegate: MainDelegate?
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var menuItemTrusted: NSMenuItem!
    @IBOutlet weak var menuItemChart: NSMenuItem!
    @IBOutlet weak var menuItemSetting: NSMenuItem!
    @IBOutlet weak var chartView: ChartView!
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    var keyboard: Keyboard!

    func generateString(str: String) -> NSAttributedString {
        let font = NSFont(name: "InputMono", size: 10.0)
        return NSAttributedString(string: str, attributes: [NSFontAttributeName: font!])
    }
    
    func accessibilityTrusted() -> Bool {
        let options : NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
        return AXIsProcessTrustedWithOptions(options)
    }
    
    override func awakeFromNib() {
        statusItem.attributedTitle = generateString(str: "APM")
        statusItem.menu = statusMenu
        
        menuItemTrusted.title = "Trusted: " + accessibilityTrusted().description

        menuItemChart.view = chartView
    
        keyboard = Keyboard(delegate: self)
        keyboard.registerListener()
    }
    
    var chartData: [Int] = []
    
    func keyboardDataDidUpdate(data: KeyboardData) {
        statusItem.attributedTitle = generateString(str: "APM:\(data.currentApm)")
        chartData.append(data.currentApm)
        self.chartView?.update(data: chartData)
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
    
    @IBAction func settingClicked(_ sender: NSMenuItem) {
        mainDelegate?.settingOpen()
    }
}
