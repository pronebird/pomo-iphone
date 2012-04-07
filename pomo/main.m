//
//  main.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrej Mihajlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TranslationCenter.h"
#import "GettextHelpers.h"

#define TEXTDOMAIN @"textdomain"

// @TODO: figure out why I cannot test context because, seems like poedit doesn't support it or cannot pick it up...
int main (int argc, const char * argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	TranslationCenter* translator = [TranslationCenter sharedCenter];
	
	// this path must be changed to directory with your translations (.po, .mo files)
	translator.defaultPath = @"/Users/pronebird/dev/cocoa-pomo/";
	translator.locale = @"ru_RU"; // force ru_RU since I have compiled po/mo with project

	[translator loadTextDomain:TEXTDOMAIN];
	
	NSLog(@"Testing translations...");
	// testing __
	NSLog(@"$ testing singular translation...");
	NSLog(@"test __: Hello world! => %@", __(@"Hello world!", TEXTDOMAIN));
	
	// testing with context, nil or empty string for context should be the same as using __()
	NSLog(@"$ testing with empty/nil context...");
	NSLog(@"test _x: Hello world! => %@", _x(@"Hello world!", nil, TEXTDOMAIN));
	NSLog(@"test _x: Hello world! => %@", _x(@"Hello world!", @"", TEXTDOMAIN));
	NSLog(@"$ testing with context...");
	NSLog(@"test _x: Hello world! => %@", _x(@"Hello world!", @"viseversa", TEXTDOMAIN));
	
	// testing plurals
	NSLog(@"$ testing plurals...");
	NSLog(@"test _n: 1 apple => %@", _n(@"%d apple", @"%d apples", 1, TEXTDOMAIN));
	NSLog(@"test _n: 2 apples => %@", _n(@"%d apple", @"%d apples", 2, TEXTDOMAIN));
	NSLog(@"test _n: 5 apples => %@", _n(@"%d apple", @"%d apples", 5, TEXTDOMAIN));
	NSLog(@"test _n: 100 apples => %@", _n(@"%d apple", @"%d apples", 100, TEXTDOMAIN));
	NSLog(@"$ testing plurals with context...");
	NSLog(@"test _nx: 100 apples => %@", _nx(@"%d apple", @"%d apples", 100, @"viseversa", TEXTDOMAIN));
	
	// testing domain unload
	[translator unloadTextDomain:TEXTDOMAIN];
	NSLog(@"$ testing domain unloading...");
	NSLog(@"test __: Hello world! => %@", __(@"Hello world!", TEXTDOMAIN));

	[pool drain];
    return 0;
}

