//
//  CaptureView.swift
//  colordart
//
//  Created by Ricardo Pereira on 04/07/2019.
//  Copyright © 2019 octoloop. All rights reserved.
//

import Cocoa

extension NSBezierPath {
    var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)
        
        for i in 0 ..< self.elementCount {
            switch self.element(at: i, associatedPoints: &points) {
                case .moveTo:
                    path.move(to: points[0])
                case .lineTo:
                    path.addLine(to: points[0])
                case .curveTo:
                    path.addCurve(to: points[2], control1: points[0], control2: points[1])
                case .closePath:
                    path.closeSubpath()
                @unknown default:
                    path.closeSubpath()
            }
        }
        
        return path
    }
}

class CaptureView: NSView {
    
    private var zoomScale = 10
    private var grid: CAShapeLayer = CAShapeLayer()

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    func updateArea(withImage image: CGImage) {
        let zoomedRect = calculateZoomedRect(width: image.width, scale: zoomScale)
        let zoomedImage: CGImage? = image.cropping(to: zoomedRect)
        
        self.layer?.contents = zoomedImage
        self.layer?.magnificationFilter = .nearest
        
        drawGrid(originalWidth: CGFloat(image.width), zoomedWidth: zoomedRect.width)
    }
    
    func calculateZoomedRect(width: Int, scale: Int) -> CGRect {
        let center: CGFloat = CGFloat(width) / 2
        let size: CGFloat = CGFloat(width) / CGFloat(scale)
        
        let start: CGFloat = center - (size / 2)
        
        return CGRect(x: start, y: start, width: size + 1, height: size + 1)
    }
    
    func drawGrid(originalWidth: CGFloat, zoomedWidth: CGFloat) {
        let path = NSBezierPath()
        let slots: Int = Int(zoomedWidth)
        let size = Int(originalWidth) / Int(zoomedWidth)
        
        for i in 1 ..< slots {
            let position = CGFloat(i) * CGFloat(size)
            
            path.move(to: NSPoint(x: position, y: 0))
            path.line(to: NSPoint(x: position, y: 100))
            path.move(to: NSPoint(x: 0, y: position))
            path.line(to: NSPoint(x: 100, y: position))
        }
        
        grid.opacity = 0.2
        grid.strokeColor = NSColor.gray.cgColor
        grid.path = path.cgPath
        
        layer?.addSublayer(grid)
    }
    
}
