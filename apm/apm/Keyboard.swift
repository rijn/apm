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
        let count = data.filter({(timestamp) in
            return Bool(current.timeIntervalSince(timestamp as Date) < 60)
        }).count
        self.delegate?.keyboardDataDidUpdate(data: KeyboardData(currentApm: count))
    }
    
    func keyDown (event: NSEvent!) {
        data.append(NSDate())
        data = Array(data.suffix(200))
    }
}
