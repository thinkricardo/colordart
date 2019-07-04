//
//  CaptureViewController.swift
//  colordart
//
//  Created by Ricardo Pereira on 27/06/2019.
//  Copyright © 2019 octoloop. All rights reserved.
//

import Cocoa

class CaptureViewController: NSViewController {
    
    private lazy var captureView: CaptureView = self.createCaptureView()

    override func loadView() {
        self.view = captureView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        NSEvent.addGlobalMonitorForEvents(matching: .mouseMoved, handler: {(event: NSEvent) -> Void in
            self.mouseMoved(mouseLocation: NSEvent.mouseLocation)
        })
    }
    
    func createCaptureView() -> CaptureView {
        let captureFrame: NSRect = NSRect(origin: .zero, size: CGSize(width: 100, height: 100))
        return CaptureView(frame: captureFrame)
    }
    
    func mouseMoved(mouseLocation: NSPoint) {
        self.captureArea(aroundPoint: mouseLocation)
    }
    
    func captureArea(aroundPoint: NSPoint) {
        let convertedPoint = self.convertCoordinates(point: aroundPoint)
        
        let area = CGRect(x: convertedPoint.x - 50, y: convertedPoint.y - 50, width: 100, height: 100)
        let image = CGWindowListCreateImage(area, .optionOnScreenBelowWindow, kCGNullWindowID, .bestResolution)
        
        captureView.updateArea(withImage: image!)
        
        self.getColor(fromImage: image!)
    }
    
    func getColor(fromImage image: CGImage) {
        let image = NSBitmapImageRep.init(cgImage: image)
        let color = image.colorAt(x: 50, y: 50)
        
        let red = Int(round(color!.redComponent * 255))
        let green = Int(round(color!.greenComponent * 255))
        let blue = Int(round(color!.blueComponent * 255))

        print("r:\(red) g:\(green) b:\(blue)")
    }
    
    func currentScreenForMouseLocation(point: NSPoint) -> NSScreen? {
        return NSScreen.screens.first(where: { NSMouseInRect(point, $0.frame, false) })
    }
    
    func convertCoordinates(point: NSPoint) -> NSPoint {
        let screen: NSScreen = self.currentScreenForMouseLocation(point: point)!
        
        return NSPoint(x: point.x, y: screen.frame.height - point.y)
    }
    
}
