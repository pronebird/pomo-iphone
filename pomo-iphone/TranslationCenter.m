//
//  TranslationCenter.m
//  pomo
//
//  Created by pronebird on 4/18/11.
//  Copyright 2011 Andrej Mihajlov. All rights reserved.
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

+ (NSString*)stringFullPath:(NSString*)path 
				  forDomain:(NSString*)domain 
					 locale:(NSString*)locale 
					   type:(NSString*)ext
{
	return [path stringByAppendingPathComponent:
				[NSString stringWithFormat:@"%@-%@.%@", domain, locale, 
				 ext ? [ext lowercaseString] : @"mo"]];
}

- (id)init
{
	self = [super init];
	
	if(self) 
	{
		if(sharedNOOPTranslations == nil)
			sharedNOOPTranslations = [[NOOPTranslations alloc] init];
		
		self.locale = [[NSLocale currentLocale] localeIdentifier];
		self.defaultPath = [[NSBundle mainBundle] bundlePath];
		self.domains = [[[NSMutableDictionary alloc] initWithCapacity:10] autorelease];
	}
	
	return self;
}

- (void)dealloc
{
	self.domains = nil;
	self.defaultPath = nil;
	self.locale = nil;
	
	[super dealloc];
}

- (BOOL)isValidTextDomain:(NSString*)domain {
	return domain != nil && ![domain isEqualToString:@""];
}

- (BOOL)loadTextDomain:(NSString*)domain
{
	NSFileManager* fileManager = [NSFileManager defaultManager];
	NSString* path = [TranslationCenter stringFullPath:self.defaultPath forDomain:domain locale:self.locale type:@"mo"];
	
	if(![fileManager fileExistsAtPath:path]) {
		path = [TranslationCenter stringFullPath:self.defaultPath forDomain:domain locale:self.locale type:@"po"];
		if(![fileManager fileExistsAtPath:path])
			return FALSE;
	}
	
	return [self loadTextDomain:domain path:path];
}

- (BOOL)loadTextDomain:(NSString*)domain path:(NSString*)path
{
	id<ParserProtocol> parser;
	
	if([path.pathExtension isEqualToString:@"mo"]) 
		parser = [[[MOParser alloc] init] autorelease];
	else if([path.pathExtension isEqualToString:@"po"]) 
		parser = [[[POParser alloc] init] autorelease];
	else
		return FALSE;
	
	NSLog(@"Loading %@ using %@", path, NSStringFromClass([parser class]));
	
	if([parser importFileAtPath:path]) {
		[self.domains setObject:parser forKey:domain];
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

- (NSString*)translate:(NSString*)singular 
				domain:(NSString*)domain 
{
	GettextTranslations* obj;
	
	if([self isValidTextDomain:domain])
	{
		obj = [self.domains objectForKey:domain];
		
		if(obj)
			return [obj translate:singular];
	}
	
	return [sharedNOOPTranslations translate:singular];
}

- (NSString*)translate:(NSString*)singular 
			   context:(NSString*)context 
				domain:(NSString*)domain 
{
	GettextTranslations* obj;
	
	if([self isValidTextDomain:domain])
	{
		obj = [self.domains objectForKey:domain];
		
		if(obj)
			return [obj translate:singular context:context];
	}
	
	return [sharedNOOPTranslations translate:singular context:context];	
}

- (NSString*)translatePlural:(NSString*)singular 
					  plural:(NSString*)plural 
					   count:(NSInteger)count 
					 context:(NSString*)context 
					  domain:(NSString*)domain 
{
	GettextTranslations* obj;
	
	if([self isValidTextDomain:domain]) 
	{
		obj = [self.domains objectForKey:domain];
		
		if(obj)
			return [obj translatePlural:singular plural:plural count:count context:context];
	}
	
	return [sharedNOOPTranslations translatePlural:singular plural:plural count:count context:context];
}

@end
