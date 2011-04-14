//
//  main.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PO.h"

int main (int argc, const char * argv[])
{

	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	// insert code here...
	NSLog(@"Hello, World!");
	
	PO* pomo = [[PO alloc] init];
	
	[pomo importFileAtPath:@"/Users/pronebird/dev/cocoa-pomo/test.po"];
	
	[pomo release];

	[pool drain];
    return 0;
}

