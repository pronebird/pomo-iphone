//
//  Translations.h
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrew Mikhailov. All rights reserved.
//

#import "AMTranslationEntry.h"
#import "AMTranslationsProtocol.h"


@interface AMTranslations : NSObject<AMTranslationsProtocol> {
	NSMutableDictionary* entries;
    NSMutableDictionary* headers;
}

@property (readonly, nonatomic, retain) NSMutableDictionary* entries;
@property (readonly, nonatomic, retain) NSMutableDictionary* headers;

- (id) init;
- (void) dealloc;

- (void) addEntry : (AMTranslationEntry*)entry;
- (void) setHeader : (NSString*)header value: (NSString*)value;
- (NSString*) header : (NSString*)header;

- (uint8) selectPluralForm : (NSInteger) count;
- (uint8) getPluralFormsCount;

- (NSString*) translate : (NSString*)singular;
- (NSString*) translate : (NSString*)singular context: (NSString*)context;
- (NSString*) translatePlural : (NSString*)singular plural: (NSString*)plural count: (NSInteger)count context: (NSString*)context;

@end
