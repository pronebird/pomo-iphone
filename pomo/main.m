//
//  main.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrew Mikhailov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TranslationCenter.h"

int main (int argc, const char * argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	TranslationCenter* translator = [TranslationCenter sharedCenter];
	translator.defaultPath = @"/Users/pronebird/dev/cocoa-pomo/";
	translator.locale = @"ru_RU";

	[translator loadTextDomain:@"textdomain"];

	[pool drain];
    return 0;
}

