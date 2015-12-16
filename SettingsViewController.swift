//
//  SettingsViewController.swift
//  tips
//
//  Created by Kevin Duong on 12/12/15.
//  Copyright © 2015 Kevin Duong. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    func setTip(tip:Int)
    func setTheme(theme:Int)
}

class SettingsViewController: UIViewController {
    var tip = 0
    var theme = 0
    var defaultBlue: UIColor!
    
//    @IBAction func tipSegmentController(sender: UISegmentedControl) {
//        tip = sender.selectedSegmentIndex
//        performSegueWithIdentifier("settings", sender: self)
//    }
    var delegate:SettingsViewControllerDelegate?
    
    @IBOutlet weak var tipSegment: UISegmentedControl!
    @IBOutlet weak var themeSegment: UISegmentedControl!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tipSegment.selectedSegmentIndex = tip
        themeSegment.selectedSegmentIndex = theme
        defaultBlue = tipSegment.tintColor
        changeTheme(theme)
    }

    func changeTheme(theme: Int) {
        if (theme == 0)
        {
            tipSegment.tintColor = defaultBlue
            themeSegment.tintColor = defaultBlue
            self.view.backgroundColor = UIColor.whiteColor()
            label1.textColor = UIColor.blackColor()
            label2.textColor = UIColor.blackColor()
        }
        else if (theme == 1) {
            tipSegment.tintColor = UIColor.blackColor()
            themeSegment.tintColor = UIColor.blackColor()
            self.view.backgroundColor = UIColor(red: 181/255, green: 19/255, blue: 19/255, alpha: 1)
            label1.textColor = UIColor.blackColor()
            label2.textColor = UIColor.blackColor()
        }
        else if (theme == 2) {
            let color: UIColor = UIColor(red: 106/255, green: 107/255, blue: 152/255, alpha: 1)
            tipSegment.tintColor = color
            themeSegment.tintColor = color
            self.view.backgroundColor = UIColor(red: 7/255, green: 13/255, blue: 205/255, alpha: 1)
            label1.textColor = color
            label2.textColor = color
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        if sender as! NSObject == tipSegment {
            self.delegate?.setTip(tipSegment.selectedSegmentIndex)
        }
        else {
            self.delegate?.setTheme(themeSegment.selectedSegmentIndex)
            changeTheme(themeSegment.selectedSegmentIndex)
        }
    }
    
}
