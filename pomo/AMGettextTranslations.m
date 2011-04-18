//
//  Gettext_Translations.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrew Mikhailov. All rights reserved.
//

#import "AMGettextTranslations.h"


@implementation AMGettextTranslations

- (void) setHeader : (NSString*)header value: (NSString*)value
{
	[super setHeader:header value:value];
	
	if([header isEqualToString:@"Plural-Forms"]) {
		
	}
}

- (uint8) gettext_selectPluralForm : (NSInteger)count
{
	return [super selectPluralForm:count];
}

@end
