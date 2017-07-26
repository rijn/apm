//
//  Keyboard.swift
//  apm
//
//  Created by Rijn on 7/26/17.
//  Copyright © 2017 Rijn. All rights reserved.
//

import Foundation
import Cocoa

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

    func registerListener () {
        NSEvent.addGlobalMonitorForEvents(matching: NSEventMask.keyDown, handler: keyDown)
    }
    
    func keyDown (event: NSEvent!) {
        print("key down is \(event.keyCode)");
        self.delegate?.keyboardDataDidUpdate(data: KeyboardData(currentApm: 0))
    }
}
