//
//  ScreenSaverMinimalView.swift
//  ScreenSaverMinimal
//
//  Created by Mirko Fetter on 28.10.16.
//
// Based on https://github.com/erikdoe/swift-circle


import ScreenSaver
import RandomColorSwift

class DotsSaverView : ScreenSaverView {
    
    var defaultsManager: DefaultsManager = DefaultsManager()
    lazy var sheetController: ConfigureSheetController = ConfigureSheetController()
    
    
    var canvasColor : NSColor?
     var circleColor = NSColor.red
    var circleSize: Float = 50.0
    var amplitude: Float = 0.9
    var maxFrames = 30
    var calcAmplitude: Float = 0.9
    var specArray = Array<Array<CircleSpec>>()
    var colorArray = Array<Color>()
    var hue = Hue.pink
    var luminosity = Luminosity.light
    var numOfColors = 10;
    var width: CGFloat?
    var height: CGFloat?

    
    
    var stepsW : CGFloat?
    var stepsH : CGFloat?

    
    override init(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)!
        
        
        
        animationTimeInterval = 1.0 / 60.0
        
         width  = NSScreen.main()?.frame.width
         height = NSScreen.main()?.frame.height

        cacheDefaults()
        initArrays();

    }
    
    func cacheDefaults(){
        
        canvasColor = defaultsManager.canvasColor
        hue = defaultsManager.hue
        luminosity = defaultsManager.luminosity
        numOfColors = defaultsManager.numOfColor


        

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
        cacheDefaults()
      
    }
    
    override func stopAnimation() {
        super.stopAnimation()
    }
    

    override func draw(_ rect: NSRect) {
        let bPath:NSBezierPath = NSBezierPath(rect: bounds)
        defaultsManager.canvasColor.set()
        bPath.fill()
        
        for i in 0...specArray.count-1
        {
            for j in 0...specArray[i].count-1
            {
                drawCircle(spec: specArray[i][j])
                (specArray[i][j]).framecount += 1
            }
        }

     }
    
    override func animateOneFrame() {
        needsDisplay = true
        
    }
    
    func drawCircle(spec: CircleSpec) {
        let diameter = CGFloat(sin(Float(spec.framecount) / Float(maxFrames)) * calcAmplitude + circleSize)
    
        let circleRect = NSMakeRect(CGFloat(spec.x * Int(circleSize*2))-diameter/2, CGFloat(spec.y * Int(circleSize*2))-diameter/2, diameter, diameter)
        let cPath: NSBezierPath = NSBezierPath(ovalIn: circleRect)
        spec.circleColor.set()
        cPath.fill()
    }
    
    func initArrays(){
        
        typealias ratioTuple = (CGFloat, CGFloat)
        
        var aspectRatios:[ratioTuple] = [   (10,4),(12,9),(12,8),(15,9),(16,9),(16,10),(17,9)]
        var differences = [CGFloat]()
        
        aspectRatios.sort(by: { $0.0/$0.1 > $1.0/$1.1})
        
        for ratio in aspectRatios {
            differences.append(abs((width!/height!) - (ratio.0/ratio.1)))
        }
        let min = differences.min()
        let pos = differences.index(of: min!)
        
        
        
        let numColumns = Int(aspectRatios[pos!].0)
        let numRows = Int(aspectRatios[pos!].1)
        
        circleSize = (Float(width!) / Float(numColumns))/2
        calcAmplitude = circleSize * amplitude

        
        colorArray = randomColors(count: numOfColors, hue: hue, luminosity: luminosity)
        
        // Init SpecArray

        for column in 0...numColumns {

            var columnArray = Array<CircleSpec>()
            for row in 0...numRows {
                columnArray.append(CircleSpec(circleColor: colorArray[Int(arc4random_uniform(UInt32(numOfColors)))], framecount: Int(arc4random_uniform(UInt32(maxFrames))),x:column,y:row))
            }
            specArray.append(columnArray)
        }
        
    }
    
    
    struct CircleSpec {

        var circleColor = NSColor.black
        var framecount = 0
        var x  = 0
        var y  = 0
    }
    
    
}
    

