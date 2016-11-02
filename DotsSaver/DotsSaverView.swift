//
//  ScreenSaverMinimalView.swift
//  ScreenSaverMinimal
//
//  Created by Mirko Fetter on 28.10.16.
//
// Based on https://github.com/erikdoe/swift-circle


import ScreenSaver

class DotsSaverView : ScreenSaverView {
    
    var defaultsManager: DefaultsManager = DefaultsManager()
    lazy var sheetController: ConfigureSheetController = ConfigureSheetController()
    
    
    var canvasColor : NSColor?
     var circleColor = NSColor.red
    var circleSize: Float = 100
    var amplitude: Float = 0.5
     var frameCount = 0
    
    override init(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)!
        let stepsW = frame.width/20
        let stepsH = frame.height/20
        canvasColor = defaultsManager.canvasColor

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func hasConfigureSheet() -> Bool {
        return true
    }
    
    override func configureSheet() -> NSWindow? {
        return sheetController.window
    }

    
    override func startAnimation() {
        super.startAnimation()
      
    }
    
    override func stopAnimation() {
        super.stopAnimation()
    }
    

    override func draw(_ rect: NSRect) {
        let bPath:NSBezierPath = NSBezierPath(rect: bounds)
        defaultsManager.canvasColor.set()
        bPath.fill()

     }
    
    override func animateOneFrame() {
        window!.disableFlushing()
        drawCircle(color: canvasColor!, diameter: CGFloat(circleSize+amplitude))
        let r = CGFloat(sin(Float(frameCount) / 40) * amplitude + circleSize)
        drawCircle(color: circleColor, diameter: r)
        frameCount += 1
        window!.enableFlushing()
    }
    
    func drawCircle(color: NSColor, diameter: CGFloat) {
        var circleRect = NSMakeRect(bounds.size.width/2 - diameter/2, bounds.size.height/2 - diameter/2, diameter, diameter)
        let cPath: NSBezierPath = NSBezierPath(ovalIn: circleRect)
        color.set()
        cPath.fill()
    }
    
}
    

