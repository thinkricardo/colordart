//
//  CaptureViewController.swift
//  colordart
//
//  Created by Ricardo Pereira on 27/06/2019.
//  Copyright © 2019 octoloop. All rights reserved.
//

import Cocoa

class CaptureViewController: NSViewController {
    
    private lazy var captureView: CaptureView = createCaptureView()
    
    private var captureViewSize: Int = 200
    private var zoomScale: Int = 10

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
        let size = CGSize(width: captureViewSize, height: captureViewSize)
        let frame = NSRect(origin: .zero, size: size)
        
        return CaptureView(frame: frame)
    }
    
    func mouseMoved(mouseLocation: NSPoint) {
        captureArea(aroundPoint: mouseLocation)
    }
    
    func captureArea(aroundPoint: NSPoint) {
        let convertedPoint = convertCoordinates(point: aroundPoint)
        
        let capturedArea = calculateCaptureArea(point: convertedPoint, width: captureViewSize, scale: zoomScale)
        let capturedImage = CGWindowListCreateImage(capturedArea, .optionOnScreenBelowWindow, kCGNullWindowID, .bestResolution)
        
        captureView.updateView(capturedImage: capturedImage!)
        
        self.getColor(fromImage: capturedImage!)
    }
    
    func calculateCaptureArea(point: NSPoint, width: Int, scale: Int) -> CGRect {
        let size = CGFloat(width) / CGFloat(scale)
        let start = size / 2
        
        return CGRect(x: point.x - start, y: point.y - start, width: size + 1, height: size + 1)
    }

    func getColor(fromImage image: CGImage) {
        let bitmap = NSBitmapImageRep.init(cgImage: image)

        let middle = image.width / 2
        let color = bitmap.colorAt(x: middle, y: middle)
        
        let red = Int(round(color!.redComponent * 255))
        let green = Int(round(color!.greenComponent * 255))
        let blue = Int(round(color!.blueComponent * 255))

        print("r:\(red) g:\(green) b:\(blue)")
    }
    
    func currentScreenForMouseLocation(point: NSPoint) -> NSScreen? {
        return NSScreen.screens.first(where: { NSMouseInRect(point, $0.frame, false) })
    }
    
    func convertCoordinates(point: NSPoint) -> NSPoint {
        let screen = self.currentScreenForMouseLocation(point: point)!
        
        return NSPoint(x: floor(point.x), y: floor(screen.frame.height - point.y))
    }
    
}
