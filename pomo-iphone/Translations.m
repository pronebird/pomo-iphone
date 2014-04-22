//
//  Translations.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrej Mihajlov. All rights reserved.
//

#import "Translations.h"

@interface Translations()

@property (readwrite, nonatomic, strong) NSMutableDictionary* entries;
@property (readwrite, nonatomic, strong) NSMutableDictionary* headers;

@end


@implementation Translations

- (id)init {
	if(self = [super init]) {
		self.entries = [NSMutableDictionary new];
		self.headers = [NSMutableDictionary new];
	}
	return self;
}


- (void)addEntry:(TranslationEntry*)entry {
	NSString* key = [entry key];
	
	if(key == nil)
		return;
	
	[self.entries setObject:entry forKey:key];
}

- (void)setHeader:(NSString*)header value:(NSString*)value {
	[self.headers setObject:value forKey:header];
}

- (NSString*)header:(NSString*)header {
	return [self.headers objectForKey:header];
}

- (NSUInteger)selectPluralForm:(NSInteger)count {
	return count == 1 ? 0 : 1;
}

- (NSUInteger)numPlurals {
	return 2;
}

- (NSString*)translate:(NSString*)singular {
	return [self translate:singular context:nil];
}

- (NSString*)translate:(NSString*)singular context:(NSString*)context {
	NSString* key = [TranslationEntry stringKey:singular context:context], *translated = nil;
	TranslationEntry* entry = nil;
	
	if(key != nil && 
	   (entry = [self.entries objectForKey:key]) != nil && 
	   entry.translations.count) {
		translated = [entry.translations objectAtIndex:0];
	}
	
	return translated ? translated : singular;
}

- (NSString*)translatePlural:(NSString*)singular plural:(NSString*)plural count:(NSInteger)count context:(NSString*)context {
	NSString* key = [TranslationEntry stringKey:singular context:context];
	TranslationEntry* entry = nil;
	
	NSUInteger index = [self selectPluralForm:count], 
			nplurals = [self numPlurals];
	
	if(key != nil && (entry = [self.entries objectForKey:key]) != nil && 
	   index < nplurals && index < entry.translations.count)
		return [entry.translations objectAtIndex:index];
	
	return count == 1 ? singular : plural;
}

@end
