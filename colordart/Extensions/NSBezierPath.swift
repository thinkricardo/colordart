//
//  NSBezierPath.swift
//  colordart
//
//  Created by Ricardo Pereira on 09/07/2019.
//  Copyright © 2019 octoloop. All rights reserved.
//

import Cocoa

extension NSBezierPath {
    var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)
        
        for i in 0 ..< self.elementCount {
            let elementType = self.element(at: i, associatedPoints: &points)
            
            switch elementType {
            case .moveTo:
                path.move(to: points[0])
            case .lineTo:
                path.addLine(to: points[0])
            case .curveTo:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePath:
                path.closeSubpath()
            @unknown default:
                print("NSBezierPath: Path element not supported.")
            }
        }
        
        return path
    }
}
