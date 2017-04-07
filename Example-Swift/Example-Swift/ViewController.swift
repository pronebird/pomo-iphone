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
        
        /// Title label
        titleLabel.text = __("Choose number of apples", "Example")
        
        subTitleLabel.text = " "
    }

    @IBAction func sliderValueDidChange(_ sender: AnyObject) {
        let count = Int(slider.value)
        
        /// Sub-title with number of apples
        let format = _n("%@ apple", "%@ apples", count, "Example")
        
        subTitleLabel.text = String(format: format, NSNumber(value: count))
    }
    
}

