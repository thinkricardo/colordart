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
        let convertedPoint = NSScreen.convertScreenCoordinates(point: aroundPoint)
        
        let areaToCapture = calculateAreaToCapture(at: convertedPoint, withSize: captureViewSize, andScale: zoomScale)
        let capturedImage = CGWindowListCreateImage(areaToCapture, .optionOnScreenBelowWindow, kCGNullWindowID, .bestResolution)!
        
        captureView.updateView(capturedImage: capturedImage)
        
        self.getColor(fromImage: capturedImage)
    }
    
    func calculateAreaToCapture(at point: NSPoint, withSize size: Int, andScale scale: Int) -> CGRect {
        let scaledSize = safeguardOddNumber(size / scale)

        let startX = Int(point.x) - scaledSize / 2
        let startY = Int(point.y) - scaledSize / 2

        return CGRect(x: startX, y: startY, width: scaledSize, height: scaledSize)
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
    
}
