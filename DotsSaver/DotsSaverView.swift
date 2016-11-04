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
    var circleSize: Float = 50.0
    var amplitude: Float = 0.5
    var myArray = Array<Array<CircleSpec>>()
    
    var stepsW : CGFloat?
    var stepsH : CGFloat?

    
    override init(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)!
        animationTimeInterval = 1.0 / 60.0
         stepsW = frame.size.width/20
         stepsH = bounds.height/20
        canvasColor = defaultsManager.canvasColor
        amplitude = circleSize * amplitude * 0.75
        initArray();
        debugPrint("::: \(frame)")
        

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
        
        for i in 0...myArray.count-1
        {
            for j in 0...myArray[i].count-1
            {
                drawCircle(spec: myArray[i][j])
                (myArray[i][j]).framecount += 1
            }
        }

     }
    
    override func animateOneFrame() {
        needsDisplay = true
        
    }
    
    func drawCircle(spec: CircleSpec) {
        let diameter = CGFloat(sin(Float(spec.framecount) / 40) * amplitude + circleSize)
     
        let circleRect = NSMakeRect(CGFloat(spec.x * 100)-diameter/2, CGFloat(spec.y * 100)-diameter/2, diameter, diameter)
        let cPath: NSBezierPath = NSBezierPath(ovalIn: circleRect)
        spec.circleColor.set()
        cPath.fill()
    }
    
    func initArray(){
        let NumColumns = 16
        let NumRows = 10
        debugPrint(frame.width)


        for column in 0...NumColumns {

            var columnArray = Array<CircleSpec>()
            for row in 0...NumRows {
                columnArray.append(CircleSpec(circleColor: NSColor.blue, framecount: Int(arc4random_uniform(40)),x:column,y:row))

            }
            myArray.append(columnArray)
        }
        
    }
    
    
    struct CircleSpec {

        var circleColor = NSColor.black
        var framecount = 0
        var x  = 0
        var y  = 0
    }
    
}
    

