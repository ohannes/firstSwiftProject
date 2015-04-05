//
//  ViewController.swift
//  MyFirstSwift
//
//  Created by Arcelik Design on 05/04/15.
//  Copyright (c) 2015 Arcelik Design. All rights reserved.
//

import UIKit
import iAd

class ViewController: UIViewController, ADBannerViewDelegate {
    @IBOutlet weak var bannerView: ADBannerView!
    @IBOutlet weak var shuffleButton1: UIButton!
    @IBOutlet weak var shuffleButton2: UIButton!
    @IBOutlet weak var topLeftBox: UIView!
    @IBOutlet weak var topRightBox: UIView!
    @IBOutlet weak var bottomBox: UIView!
    @IBOutlet weak var topLeftText: UILabel!
    @IBOutlet weak var topRightText: UILabel!
    @IBOutlet weak var bottomText: UILabel!
    @IBOutlet weak var bottomLeftBox: UIView!
    @IBOutlet weak var bottomRightBox: UIView!
    
    let objects : [NSString : UIColor] = [
        "red":UIColor.redColor(),
        "green":UIColor.greenColor(),
        "blue":UIColor.blueColor(),
        "gray":UIColor.grayColor(),
        "yellow":UIColor.yellowColor(),
        "white":UIColor.whiteColor(),
        "purple":UIColor.purpleColor()
    ]
    
    var keys : NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.delegate = self
        
        self.initButtons()
        self.createKeys()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func bannerViewWillLoadAd(banner: ADBannerView!) {
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        return true
    }
    
    func bannerViewActionDidFinish(banner: ADBannerView!) {
    }
    
    func createKeys() {
        self.keys = NSMutableArray(array: self.objects.keys.array, copyItems:true)
    }
    
    func shuffle(sender: AnyObject) {
        self.disableButtons()
        self.updateBoxWithOffset(topLeftBox, label: topLeftText)
        self.updateBoxWithOffset(topRightBox, label: topRightText)
        self.updateBoxWithOffset(bottomBox, label: bottomText)
    }
    
    func updateBoxWithOffset(box: UIView!, label: UILabel!) {
        var index : NSInteger = self.getRandomNumber(0, upperLimit: self.keys.count)
        var key : NSString = self.keys[index] as NSString
        var color : UIColor = self.objects[key]!
        self.keys.removeObjectAtIndex(index)
        
        label.text = NSString(format: "Shuffling...")
        UIView.animateWithDuration(2.5, animations: {
            box.backgroundColor = color
            }, completion: {
                (value: Bool) in
                label.text = NSString(format: "This box is %@", key)
                if box == self.bottomBox {
                    self.enableButtons()
                    self.createKeys()
                }
        })
    }
    
    func getRandomNumber(lowerLimit : NSInteger, upperLimit : NSInteger) -> NSInteger {
        var difference : NSInteger = upperLimit - lowerLimit
        var random : NSInteger = Int(arc4random_uniform(UInt32(difference)))
        return random + lowerLimit
    }
    
    func initButton(button : UIButton!) {
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .ByWordWrapping
        button.titleLabel?.textAlignment = .Center
        button.addTarget(self, action: "shuffle:", forControlEvents: .TouchUpInside)
    }
    
    func enableButton(button : UIButton!, box : UIView!) {
        button.userInteractionEnabled = true
        box.backgroundColor = UIColor.blackColor()
        button.setTitle("Shuffle", forState: .Normal)
    }
    
    func disableButton(button : UIButton!, box : UIView!) {
        button.userInteractionEnabled = false
        box.backgroundColor = UIColor.grayColor()
        button.setTitle("What do you see now?\nIs it OK or not OK?", forState: .Normal)
    }
    
    func initButtons() {
        self.initButton(self.shuffleButton1)
        self.initButton(self.shuffleButton2)
    }
    
    func enableButtons() {
        self.enableButton(self.shuffleButton1, box: bottomLeftBox)
        self.enableButton(self.shuffleButton2, box: bottomRightBox)
    }
    
    func disableButtons() {
        self.disableButton(self.shuffleButton1, box: bottomLeftBox)
        self.disableButton(self.shuffleButton2, box: bottomRightBox)
    }
}

