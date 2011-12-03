//
//  Gettext_Translations.h
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrew Mikhailov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMTranslations.h"


@interface AMGettextTranslations : AMTranslations {
    NSUInteger numPlurals;
	NSString* pluralRule;
}

@property (readonly, assign) NSUInteger numPlurals;
@property (readonly, retain) NSString* pluralRule;

- (id)init;
- (void)dealloc;

- (void)setHeader:(NSString*)header value:(NSString*)value;
- (uint8)gettext_selectPluralForm:(NSInteger)count;

@end
