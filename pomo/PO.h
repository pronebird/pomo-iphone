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

- (bool) importFileAtPath : (NSString*)filename;

@end

@interface PO (ProtectedMethods)

- (NSString*) readLine : (FILE*)file encoding: (NSStringEncoding)encoding;
- (TranslationEntry*) readEntry : (FILE*)file;
- (NSString*) decodeValueAndRemoveQuotes : (NSString*)string;

- (NSString*) decodePOString : (NSString*)string;
- (NSString*) encodePOString : (NSString*)string;

@end
