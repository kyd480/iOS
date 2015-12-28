//
//  ViewController.swift
//  tips
//
//  Created by Kevin Duong on 12/12/15.
//  Copyright © 2015 Kevin Duong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SettingsViewControllerDelegate {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var bar: UIView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    var themeNum = 0
    var defaultColor: UIColor!
    var defaultBlue: UIColor!
    let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00";
        totalLabel.text = "$0.00";
        defaultColor = bar.backgroundColor!
        defaultBlue = bar.tintColor!
        setTheme(defaults.integerForKey("defaultTheme"))
        setTip(defaults.integerForKey("defaultTip"))
        billField.text = defaults.objectForKey("billAmount") as! String
        changed()
        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
//    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
//        if (segue.identifier == "settings") {
//            let controller : SettingsViewController = segue.sourceViewController as! SettingsViewController
//            print(controller.tip)
//        }
//    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        changed()
    }
    
    func changed() {
        var tipPercentages = [0.18, 0.2, 0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = NSString(string: billField.text!).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        defaults.setObject(billField.text!, forKey: "billAmount")
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! SettingsViewController
        controller.tip = defaults.integerForKey("defaultTip")
        controller.theme = themeNum
        controller.delegate = self
    }
    
    func setTip(tip: Int) {
        tipControl.selectedSegmentIndex = tip
        defaults.setInteger(tip, forKey: "defaultTip")
        changed()
    }
    
    func setTheme(theme: Int) {
        if theme == 0 {
            self.view.backgroundColor = UIColor.whiteColor()
            bar.backgroundColor = defaultColor
            tipControl.tintColor = defaultBlue
            label1.textColor = UIColor.blackColor()
            label2.textColor = UIColor.blackColor()
            label3.textColor = UIColor.blackColor()
            tipLabel.textColor = UIColor.blackColor()
            totalLabel.textColor = UIColor.blackColor()
            billField.backgroundColor = UIColor.whiteColor()
            themeNum = 0
        }
        else if theme == 1 {
            self.view.backgroundColor = UIColor(red: 181/255, green: 19/255, blue: 19/255, alpha: 1)
            bar.backgroundColor = UIColor.blackColor()
            tipControl.tintColor = UIColor.blackColor()
            label1.textColor = UIColor.blackColor()
            label2.textColor = UIColor.blackColor()
            label3.textColor = UIColor.blackColor()
            tipLabel.textColor = UIColor.blackColor()
            totalLabel.textColor = UIColor.blackColor()
            billField.backgroundColor = UIColor.redColor()
            themeNum = 1
        }
        else {
            self.view.backgroundColor = UIColor(red: 7/255, green: 13/255, blue: 205/255, alpha: 1)
            let color: UIColor = UIColor(red: 106/255, green: 107/255, blue: 152/255, alpha: 1)
            bar.backgroundColor = color
            tipControl.tintColor = color
            label1.textColor = color
            label2.textColor = color
            label3.textColor = color
            tipLabel.textColor = color
            totalLabel.textColor = color
            billField.backgroundColor = UIColor.blueColor()
            themeNum = 2
        }
        defaults.setInteger(themeNum, forKey: "defaultTheme")
    }
    
    func setTipNums(tip: [Double]) {
        
    }
}

