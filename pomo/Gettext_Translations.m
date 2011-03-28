//
//  Gettext_Translations.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Gettext_Translations.h"


@implementation Gettext_Translations

- (void) setHeader : (NSString*)header value: (NSString*)value
{
	[super setHeader:header value:value];
}

- (uint8) gettext_selectPluralForm : (NSInteger)count
{
	return [super selectPluralForm:count];
}

@end
