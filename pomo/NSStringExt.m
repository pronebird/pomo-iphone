//
//  NSStringExt.m
//  pomo
//
//  Created by pronebird on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSStringExt.h"


@implementation NSString (NSStringExt)

- (NSArray*) componentsSeparatedByString:(NSString *)separator limit: (NSUInteger)limit
{
	NSScanner* scan = [NSScanner scannerWithString:self];
	NSString* token = nil;
	NSMutableArray* array = [[[NSMutableArray alloc] initWithCapacity:limit+1] autorelease];
	
	NSUInteger i = 0;
	
	while([scan scanUpToString:separator intoString:&token] && (limit == 0 || i++ < limit))
	{
		[array addObject:token];
	}
	
	return [NSArray arrayWithArray:array];
}

- (NSArray*) split : (NSString*)separator 
{
	NSScanner* scan = [NSScanner scannerWithString:self];
	NSString* token = nil;
	NSMutableArray* array = [[[NSMutableArray alloc] initWithCapacity:2] autorelease];
	
	if([scan scanUpToString:separator intoString:&token])
	{
		[array addObject:token];
		
		NSUInteger pos = [scan scanLocation]+1;
		
		if(pos < self.length)
			[array addObject:[self substringFromIndex:pos]];
	}

	
	return [NSArray arrayWithArray:array];	
}

@end
