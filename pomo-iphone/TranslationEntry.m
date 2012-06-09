//
//  TranslationEntry.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrej Mihajlov. All rights reserved.
//

#import "TranslationEntry.h"


@implementation TranslationEntry

@synthesize is_plural;
@synthesize context;
@synthesize singular;
@synthesize plural;
@synthesize translations;
@synthesize translator_comments;
@synthesize extracted_comments;
@synthesize references;
@synthesize flags;

- (id)init
{
	self = [super init];
	
	if(self)
	{
		self.is_plural = false;
		self.context = nil;
		self.singular = nil;
		self.plural = nil;
		self.translations = [[[NSMutableArray alloc] init] autorelease];
		self.translator_comments = nil;
		self.extracted_comments = nil;
		self.references = [[[NSMutableArray alloc] init] autorelease];
		self.flags = [[[NSMutableArray alloc] init] autorelease];
	}
	
	return self;
}

- (void)dealloc
{
	self.context = nil;
	self.singular = nil;
	self.plural = nil;
	self.translations = nil;
	self.translator_comments = nil;
	self.extracted_comments = nil;
	self.references = nil;
	self.flags = nil;
	
	[super dealloc];
}

- (NSString*)key 
{
	return [TranslationEntry stringKey:self.singular context:self.context];
}

+ (NSString*)stringKey:(NSString*)singular
{
	return [self stringKey:singular context:nil];
}

+ (NSString*)stringKey:(NSString*)singular 
			   context:(NSString*)context
{
	if(singular == nil)
		return nil;
	
	return (context == nil || [context isEqualToString:@""]) ? singular : [NSString stringWithFormat:@"%@%c%@", context, '\4', singular];	
}

- (void)debugPrint {
	NSLog(@"new entry\nsingular: %@\nplural: %@\nis_plural: %d\ntranslator comments:%@\n", self.singular, self.plural, self.is_plural, self.translator_comments);
	
	NSLog(@"translations:\n");
	NSUInteger i = 0;
	for(NSString* tr in self.translations) {
		NSLog(@"[%u] %@\n", i++, tr);
	}
	
	NSLog(@"references:\n");
	i = 0;
	for(NSString* ref in self.references) {
		NSLog(@"[%u] %@\n", i++, ref);
	}
	
	NSLog(@"flags:\n");
	i = 0;
	for(NSString* flag in self.flags) {
		NSLog(@"[%u] %@\n", i++, flag);
	}
	
	NSLog(@"--");
}

@end
