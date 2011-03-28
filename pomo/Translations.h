//
//  Translations.h
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TranslationEntry.h"


@interface Translations : NSObject {
	NSMutableDictionary* entries;
    NSMutableDictionary* headers;
}

- (id) init;
- (void) dealloc;

- (void) addEntry : (TranslationEntry*)entry;
- (void) setHeader : (NSString*)header value: (NSString*)value;
- (NSString*) getHeader : (NSString*)header;
- (uint8) selectPluralForm : (NSInteger) count;
- (uint8) getPluralFormsCount;
- (NSString*) translate : (NSString*)singular context: (NSString*)context;
- (NSString*) translatePlural : (NSString*)singular plural: (NSString*)plural count: (NSInteger)count context: (NSString*)context;

@end
