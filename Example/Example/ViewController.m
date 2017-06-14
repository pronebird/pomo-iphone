//
//  ViewController.m
//  Example
//
//  Created by pronebird on 6/13/16.
//  Copyright © 2016 pronebird. All rights reserved.
//

#import "ViewController.h"

@import pomo_iphone;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// Title label
    self.titleLabel.text = _(@"Choose number of apples", @"Example");
    
    self.subTitleLabel.text = @" ";
}

- (IBAction)sliderValueDidChange:(id)sender {
    /// Sub-title with number of apples
    NSInteger numApples = self.slider.value;
    NSString *format = _n(@"%@ apple", @"%@ apples", numApples, @"Example");
    
    self.subTitleLabel.text = [NSString stringWithFormat:format, numApples];
}

@end
