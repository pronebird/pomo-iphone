//
//  Gettext_Translations.h
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrew Mikhailov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMTranslations.h"

#ifdef __cplusplus
#define OPAQUE_MU_PARSER mu::ParserInt
#else
#define OPAQUE_MU_PARSER struct cpp_mu_ParserInt
#endif

#ifdef __cplusplus
#include "muParserInt.h"
#endif

@interface AMGettextTranslations : AMTranslations {
    NSUInteger numPlurals;
	NSString* pluralRule;
	
@private
	OPAQUE_MU_PARSER * mParser;
}

@property (readonly, assign) NSUInteger numPlurals;
@property (readonly, retain) NSString* pluralRule;

- (id)init;
- (void)dealloc;

- (void)setHeader:(NSString*)header value:(NSString*)value;
- (uint8)selectPluralForm:(NSInteger)count;

@end
