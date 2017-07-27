//
//  ChartView.swift
//  apm
//
//  Created by Rijn on 7/26/17.
//  Copyright © 2017 Rijn. All rights reserved.
//

import Cocoa

class ChartView: NSView {
    var data: [Int] = []

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        NSColor.white.setStroke()
        
        var x = 10
        for count in data.suffix(140) {
            let bar = NSBezierPath()
            bar.move(to: NSMakePoint(CGFloat(x), 5.0))
            bar.line(to: NSMakePoint(CGFloat(x), 5.0 + CGFloat(count) / 5))
            bar.lineWidth = 1.0
            bar.stroke()
            x = x + 1
        }
    }
    
    func update(data: [Int]) {
        DispatchQueue.global().async {
            self.data = data
            DispatchQueue.main.async {
            }
        }
    }
}
