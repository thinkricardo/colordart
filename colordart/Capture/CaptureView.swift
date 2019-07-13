import Cocoa

class CaptureView: NSView {

    private lazy var grid: CAShapeLayer = CAShapeLayer()
    private lazy var bullseye: CAShapeLayer = CAShapeLayer()

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    func updateView(capturedImage: CGImage) {
        self.layer?.contents = capturedImage
        self.layer?.magnificationFilter = .nearest
        
        drawGrid(zoomedSize: frame.width, capturedSize: CGFloat(capturedImage.width))
    }
    
    func drawGrid(zoomedSize: CGFloat, capturedSize: CGFloat) {
        let path = NSBezierPath()
        
        let slots = Int(capturedSize)
        let slotSize = zoomedSize / capturedSize
        
        for i in 1 ..< slots {
            let position = CGFloat(i) * slotSize

            // horizontal lines
            path.move(to: NSPoint(x: .zero, y: position))
            path.line(to: NSPoint(x: zoomedSize, y: position))

            // vertical lines
            path.move(to: NSPoint(x: position, y: .zero))
            path.line(to: NSPoint(x: position, y: zoomedSize))
        }

        grid.path = path.cgPath

        grid.opacity = 0.2
        grid.strokeColor = NSColor.black.cgColor

        layer?.addSublayer(grid)

        drawBullseye(withSize: slotSize, at: zoomedSize / 2)
    }

    func drawBullseye(withSize size: CGFloat, at middlePoint: CGFloat) {
        let path = NSBezierPath()

        let halfSize: CGFloat = size / 2

        // left
        path.move(to: NSPoint(x: middlePoint - halfSize, y: middlePoint - halfSize))
        path.line(to: NSPoint(x: middlePoint - halfSize, y: middlePoint + halfSize))

        // right
        path.move(to: NSPoint(x: middlePoint + halfSize, y: middlePoint - halfSize))
        path.line(to: NSPoint(x: middlePoint + halfSize, y: middlePoint + halfSize))

        // bottom
        path.move(to: NSPoint(x: middlePoint - halfSize, y: middlePoint - halfSize))
        path.line(to: NSPoint(x: middlePoint + halfSize, y: middlePoint - halfSize))

        // top
        path.move(to: NSPoint(x: middlePoint - halfSize, y: middlePoint + halfSize))
        path.line(to: NSPoint(x: middlePoint + halfSize, y: middlePoint + halfSize))

        bullseye.path = path.cgPath

        bullseye.lineWidth = 2
        bullseye.opacity = 0.8
        bullseye.strokeColor = NSColor.white.cgColor

        layer?.addSublayer(bullseye)
    }
    
}
