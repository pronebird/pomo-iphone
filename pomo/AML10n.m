//
//  AML10n.m
//  pomo
//
//  Created by pronebird on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AML10n.h"
#import "AMTranslations.h"
#import "AMGettextTranslations.h"
#import "AMNOOPTranslations.h"
#import "AMPOParser.h"

static AML10n* sharedAML10n = nil;
static AMNOOPTranslations* sharedNOOPTranslations = nil;

@interface AML10n()

@property (readwrite, nonatomic, retain) NSMutableDictionary* domains;

@end


@implementation AML10n

@synthesize defaultPath;
@synthesize domains;
@synthesize locale;

+ (id) singleton
{
	if(sharedAML10n == nil)
		sharedAML10n = [[AML10n alloc] init];
	
	return sharedAML10n;
}

+ (NSString*)stringFullPath:(NSString*)path forDomain:(NSString*)domain locale:(NSString*)locale
{
	return [path stringByAppendingPathComponent:
				[NSString stringWithFormat:@"%@-%@.po", domain, locale]
			];
}

- (id)init
{
	self = [super init];
	
	if(self) 
	{
		// pre-create noop
		if(sharedNOOPTranslations == nil)
			sharedNOOPTranslations = [[AMNOOPTranslations alloc] init];
		
		CFLocaleRef lc = CFLocaleCopyCurrent();
		self.locale = (NSString*)CFLocaleGetIdentifier(lc);
		self.domains = [[NSMutableDictionary alloc] initWithCapacity:10];
		
		CFRelease(lc);
	}
	
	return self;
}

- (void)dealloc
{
	self.domains = nil;
}

- (bool)loadTextDomain:(NSString*)domain
{
	return [self loadTextDomain:domain path:[AML10n stringFullPath:self.defaultPath forDomain:domain locale:self.locale]];
}

- (bool)loadTextDomain:(NSString*)domain path:(NSString*)path
{
	AMPOParser* po = [[[AMPOParser alloc] init] autorelease];
	
	if([po importFileAtPath:path]) {
		
		[self.domains setObject:po forKey:domain];
		
		return true;
	}
	
	return false;
}

- (bool)unloadTextDomain:(NSString*)domain
{
	id obj = [self.domains objectForKey:domain];
	
	if(obj != nil) {
		[self.domains removeObjectForKey:domain];
		
		return true;
	}
	
	return false;
}

@end
