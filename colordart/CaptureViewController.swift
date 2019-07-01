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
        // Do view setup here.
    
        NSEvent.addGlobalMonitorForEvents(matching: .mouseMoved, handler: {(event: NSEvent) -> Void in
            self.mouseMoved()
        })
    }
    
    func mouseMoved() {
        NSLog("%@", NSStringFromPoint(NSEvent.mouseLocation))
    }
    
}
