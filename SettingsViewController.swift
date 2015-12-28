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
    func setTipNums(tip:[Double])
    func setTheme(theme:Int)
}

class SettingsViewController: UIViewController {
    var tip = 0
    var theme = 0
    var tipNums: [Double] = [0.18, 0.20, 0.22]
    var defaultBlue: UIColor!
    var delegate:SettingsViewControllerDelegate?
    
    @IBOutlet weak var tipSegment: UISegmentedControl!
    @IBOutlet weak var themeSegment: UISegmentedControl!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var view1: UIView! // buttonView
    @IBOutlet weak var view2: UIView! // themeView
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tipSegment.selectedSegmentIndex = tip
        themeSegment.selectedSegmentIndex = theme
        defaultBlue = tipSegment.tintColor
        
        for var i = 0; i < 3; i++ {
            let pct = Int(tipNums[i] * 100)
            tipSegment.setTitle("\(pct)%", forSegmentAtIndex: i)
        }
        
        self.view2.alpha = 1
        self.view1.alpha = 0
        self.doneButton.alpha = 0
        self.editButton.alpha = 1
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
            view2.backgroundColor = UIColor.whiteColor()
        }
        else if (theme == 1) {
            tipSegment.tintColor = UIColor.blackColor()
            themeSegment.tintColor = UIColor.blackColor()
            self.view.backgroundColor = UIColor(red: 181/255, green: 19/255, blue: 19/255, alpha: 1)
            label1.textColor = UIColor.blackColor()
            label2.textColor = UIColor.blackColor()
            view2.backgroundColor = UIColor(red: 181/255, green: 19/255, blue: 19/255, alpha: 1)
        }
        else if (theme == 2) {
            let color: UIColor = UIColor(red: 106/255, green: 107/255, blue: 152/255, alpha: 1)
            tipSegment.tintColor = color
            themeSegment.tintColor = color
            self.view.backgroundColor = UIColor(red: 7/255, green: 13/255, blue: 205/255, alpha: 1)
            label1.textColor = color
            label2.textColor = color
            view2.backgroundColor = UIColor(red: 7/255, green: 13/255, blue: 205/255, alpha: 1)
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
    
    @IBAction func onEditDefault(sender: AnyObject) {
        UIView.animateWithDuration(0.4, animations: {
            if sender.currentTitle == "Edit" {
                self.view1.alpha = 1
                self.view2.alpha = 0
                self.doneButton.alpha = 1
                self.editButton.alpha = 0
            }
            else {
                self.view2.alpha = 1
                self.view1.alpha = 0
                self.editButton.alpha = 1
                self.doneButton.alpha = 0
            }
        })
    }
    
    @IBAction func onButtonsClicked(sender: AnyObject) {
        tipSegment.setTitle(sender.currentTitle, forSegmentAtIndex: tipSegment.selectedSegmentIndex)
        tipNums[tipSegment.selectedSegmentIndex] = Double(((sender.currentTitle!)! as NSString).substringToIndex(2))! / 100
        self.delegate?.setTipNums(tipNums)
    }
    
}
