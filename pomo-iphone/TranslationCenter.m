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

static NOOPTranslations* sharedNOOPTranslations;

@interface TranslationCenter()
@property (readwrite, nonatomic, strong) NSMutableDictionary* domains;
@end


@implementation TranslationCenter

+ (instancetype)sharedCenter {
	static TranslationCenter* sharedInstance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [self new];
		sharedNOOPTranslations = [NOOPTranslations new];
	});
	return sharedInstance;
}

+ (NSString*)textDomainFileWithBasePath:(NSString*)path forDomain:(NSString*)domain language:(NSString*)language type:(NSString*)ext {
	NSString* filename = [NSString stringWithFormat:@"%@-%@.%@", domain, language, ext ? [ext lowercaseString] : @"mo"];
	return [path stringByAppendingPathComponent:filename];
}

- (id)init {
	if(self = [super init]) {
		self.language = [[NSLocale preferredLanguages] firstObject];
		self.defaultPath = [[NSBundle mainBundle] bundlePath];
		self.domains = [NSMutableDictionary new];
	}
	return self;
}


- (BOOL)isValidTextDomain:(NSString*)domain {
	return domain != nil && ![domain isEqualToString:@""];
}

- (BOOL)loadTextDomain:(NSString*)domain {
	NSFileManager* fileManager = [NSFileManager defaultManager];
	NSString* path = [TranslationCenter textDomainFileWithBasePath:self.defaultPath forDomain:domain language:self.language type:@"mo"];
	
	if(![fileManager fileExistsAtPath:path]) {
		path = [TranslationCenter textDomainFileWithBasePath:self.defaultPath forDomain:domain language:self.language type:@"po"];
		if(![fileManager fileExistsAtPath:path]) {
			return NO;
		}
	}
	
	return [self loadTextDomain:domain path:path];
}

- (BOOL)loadTextDomain:(NSString*)domain path:(NSString*)path {
	id<ParserProtocol> parser;
	
	if([path.pathExtension isEqualToString:@"mo"]) {
		parser = [MOParser new];
	} else if([path.pathExtension isEqualToString:@"po"]) {
		parser = [POParser new];
	} else {
		return NO;
	}
	
	NSLog(@"Loading %@ using %@", path, NSStringFromClass([parser class]));
	
	if([parser importFileAtPath:path]) {
		[self.domains setObject:parser forKey:domain];
		return YES;
	}
	
	return NO;
}

- (BOOL)unloadTextDomain:(NSString*)domain {
	id obj = [self.domains objectForKey:domain];

	if(obj != nil) {
		[self.domains removeObjectForKey:domain];
		return YES;
	}

	return NO;
}

- (NSString*)translate:(NSString*)singular domain:(NSString*)domain
{
	GettextTranslations* obj;
	
	if([self isValidTextDomain:domain]) {
		obj = [self.domains objectForKey:domain];
		
		if(obj) {
			return [obj translate:singular];
		}
	}
	
	return [sharedNOOPTranslations translate:singular];
}

- (NSString*)translate:(NSString*)singular context:(NSString*)context domain:(NSString*)domain {
	GettextTranslations* obj;
	
	if([self isValidTextDomain:domain]) {
		obj = [self.domains objectForKey:domain];
		
		if(obj) {
			return [obj translate:singular context:context];
		}
	}
	
	return [sharedNOOPTranslations translate:singular context:context];	
}

- (NSString*)translatePlural:(NSString*)singular plural:(NSString*)plural count:(NSInteger)count context:(NSString*)context domain:(NSString*)domain
{
	GettextTranslations* obj;
	
	if([self isValidTextDomain:domain]) {
		obj = [self.domains objectForKey:domain];
		
		if(obj) {
			return [obj translatePlural:singular plural:plural count:count context:context];
		}
	}
	
	return [sharedNOOPTranslations translatePlural:singular plural:plural count:count context:context];
}

@end
