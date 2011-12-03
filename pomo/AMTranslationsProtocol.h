//
//  AMTranslationsProtocol.h
//  pomo
//
//  Created by pronebird on 4/18/11.
//  Copyright 2011 Andrew Mikhailov. All rights reserved.
//

#import "AMTranslationEntry.h"

@protocol AMTranslationsProtocol <NSObject>

- (void)addEntry:(AMTranslationEntry*)entry;
- (void)setHeader:(NSString*)header value:(NSString*)value;
- (NSString*)header:(NSString*)header;

- (uint8)selectPluralForm:(NSInteger)count;
- (uint8)getPluralFormsCount;

- (NSString*)translate:(NSString*)singular;
- (NSString*)translate:(NSString*)singular context:(NSString*)context;
- (NSString*)translatePlural:(NSString*)singular plural:(NSString*)plural count:(NSInteger)count context:(NSString*)context;

@end
