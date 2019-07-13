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
        view = captureView
    }

    func createCaptureView() -> CaptureView {
        let size = CGSize(width: captureViewSize, height: captureViewSize)
        let frame = NSRect(origin: .zero, size: size)

        return CaptureView(frame: frame)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        registerEventMonitor()
    }

    func registerEventMonitor() {
        NSEvent.addGlobalMonitorForEvents(matching: .mouseMoved, handler: {(event: NSEvent) -> Void in
            self.mouseMoved(at: event.locationInWindow)
        })
    }

    func mouseMoved(at point: NSPoint) {
        captureArea(aroundPoint: point)
    }
    
    func captureArea(aroundPoint: NSPoint) {
        let convertedPoint = convertCoordinates(point: aroundPoint)
        
        let capturedArea = calculateCaptureArea(point: convertedPoint, width: captureViewSize, scale: zoomScale)
        let capturedImage = CGWindowListCreateImage(capturedArea, .optionOnScreenBelowWindow, kCGNullWindowID, .bestResolution)
        
        captureView.updateView(capturedImage: capturedImage!)
        
        self.getColor(fromImage: capturedImage!)
    }
    
    func calculateCaptureArea(point: NSPoint, width: Int, scale: Int) -> CGRect {
        let size = safeguardOddNumber(value: width / scale)
        let start = size / 2

        let startX = Int(point.x) - start
        let startY = Int(point.y) - start

        return CGRect(x: startX, y: startY, width: size, height: size)
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
    
    func convertCoordinates(point: NSPoint) -> NSPoint {
        let screen = NSScreen.currentScreenAt(point: point)
        
        return NSPoint(x: floor(point.x), y: floor(screen.frame.height - point.y))
    }

    func safeguardOddNumber(value: Int) -> Int {
        if value % 2 == 0 {
            return value + 1;
        }

        return value;
    }
    
}
