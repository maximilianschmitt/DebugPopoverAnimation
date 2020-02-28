//
//  ViewController.swift
//  DebugPopoverAnimation
//
//  Created by Maximilian Schmitt on 29.02.20.
//  Copyright © 2020 Maximilian Schmitt. All rights reserved.
//

import Cocoa

class MasterViewController: NSViewController {
    var parentPopover: NSPopover?
    let width = CGFloat(275)
    let height = CGFloat(450)
    var currentViewController: NSViewController?

    let viewController1: ChildViewController = {
        let viewController = ChildViewController()
        viewController.height = 300
        viewController.view.wantsLayer = true
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.button.title = "Forward"
        viewController.button.action = #selector(showViewController2)
        return viewController
    }()
    let viewController2: ChildViewController = {
        let viewController = ChildViewController()
        viewController.height = 500
        viewController.view.wantsLayer = true
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.button.title = "Backward"
        viewController.button.action = #selector(showViewController1)
        return viewController
    }()
    
    override func loadView() {
        self.view = NSView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.wantsLayer = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer?.backgroundColor = NSColor.blue.withAlphaComponent(0.1).cgColor
        
        showViewController1()
    }
    
    @objc func showViewController1() {
        loadViewController(viewController1, withTransition: [.crossfade, .slideRight])
    }
    
    @objc func showViewController2() {
        loadViewController(viewController2, withTransition: [.crossfade, .slideLeft])
    }

    func loadViewController(_ childViewController: NSViewController, withTransition transitionOptions: NSViewController.TransitionOptions?) {
        addChild(childViewController)
        view.addSubview(childViewController.view)

        childViewController.view.layer?.borderColor = NSColor(calibratedRed: 0, green: 255, blue: 0, alpha: 1).cgColor
        childViewController.view.layer?.borderWidth = 2
        
        childViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        view.layout()
        
        let oldViewController = currentViewController
        currentViewController = childViewController
        
        oldViewController?.view.layer?.borderColor = NSColor(calibratedRed: 255, green: 0, blue: 0, alpha: 1).cgColor
        oldViewController?.view.layer?.borderWidth = 2

        if let oldViewController = oldViewController  {
            transition(from: oldViewController, to: currentViewController!, options: transitionOptions ?? .slideLeft, completionHandler: { [weak oldViewController] in
                oldViewController?.removeFromParent()
                oldViewController?.view.removeFromSuperview()
            })
        }
        
        NSAnimationContext.runAnimationGroup({ (context) -> Void in
            context.duration = 0.5
            context.allowsImplicitAnimation = true
            
            self.parentPopover?.contentSize = NSSize(width: childViewController.preferredContentSize.width, height: childViewController.preferredContentSize.height)
        }) {
            oldViewController?.removeFromParent()
            oldViewController?.view.removeFromSuperview()
        }
    }
}
