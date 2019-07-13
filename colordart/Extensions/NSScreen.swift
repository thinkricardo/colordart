//
//  NSScreen.swift
//  colordart
//
//  Created by Ricardo Pereira on 13/07/2019.
//  Copyright © 2019 octoloop. All rights reserved.
//

import Cocoa

extension NSScreen {

    static func currentScreenAt(point: NSPoint) -> NSScreen {
        return NSScreen.screens.first(where: { NSPointInRect(point, $0.frame) })!
    }

    static func convertScreenCoordinates(point: NSPoint) -> NSPoint {
        let screen = NSScreen.currentScreenAt(point: point)

        return NSPoint(x: floor(point.x), y: floor(screen.frame.height - point.y))
    }

}
