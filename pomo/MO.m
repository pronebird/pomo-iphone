//
//  MO.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MO.h"


@implementation MO

- (id) init
{
	self = [super init];
	
	if(self)
	{
		
	}
	
	return self;
}

- (void) dealloc
{
	[super dealloc];
}

- (bool) import : (NSString*)filename
{
	return false;
}

- (TranslationEntry*) readEntry: (NSFileHandle*)file
{
	return nil;
}

@end
