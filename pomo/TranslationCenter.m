//
//  TranslationCenter.m
//  pomo
//
//  Created by pronebird on 4/18/11.
//  Copyright 2011 Andrei Mikhailov. All rights reserved.
//

#import "TranslationCenter.h"
#import "Translations.h"
#import "GettextTranslations.h"
#import "NOOPTranslations.h"
#import "POParser.h"
#import "MOParser.h"

static TranslationCenter* sharedPtr = nil;
static NOOPTranslations* sharedNOOPTranslations = nil;

@interface TranslationCenter()
@property (readwrite, nonatomic, retain) NSMutableDictionary* domains;
@end


@implementation TranslationCenter
@synthesize defaultPath;
@synthesize domains;
@synthesize locale;

+ (id)sharedCenter
{
	if(sharedPtr == nil)
		sharedPtr = [[TranslationCenter alloc] init];
	
	return sharedPtr;
}

+ (NSString*)stringFullPath:(NSString*)path forDomain:(NSString*)domain locale:(NSString*)locale
{
	return [path stringByAppendingPathComponent:
				[NSString stringWithFormat:@"%@-%@.mo", domain, locale]
			];
}

- (id)init
{
	self = [super init];
	
	if(self) 
	{
		if(sharedNOOPTranslations == nil)
			sharedNOOPTranslations = [[NOOPTranslations alloc] init];
		
		CFLocaleRef lc = CFLocaleCopyCurrent();
		self.locale = (NSString*)CFLocaleGetIdentifier(lc);
		self.defaultPath = nil;
		self.domains = [[[NSMutableDictionary alloc] initWithCapacity:10] autorelease];
		
		CFRelease(lc);
	}
	
	return self;
}

- (void)dealloc
{
	self.domains = nil;
	self.defaultPath = nil;
	self.locale = nil;
}

- (BOOL)loadTextDomain:(NSString*)domain
{
	return [self loadTextDomain:domain path:[TranslationCenter stringFullPath:self.defaultPath forDomain:domain locale:self.locale]];
}

- (BOOL)loadTextDomain:(NSString*)domain path:(NSString*)path
{
	MOParser* po = [[[MOParser alloc] init] autorelease];
	
	if([po importFileAtPath:path]) {
		[self.domains setObject:po forKey:domain];
		return TRUE;
	}
	
	return FALSE;
}

- (BOOL)unloadTextDomain:(NSString*)domain
{
	id obj = [self.domains objectForKey:domain];

	if(obj != nil) 
	{
		[self.domains removeObjectForKey:domain];
		return TRUE;
	}

	return FALSE;
}

@end
