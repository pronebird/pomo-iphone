//
//  GettextTranslations.h
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrej Mihajlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Translations.h"

@interface GettextTranslations : Translations

@property (readonly, assign) NSUInteger numPlurals;
@property (readonly, strong) NSString* pluralRule;

@end
