//
//  ChildViewController.swift
//  DebugPopoverAnimation
//
//  Created by Maximilian Schmitt on 29.02.20.
//  Copyright © 2020 Maximilian Schmitt. All rights reserved.
//

import Cocoa

class ChildViewController: NSViewController {
    var width = CGFloat(275)
    var height = CGFloat(450)
    var button = NSButton()
    
    override func loadView() {
        self.view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = NSSize(width: width, height: height)

        view.translatesAutoresizingMaskIntoConstraints = false

        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
