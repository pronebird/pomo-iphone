//
//  ViewController.swift
//  Example-Swift
//
//  Created by pronebird on 6/13/16.
//  Copyright © 2016 pronebird. All rights reserved.
//

import UIKit
import pomo_iphone

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var subTitleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = _("Choose number of apples", "Example")
        subTitleLabel.text = " "
    }

    @IBAction func sliderValueDidChange(sender: AnyObject) {
        let count = Int(slider.value)
        
        subTitleLabel.text = _n("\(count) apple", "\(count) apples", count, "Example")
    }
    
}

