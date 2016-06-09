//
//  HamburgerViewController.swift
//  YoutubeDemo
//
//  Created by Scott Horsfall on 6/7/16.
//  Copyright © 2016 Scott Horsfall. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var feedView: UIView!
    var menuViewController: UIViewController!
    var feedViewController: UIViewController!
    
    var feedViewOriginalCenter: CGPoint!
    
    var feedRightOffset: CGFloat!
    var feedLeft: CGPoint!
    var feedRight: CGPoint!
    
    var menuOriginalScale: CGFloat!
    
    var menuOpen: Bool!
    
    let main = UIStoryboard(name: "Main", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.        
        let menuVC = main.instantiateViewControllerWithIdentifier("MenuViewController")
        let feedVC = main.instantiateViewControllerWithIdentifier("FeedViewController")
        
        addChildViewController(menuVC)
        menuView.addSubview(menuVC.view)
        menuVC.didMoveToParentViewController(self)
        
        addChildViewController(feedVC)
        feedView.addSubview(feedVC.view)
        feedVC.didMoveToParentViewController(self)
        
        //setup the screenedge swipe vals
        feedRightOffset = 274
        feedLeft = feedView.center
        feedRight = CGPoint(x: feedView.center.x + feedRightOffset, y: feedView.center.y)
        
        menuOriginalScale = 0.9
        menuOpen = false
        
        menuView.transform = CGAffineTransformMakeScale(menuOriginalScale, menuOriginalScale)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func openMenu(open: Bool) {
        // custom function to open/close the menu view
        
        if open {
            //snap to the right
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 1,  options: [], animations: {
                () -> Void in
                    self.feedView.center = self.feedRight
                
                    // cc @Codepath not sure if this is the best way to do this
                    self.menuView.transform = CGAffineTransformMakeScale(1, 1)
                }, completion: { (Bool) -> Void in
                    self.menuOpen = true
            })
        } else {
            //snap to the left
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1,  options: [], animations: {
                () -> Void in
                    self.feedView.center = self.feedLeft
                
                    // cc @Codepath not sure if this is the best way to do this
                    self.menuView.transform = CGAffineTransformMakeScale(self.menuOriginalScale, self.menuOriginalScale)
                
                }, completion: { (Bool) -> Void in
                    self.menuOpen = false
                    
            })
        }
    }

    @IBAction func onFeedPan(sender: UIPanGestureRecognizer) {
        
        //let point = sender.locationInView(view)
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        var panProgress: CGFloat!
        
        // determine which way to scale
        // this could probably be cleaner...
        if menuOpen == true {
            panProgress = convertValue(abs(translation.x), r1Min: 0, r1Max: feedRightOffset, r2Min: 1, r2Max: menuOriginalScale)
        } else {
            panProgress = convertValue(abs(translation.x), r1Min: 0, r1Max: feedRightOffset, r2Min: menuOriginalScale, r2Max: 1)
        }
                
        if sender.state == UIGestureRecognizerState.Began {
            
            feedViewOriginalCenter = feedView.center
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            feedView.center.x = feedViewOriginalCenter.x + translation.x
            
            menuView.transform = CGAffineTransformMakeScale(panProgress, panProgress)
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            if velocity.x > 0 {
                // open menu
                openMenu(true)
                
            } else {
                // close menu
                openMenu(false)
            }
        }
        
    }
}
