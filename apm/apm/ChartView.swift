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
        
        var x = 0
        while (data.count < 75) {
            data.insert(0, at: 0)
        }
        
        for count in data.suffix(75) {
            let bar = NSBezierPath()
            bar.move(to: NSMakePoint(CGFloat(x), 0.0))
            bar.line(to: NSMakePoint(CGFloat(x), 0.0 + CGFloat(count) / 5))
            bar.lineWidth = 2.0
            bar.stroke()
            x = x + 2
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
