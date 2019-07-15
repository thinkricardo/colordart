import Cocoa

class CaptureInfoView: NSView {

    private var infoText: NSString = ""

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        layer?.backgroundColor = NSColor.black.cgColor

        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 12),
            .foregroundColor: NSColor.white
        ]

        infoText.draw(in: frame, withAttributes: attributes)
    }

    func updateView(info: NSString) {
        infoText = info

        needsDisplay = true
    }
    
}
