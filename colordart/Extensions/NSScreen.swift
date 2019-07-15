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
