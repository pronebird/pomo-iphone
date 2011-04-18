//
//  TranslationEntry.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrew Mikhailov. All rights reserved.
//

#import "AMTranslationEntry.h"


@implementation AMTranslationEntry

@synthesize is_plural;
@synthesize context;
@synthesize singular;
@synthesize plural;
@synthesize translations;
@synthesize translator_comments;
@synthesize extracted_comments;
@synthesize references;
@synthesize flags;

- (id) init
{
	self = [super init];
	
	if(self)
	{
		self.is_plural = false;
		self.context = nil;
		self.singular = nil;
		self.plural = nil;
		self.translations = [[NSMutableArray alloc] init];
		self.translator_comments = nil;
		self.extracted_comments = nil;
		self.references = [[NSMutableArray alloc] init];
		self.flags = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void) dealloc
{
	self.context = nil;
	self.singular = nil;
	self.plural = nil;
	self.translations = nil;
	self.translator_comments = nil;
	self.extracted_comments = nil;
	self.references = nil;
	self.flags = nil;
}

- (NSString*) key 
{
	return [AMTranslationEntry stringKey:self.singular context:self.context];
}

+ (NSString*) stringKey : (NSString*)singular
{
	return [self stringKey:singular context:nil];
}

+ (NSString*) stringKey : (NSString*)singular context: (NSString*)context
{
	if(singular == nil)
		return nil;
	
	return context == nil ? singular : [NSString stringWithFormat:@"%@%c%@", context, '\4', singular];	
}

@end
