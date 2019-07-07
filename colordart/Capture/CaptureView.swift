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
        let zoomedImage: CGImage? = image.cropping(to: CGRect(x: 0, y: 0, width: 5, height: 5))
        
        self.layer?.magnificationFilter = .nearest
        self.layer?.contents = zoomedImage
    }
    
}
