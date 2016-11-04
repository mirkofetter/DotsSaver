//
//  ConfigureSheetController.swift
//
//
//  Created by Mirko Fetter on 28.10.16.
//
//  Based on https://github.com/erikdoe/swift-circle


import Cocoa
import RandomColorSwift

class ConfigureSheetController : NSObject {
    
    var defaultsManager = DefaultsManager()

    @IBOutlet var window: NSWindow?
    @IBOutlet var canvasColorWell: NSColorWell?
    
    @IBOutlet weak var numOfColorSlider: NSSlider!
    
    @IBOutlet weak var huePopUp: NSPopUpButton!
    
    @IBOutlet weak var luminosityPopUp: NSPopUpButton!


    override init() {
        super.init()
        let myBundle = Bundle(for: ConfigureSheetController.self)
        
        
        myBundle.loadNibNamed("ConfigureSheet", owner: self, topLevelObjects: nil)
        
        canvasColorWell!.color = defaultsManager.canvasColor
        numOfColorSlider!.intValue = Int32(defaultsManager.numOfColor)
    
        huePopUp.removeAllItems()
        huePopUp.addItems(withTitles:  [String] (defaultsManager.hueValues.values))
        huePopUp.selectItem(      withTitle:    defaultsManager.hueValues[defaultsManager.hue]!
)
        
        

    }

    @IBAction func updateDefaults(_ sender: AnyObject) {
        defaultsManager.canvasColor = canvasColorWell!.color
        defaultsManager.numOfColor = Int(numOfColorSlider!.intValue)
        defaultsManager.hue = defaultsManager.hueValues.keysForValue(value: (huePopUp.selectedItem?.title)!)[0]

    }
   
    @IBAction func closeConfigureSheet(_ sender: AnyObject) {
        NSColorPanel.shared().close()
        NSApp.endSheet(window!)
    }
   
    
}

extension Dictionary where Value: Equatable {
    /// Returns all keys mapped to the specified value.
    /// ```
    /// let dict = ["A": 1, "B": 2, "C": 3]
    /// let keys = dict.keysForValue(2)
    /// assert(keys == ["B"])
    /// assert(dict["B"] == 2)
    /// ```
    func keysForValue(value: Value) -> [Key] {
        return flatMap { (key: Key, val: Value) -> Key? in
            value == val ? key : nil
        }
    } 
}
