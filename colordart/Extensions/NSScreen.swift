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

}
