//
//  Gettext_Translations.h
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Translations.h"


@interface Gettext_Translations : Translations
{
    
}

- (void) setHeader : (NSString*)header value: (NSString*)value;
- (uint8) gettext_selectPluralForm : (NSInteger)count;

@end
