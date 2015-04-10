//
//  SettingsViewController.swift
//  Tip Calculator
//
//  Created by Jordan Aldujaili on 4/9/15.
//  Copyright (c) 2015 Jordan Aldujaili. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    let randomColorDelegate = RandomColorTextFieldDelegate()
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         view.backgroundColor = randomColorDelegate.randomColor()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTouchDone(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onEditDefaultTip(sender: UISegmentedControl) {
        //saving
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setInteger(sender.selectedSegmentIndex, forKey: "default_tip")
        defaults.synchronize()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var defaultTip = defaults.integerForKey("default_tip")
        println("got default tip: \(defaultTip)")
        switch defaultTip {
        case 0...2:
            defaultTipControl.selectedSegmentIndex = defaultTip
        default:
            defaultTipControl.selectedSegmentIndex = 0
        }
    }
    
}
