//
//  main.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrew Mikhailov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TranslationCenter.h"
#import "GettextHelpers.h"

int main (int argc, const char * argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	TranslationCenter* translator = [TranslationCenter sharedCenter];
	
	// this path must be changed to directory with your translations (.po, .mo files)
	translator.defaultPath = @"/Users/pronebird/dev/cocoa-pomo/";
	translator.locale = @"ru_RU";

	[translator loadTextDomain:@"textdomain"];
	
	NSLog(@"Testing translations...");
	// testing __
	NSLog(@"test __: Hello world! => %@", __(@"Hello world!", @"textdomain"));
	
	// testing with context, nil or empty string for context should be the same as using __()
	NSLog(@"test _c: Hello world! => %@", _c(@"Hello world!", nil, @"textdomain"));
	NSLog(@"test _c: Hello world! => %@", _c(@"Hello world!", @"", @"textdomain"));
	
	// testing plurals
	NSLog(@"test _n: 1 apple => %@", _n(@"%d apple", @"%d apples", 1, @"textdomain"));
	NSLog(@"test _n: 2 apples => %@", _n(@"%d apple", @"%d apples", 2, @"textdomain"));
	NSLog(@"test _n: 5 apples => %@", _n(@"%d apple", @"%d apples", 5, @"textdomain"));
	NSLog(@"test _n: 100 apples => %@", _n(@"%d apple", @"%d apples", 100, @"textdomain"));

	[pool drain];
    return 0;
}

