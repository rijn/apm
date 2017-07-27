//
//  Keyboard.swift
//  apm
//
//  Created by Rijn on 7/26/17.
//  Copyright © 2017 Rijn. All rights reserved.
//

import Cocoa
import Foundation

struct KeyboardData {
    var currentApm: Int
}

protocol KeyboardDelegate {
    func keyboardDataDidUpdate(data: KeyboardData)
}

class Keyboard {
    var delegate: KeyboardDelegate?
    
    init(delegate: KeyboardDelegate) {
        self.delegate = delegate
    }
    
    var data: [NSDate] = []
    var timer = Timer()

    func registerListener () {
        NSEvent.addGlobalMonitorForEvents(matching: NSEventMask.keyDown, handler: keyDown)
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: (#selector(Keyboard.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        let current = NSDate()
        let filtered = Array(data.filter({(timestamp) in
            return Bool(current.timeIntervalSince(timestamp as Date) < 3)
        }))
        var count:Int = 0
        if (filtered.count > 1) {
            count = Int(Double(filtered.count) * Double(12.0) / Double((filtered.last?.timeIntervalSince(filtered.first as! Date))!))
        }
        self.delegate?.keyboardDataDidUpdate(data: KeyboardData(currentApm: count))
    }
    
    func keyDown (event: NSEvent!) {
        data.append(NSDate())
        data = Array(data.suffix(900))
    }
}
