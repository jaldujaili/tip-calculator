//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Jordan Aldujaili on 4/9/15.
//  Copyright (c) 2015 Jordan Aldujaili. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let randomColorDelegate = RandomColorTextFieldDelegate()
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPercentageControl: UISegmentedControl!
    @IBOutlet weak var tipAndTotal:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        //add color (for fun)
        self.billField.delegate = randomColorDelegate
        view.backgroundColor = randomColorDelegate.randomColor()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        updateTip()
        //makes labels appear when making changes
        self.tipAndTotal.hidden = false
        
    }
    // Recalculate the tip
    func updateTip() {
        let tipPercentages = [0.1, 0.15, 0.2]
        let tipPercentage = tipPercentages[tipPercentageControl.selectedSegmentIndex]
        
        //format strings
        let formatString = "$%.2f"
        
        let billAmount = (billField.text as NSString).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = String(format: formatString, tip)
        totalLabel.text = String(format: formatString, total)
        view.backgroundColor = randomColorDelegate.randomColor()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
        self.tipAndTotal.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //loading from settings
        let defaults = NSUserDefaults.standardUserDefaults()
        var defaultTip = defaults.integerForKey("default_tip")
        println("got default tip: \(defaultTip)")
        switch defaultTip {
        case 0...2:
            tipPercentageControl.selectedSegmentIndex = defaultTip
        default:
            tipPercentageControl.selectedSegmentIndex = 0
        }
        
        
        updateTip()
    }
    
    @IBAction func goToSettings() {
        performSegueWithIdentifier("settings", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as SettingsViewController

    }
    
}




