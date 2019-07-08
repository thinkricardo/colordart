//
//  CaptureView.swift
//  colordart
//
//  Created by Ricardo Pereira on 04/07/2019.
//  Copyright © 2019 octoloop. All rights reserved.
//

import Cocoa

class CaptureView: NSView {
    
    private var zoomScale = 10

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    func updateArea(withImage image: CGImage) {
        let zoomedRect = calculateZoomedRect(width: image.width, scale: zoomScale)
        let zoomedImage: CGImage? = image.cropping(to: zoomedRect)
        
        self.layer?.contents = zoomedImage
        self.layer?.magnificationFilter = .nearest
    }
    
    func calculateZoomedRect(width: Int, scale: Int) -> CGRect {
        let center: CGFloat = CGFloat(width) / 2
        let size: CGFloat = CGFloat(width) / CGFloat(scale)
        
        let start: CGFloat = center - (size / 2)
        
        return CGRect(x: start, y: start, width: size, height: size)
    }
    
}
