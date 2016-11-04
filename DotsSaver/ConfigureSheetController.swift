//
//  ConfigureSheetController.swift
//
//
//  Created by Mirko Fetter on 28.10.16.
//
//  Based on https://github.com/erikdoe/swift-circle


import Cocoa

class ConfigureSheetController : NSObject {
    
    var defaultsManager = DefaultsManager()

    @IBOutlet var window: NSWindow?
    @IBOutlet var canvasColorWell: NSColorWell?
    
    @IBOutlet weak var numOfColorSlider: NSSlider!


    override init() {
        super.init()
        let myBundle = Bundle(for: ConfigureSheetController.self)
        myBundle.loadNibNamed("ConfigureSheet", owner: self, topLevelObjects: nil)
        canvasColorWell!.color = defaultsManager.canvasColor
        numOfColorSlider!.intValue = Int32(defaultsManager.numOfColor)

    }

    @IBAction func updateDefaults(_ sender: AnyObject) {
        defaultsManager.canvasColor = canvasColorWell!.color
        defaultsManager.numOfColor = Int(numOfColorSlider!.intValue)

    }
   
    @IBAction func closeConfigureSheet(_ sender: AnyObject) {
        NSColorPanel.shared().close()
        NSApp.endSheet(window!)
    }

}
