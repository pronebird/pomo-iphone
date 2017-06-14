//
//  Translations.h
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011-2017 Andrej Mihajlov. All rights reserved.
//

#import "TranslationEntry.h"
#import "TranslationsProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface Translations : NSObject<TranslationsProtocol> {
    NSMutableDictionary<NSString *, TranslationEntry *> *_entries;
    NSMutableDictionary<NSString *, NSString *> *_headers;
}

@property (readonly, nonatomic, copy) NSDictionary<NSString *, TranslationEntry *> *entries;
@property (readonly, nonatomic, copy) NSDictionary<NSString *, NSString *> *headers;

@end

NS_ASSUME_NONNULL_END
