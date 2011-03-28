//
//  PO.h
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gettext_Translations.h"

#define PO_MAX_LINE_LEN 79


@interface PO : Gettext_Translations {
    
}

- (id) init;
- (void) dealloc;

- (bool) import : (NSString*)filename;

@end

@interface PO (ProtectedMethods)

- (TranslationEntry*) readEntry: (NSFileHandle*)file;

@end
