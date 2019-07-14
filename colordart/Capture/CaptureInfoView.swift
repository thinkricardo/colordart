import Cocoa

class CaptureInfoView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        layer?.backgroundColor = NSColor.black.cgColor
    }
    
}
