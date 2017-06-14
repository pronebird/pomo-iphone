//
//  TranslationsProtocol.h
//  pomo
//
//  Created by pronebird on 4/18/11.
//  Copyright 2011-2017 Andrej Mihajlov. All rights reserved.
//

#import "TranslationEntry.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TranslationsProtocol <NSObject>

- (void)addEntry:(TranslationEntry *)entry;
- (void)setHeader:(NSString *)header value:(NSString *)value;
- (NSString *)header:(NSString *)header;

- (NSUInteger)selectPluralForm:(NSInteger)count;
- (NSUInteger)numPlurals;

- (NSString *)translate:(NSString *)singular;
- (NSString *)translate:(NSString *)singular context:(nullable NSString *)context;
- (NSString *)translatePlural:(NSString *)singular plural:(NSString *)plural count:(NSInteger)count context:(nullable NSString *)context;

@end

NS_ASSUME_NONNULL_END
