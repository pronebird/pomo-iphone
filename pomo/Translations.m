//
//  Translations.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Translations.h"


@implementation Translations

- (id) init
{
	self = [super init];
	
	if(self) {
		entries = [[NSMutableDictionary alloc] initWithCapacity:50];
		headers = [[NSMutableDictionary alloc] initWithCapacity:10];
	}
	
	return self;
}

- (void) dealloc
{
	[entries release];
	[headers release];
}

- (void) addEntry : (TranslationEntry*)entry
{
	
}

- (void) setHeader : (NSString*)header value: (NSString*)value
{
	
}

- (NSString*) getHeader : (NSString*)header
{
	return nil;
}

- (uint8) selectPluralForm : (NSInteger) count
{
	return count == 1 ? 0 : 1;
}

- (uint8) getPluralFormsCount
{
	return 2;
}

- (NSString*) translate : (NSString*)singular context: (NSString*)context
{
	return nil;
}

- (NSString*) translatePlural : (NSString*)singular plural: (NSString*)plural count: (NSInteger)count context: (NSString*)context
{
	uint8 index = [self selectPluralForm:count];
	uint8 totalPluralForms = [self getPluralFormsCount];
	
	if(false /* if translated */) {
		
	}
	
	return 1 == count ? singular : plural;
}

@end
