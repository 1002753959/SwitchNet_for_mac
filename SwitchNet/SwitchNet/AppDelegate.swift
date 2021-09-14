//
//  AppDelegate.swift
//  SwitchNet
//
//  Created by YiEN on 2021/1/19.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    //全局存储状态栏管理
    @IBOutlet weak var statusItemManager: StatusItemManager!
//    var statusItem: NSStatusItem?
    
 
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    
//    func createStatusBar(){
//        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
//        statusItem?.button?.title = "SwitchNet"
//    }
}

