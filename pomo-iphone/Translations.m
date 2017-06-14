//
//  Translations.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011-2017 Andrej Mihajlov. All rights reserved.
//

#import "Translations.h"

@implementation Translations

- (instancetype)init {
    self = [super init];
    if(!self) {
        return nil;
    }
    
    _entries = [[NSMutableDictionary alloc] init];
    _headers = [[NSMutableDictionary alloc] init];
    
	return self;
}

- (NSDictionary *)entries {
    return [_entries copy];
}

- (NSDictionary *)headers {
    return [_headers copy];
}

- (void)addEntry:(TranslationEntry *)entry {
    _entries[entry.key] = entry;
}

- (void)setHeader:(NSString *)header value:(NSString*)value {
    _headers[header] = value;
}

- (NSString*)header:(NSString*)header {
    return _headers[header];
}

- (NSUInteger)selectPluralForm:(NSInteger)count {
	return count == 1 ? 0 : 1;
}

- (NSUInteger)numPlurals {
	return 2;
}

- (NSString *)translate:(NSString *)singular {
	return [self translate:singular context:nil];
}

- (NSString *)translate:(NSString *)singular context:(NSString *)context {
	NSString *key = [TranslationEntry stringKey:singular context:context];
    TranslationEntry* entry = _entries[key];
    
    return entry.translations.firstObject ?: singular;
}

- (NSString *)translatePlural:(NSString *)singular plural:(NSString *)plural count:(NSInteger)count context:(NSString *)context {
	NSString *key = [TranslationEntry stringKey:singular context:context];
    NSUInteger index = [self selectPluralForm:count];
    NSUInteger nplurals = [self numPlurals];
    TranslationEntry *entry = _entries[key];
    
    if(index < nplurals && index < entry.translations.count) {
        return entry.translations[index];
    }
    
	return count == 1 ? singular : plural;
}

@end
