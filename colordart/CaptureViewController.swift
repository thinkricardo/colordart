//
//  CaptureViewController.swift
//  colordart
//
//  Created by Ricardo Pereira on 27/06/2019.
//  Copyright © 2019 octoloop. All rights reserved.
//

import Cocoa

class CaptureViewController: NSViewController {

    override func loadView() {
        let frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        let view = NSView(frame: frame)
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.blue.cgColor
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        NSEvent.addGlobalMonitorForEvents(matching: .mouseMoved, handler: {(event: NSEvent) -> Void in
            self.mouseMoved(mouseLocation: NSEvent.mouseLocation)
        })
    }
    
    func mouseMoved(mouseLocation: NSPoint) {
        NSLog("%@", NSStringFromPoint(mouseLocation))
        
        self.captureArea(aroundPoint: mouseLocation)
    }
    
    func captureArea(aroundPoint: NSPoint) {
        let area = CGRect(x: aroundPoint.x - 50, y: aroundPoint.y - 50, width: 100, height: 100)
        let image = CGWindowListCreateImage(area, .optionOnScreenBelowWindow, kCGNullWindowID, .bestResolution)
        
        self.view.layer?.contents = image
    }
    
}
