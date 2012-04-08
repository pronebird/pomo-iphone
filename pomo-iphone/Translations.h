//
//  Translations.h
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrej Mihajlov. All rights reserved.
//

#import "TranslationEntry.h"
#import "TranslationsProtocol.h"


@interface Translations : NSObject<TranslationsProtocol> {
	NSMutableDictionary* entries;
    NSMutableDictionary* headers;
}

@property (readonly, nonatomic, retain) NSMutableDictionary* entries;
@property (readonly, nonatomic, retain) NSMutableDictionary* headers;

- (id)init;
- (void)dealloc;

- (void)addEntry:(TranslationEntry*)entry;
- (void)setHeader:(NSString*)header value:(NSString*)value;
- (NSString*)header:(NSString*)header;

- (u_short)selectPluralForm:(NSInteger)count;
- (u_short)numPlurals;

- (NSString*)translate:(NSString*)singular;
- (NSString*)translate:(NSString*)singular context:(NSString*)context;
- (NSString*)translatePlural:(NSString*)singular plural:(NSString*)plural count:(NSInteger)count context:(NSString*)context;

@end
