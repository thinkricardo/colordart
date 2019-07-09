//
//  CaptureView.swift
//  colordart
//
//  Created by Ricardo Pereira on 04/07/2019.
//  Copyright © 2019 octoloop. All rights reserved.
//

import Cocoa

class CaptureView: NSView {

    private lazy var grid: CAShapeLayer = CAShapeLayer()

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    func updateView(capturedImage: CGImage) {
        self.layer?.contents = capturedImage
        self.layer?.magnificationFilter = .nearest
        
        drawGrid(zoomedSize: frame.width, capturedSize: CGFloat(capturedImage.width))
    }
    
    func drawGrid(zoomedSize: CGFloat, capturedSize: CGFloat) {
        let path = NSBezierPath()
        
        let slots = Int(capturedSize)
        let slotSize = zoomedSize / capturedSize
        
        for i in 1 ..< slots {
            let position = CGFloat(i) * slotSize

            // vertical lines
            path.move(to: NSPoint(x: position, y: .zero))
            path.line(to: NSPoint(x: position, y: zoomedSize))

            // horizontal lines
            path.move(to: NSPoint(x: .zero, y: position))
            path.line(to: NSPoint(x: zoomedSize, y: position))
        }

        grid.path = path.cgPath

        grid.opacity = 0.2
        grid.strokeColor = NSColor.black.cgColor

        layer?.addSublayer(grid)
    }
    
}
