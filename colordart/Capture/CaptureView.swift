//
//  CaptureView.swift
//  colordart
//
//  Created by Ricardo Pereira on 04/07/2019.
//  Copyright © 2019 octoloop. All rights reserved.
//

import Cocoa

class CaptureView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    func updateArea(withImage image: CGImage) {
        let zoomScale: CGFloat = 20;
        let zoomFactor: CGFloat = 1 / zoomScale
        
        let size: CGFloat = 100 * zoomFactor
        
        let center: CGFloat = CGFloat(image.width) / CGFloat(2)
        let start = center - (size / 2)
        
        let zoomPoint = CGPoint(x: Int(start), y: Int(start))
        let zoomSize = CGSize(width: size, height: size)
        
        let zoomRect = CGRect(origin: zoomPoint, size: zoomSize)
        let zoomedImage: CGImage? = image.cropping(to: zoomRect)
        
        self.layer?.magnificationFilter = .nearest
        self.layer?.contents = zoomedImage
    }
    
}
