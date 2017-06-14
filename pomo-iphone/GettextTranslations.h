//
//  GettextTranslations.h
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011-2017 Andrej Mihajlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Translations.h"

NS_ASSUME_NONNULL_BEGIN

@interface GettextTranslations : Translations

@property (readonly, assign) NSUInteger numPlurals;
@property (nullable, readonly) NSString *pluralRule;

@end

NS_ASSUME_NONNULL_END
