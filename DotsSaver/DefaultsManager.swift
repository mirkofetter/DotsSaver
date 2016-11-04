//
//  DefaultsManager.swift
//  ScreenSaverMinimal
//
//  Created by Mirko Fetter on 28.10.16.
//
// Based on https://github.com/erikdoe/swift-circle



import ScreenSaver
import RandomColorSwift


class DefaultsManager {
    
    var defaults: UserDefaults
    
    
    //.monochrome, .red, .orange, .yellow, .green, .blue, .purple, .pink
    
    
    
    init() {
        let identifier = Bundle(for: DefaultsManager.self).bundleIdentifier
        defaults = ScreenSaverDefaults.init(forModuleWithName: identifier!)!
    }
    
    var canvasColor: NSColor {
        set(newColor) {
            setColor(newColor, key: "CanvasColor")
        }
        get {
            return getColor("CanvasColor") ?? NSColor(red: 1, green: 0.0, blue: 0.5, alpha: 1.0)
        }
    }
    
    
    var hue: Hue {
        set(newHue) {
            let hueValue:Int = newHue.toInt()
            debugPrint(hueValue)
            defaults.set(hueValue, forKey: "Hue")
        }
       get {
            let v = defaults.integer(forKey: "Hue")
            debugPrint(v)
        
            return  Hue.red
        }
    }
    
    var numOfColor: Int {
        set(newNumOfColor) {
            defaults.set(newNumOfColor, forKey: "NumberOfColors")
        }
        get {
            let v = defaults.integer(forKey: "NumberOfColors")
            return v > 0 ? v : 20
        }
    }
    

    func setColor(_ color: NSColor, key: String) {
        defaults.set(NSKeyedArchiver.archivedData(withRootObject: color), forKey: key)
        defaults.synchronize()
    }

    func getColor(_ key: String) -> NSColor? {
        if let canvasColorData = defaults.object(forKey: key) as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: canvasColorData) as? NSColor
        }
        return nil;
    }
    
    
    let hueValues = [  Hue.monochrome:"Monochrome",
                       Hue.red:"Red",
                       Hue.orange:"Orange",
                       Hue.yellow:"Yellow",
                       Hue.green:"Green",
                       Hue.blue:"Blue",
                       Hue.purple:"Purple",
                       Hue.pink:"Pink",
                       Hue.random:"Random"]
    

    
}
