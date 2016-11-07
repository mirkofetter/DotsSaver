//
//  AppDelegate.swift
//
//  Created by Mirko Fetter on 25.10.16.
//  Copyright © 2016 grugru. All rights reserved.
//

// Test App for debugging the ScreenSaverView Code in Xcode

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    
    lazy var screenSaverView = DotsSaverView(frame: NSZeroRect, isPreview: false)
    lazy var sheetController: ConfigureSheetController = ConfigureSheetController()
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {

        screenSaverView.frame = (window.contentView?.bounds)!;
       // window.toggleFullScreen(self)
        window.contentView?.addSubview(screenSaverView);
        
        Timer.scheduledTimer(timeInterval: screenSaverView.animationTimeInterval, target: screenSaverView, selector:  #selector(screenSaverView.animateOneFrame), userInfo: nil, repeats: true)
        
        
        NSApplication.shared().runModal(for: sheetController.window!)
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
}

