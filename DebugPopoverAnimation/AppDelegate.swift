//
//  AppDelegate.swift
//  DebugPopoverAnimation
//
//  Created by Maximilian Schmitt on 29.02.20.
//  Copyright © 2020 Maximilian Schmitt. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let popover: NSPopover = {
        let popover = NSPopover()
        popover.behavior = NSPopover.Behavior.transient
        popover.appearance = NSAppearance(named: .vibrantDark)
        popover.animates = true
        return popover
    }()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.button?.title = "D"
        statusItem.button?.action = #selector(showPopover)
        
        showPopover()
    }
    
    @objc func showPopover() {
        let masterViewController = MasterViewController()
        masterViewController.parentPopover = popover
        popover.contentViewController = masterViewController
        popover.show(relativeTo: statusItem.button!.bounds, of: statusItem.button!, preferredEdge: NSRectEdge.maxY)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

