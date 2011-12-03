//
//  Translations.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrew Mikhailov. All rights reserved.
//

#import "AMTranslations.h"

@interface AMTranslations()

@property (readwrite, nonatomic, retain) NSMutableDictionary* entries;
@property (readwrite, nonatomic, retain) NSMutableDictionary* headers;

@end


@implementation AMTranslations

@synthesize entries;
@synthesize headers;

- (id)init
{
	self = [super init];
	
	if(self) {
		self.entries = [[[NSMutableDictionary alloc] init] autorelease];
		self.headers = [[[NSMutableDictionary alloc] init] autorelease];
	}
	
	return self;
}

- (void)dealloc
{
	self.entries = nil;
	self.headers = nil;
}

- (void)addEntry:(AMTranslationEntry*)entry
{
	NSString* key = [entry key];
	
	if(key == nil)
		return;
	
	[self.entries setObject:entry forKey:key];
}

- (void)setHeader:(NSString*)header value:(NSString*)value
{
	[self.headers setObject:value forKey:header];
}

- (NSString*)header:(NSString*)header
{
	return [self.headers objectForKey:header];
}

- (uint8)selectPluralForm:(NSInteger)count
{
	return count == 1 ? 0 : 1;
}

- (uint8)getPluralFormsCount
{
	return 2;
}

- (NSString*)translate:(NSString*)singular
{
	return [self translate:singular context:nil];
}

- (NSString*)translate:(NSString*)singular context:(NSString*)context
{
	NSString* key = [AMTranslationEntry stringKey:singular context:context], *translated = nil;
	AMTranslationEntry* entry = nil;
	
	if(key != nil && 
	   (entry = [self.entries objectForKey:key]) != nil && 
	   entry.translations.count)
	{
		translated = [entry.translations objectAtIndex:0];
	}
	
	return translated ? translated : singular;
}

- (NSString*)translatePlural:(NSString*)singular plural:(NSString*)plural count:(NSInteger)count context:(NSString*)context
{
	NSString* key = [AMTranslationEntry stringKey:singular context:context];
	AMTranslationEntry* entry = nil;
	
	uint8 index = [self selectPluralForm:count];
	uint8 total_plural_forms = [self getPluralFormsCount];
	
	if(key != nil && 
	   (entry = [self.entries objectForKey:key]) != nil && 
	   index >= 0 && index < total_plural_forms && 
	   index < entry.translations.count)
	{
		return [entry.translations objectAtIndex:index];
	}
	
	return 1 == count ? singular : plural;
}

@end
