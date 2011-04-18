//
//  main.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrew Mikhailov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AML10n.h"

int main (int argc, const char * argv[])
{

	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	// insert code here...
	NSLog(@"Hello, World!");

	AML10n* l10n = [AML10n singleton];
	l10n.defaultPath = @"/Users/pronebird/dev/cocoa-pomo/";
	l10n.locale = @"ru_RU";

	[l10n loadTextDomain:@"textdomain"];

	[pool drain];
    return 0;
}

