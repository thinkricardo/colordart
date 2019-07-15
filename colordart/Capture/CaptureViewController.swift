import Cocoa

class CaptureViewController: NSViewController {
    
    private lazy var captureView: CaptureView = createCaptureView()
    private lazy var infoView: CaptureInfoView = createInfoView()
    
    private var captureViewSize: Int = 200
    private var zoomScale: Int = 10

    override func loadView() {
        view = captureView
        view.addSubview(infoView)
    }

    func createCaptureView() -> CaptureView {
        let size = CGSize(width: captureViewSize, height: captureViewSize)
        let frame = NSRect(origin: .zero, size: size)

        let view = CaptureView(frame: frame)
        view.wantsLayer = true

        return view
    }

    func createInfoView() -> CaptureInfoView {
        let size = CGSize(width: captureViewSize, height: 20)
        let frame = NSRect(origin: .zero, size: size)

        return CaptureInfoView(frame: frame)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        registerEventMonitors()
    }

    func registerEventMonitors() {
        NSEvent.addGlobalMonitorForEvents(matching: .mouseMoved, handler: {(event: NSEvent) -> Void in
            self.mouseMoved(at: event.locationInWindow)
        })

        NSEvent.addLocalMonitorForEvents(matching: .mouseMoved, handler: {(event: NSEvent) -> NSEvent? in
            self.mouseMoved(at: event.locationInWindow)

            return event
        })
    }

    func mouseMoved(at point: NSPoint) {
        moveWindow(at: point)
        captureArea(aroundPoint: point)
    }

    func moveWindow(at point: NSPoint) {
        let x = Int(point.x) - captureViewSize / 2
        let y = Int(point.y) - captureViewSize / 2

        let newLocation = NSPoint(x: x, y: y)

        view.window!.setFrameOrigin(newLocation)
    }
    
    func calculateAreaToCapture(at point: NSPoint, withSize size: Int, andScale scale: Int) -> CGRect {
        let scaledSize = safeguardOddNumber(size / scale)

        let startX = Int(point.x) - scaledSize / 2
        let startY = Int(point.y) - scaledSize / 2

        return CGRect(x: startX, y: startY, width: scaledSize, height: scaledSize)
    }

    func captureArea(aroundPoint: NSPoint) {
        let convertedPoint = NSScreen.convertScreenCoordinates(point: aroundPoint)

        let windowId = CGWindowID(view.window!.windowNumber)
        print(windowId)

        let areaToCapture = calculateAreaToCapture(at: convertedPoint, withSize: captureViewSize, andScale: zoomScale)
        let capturedImage = CGWindowListCreateImage(areaToCapture, .optionOnScreenBelowWindow, windowId, .bestResolution)!

        captureView.updateView(capturedImage: capturedImage)

        captureColor(fromImage: capturedImage)
    }

    func captureColor(fromImage image: CGImage) {
        let bitmap = NSBitmapImageRep.init(cgImage: image)

        let middle = image.width / 2
        let color = bitmap.colorAt(x: middle, y: middle)
        
        let red = Int(round(color!.redComponent * 255))
        let green = Int(round(color!.greenComponent * 255))
        let blue = Int(round(color!.blueComponent * 255))

        let colorInfo = "rgb(\(red), \(green), \(blue))"

        infoView.updateView(info: NSString(string: colorInfo))
    }
    
}
