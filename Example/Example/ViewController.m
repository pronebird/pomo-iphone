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
    
    self.titleLabel.text = _(@"Choose number of apples", @"Example");
    self.subTitleLabel.text = @" ";
}

- (IBAction)sliderValueDidChange:(id)sender {
    NSString *format = _n(@"%@ apple", @"%@ apples", self.slider.value, @"Example");
    
    self.subTitleLabel.text = [NSString stringWithFormat:format, [NSNumber numberWithInteger:self.slider.value]];
}

@end
