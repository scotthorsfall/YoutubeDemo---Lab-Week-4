//
//  MenuViewController.swift
//  YoutubeDemo
//
//  Created by Scott Horsfall on 6/7/16.
//  Copyright © 2016 Scott Horsfall. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var hamburgerVC: HamburgerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onNavButton(sender: AnyObject) {
        print("nav button tapped")
        
        // close the menu in hamburger view
        //hamburgerVC.openMenu(false)
        /* ^ is throwing: fatal error: unexpectedly found nil while unwrapping an Optional value */
        
        // switch to approprate view depending on button
        // tbd
    }
    
}
