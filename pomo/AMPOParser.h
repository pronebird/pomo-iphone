//
//  PO.h
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrew Mikhailov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMGettextTranslations.h"

#define PO_MAX_LINE_LEN 79


@interface AMPOParser : AMGettextTranslations {
    
}

- (id) init;
- (void) dealloc;

- (bool) importFileAtPath : (NSString*)filename;

@end

@interface AMPOParser (ProtectedMethods)

- (NSString*) readLine : (FILE*)file encoding: (NSStringEncoding)encoding;
- (AMTranslationEntry*) readEntry : (FILE*)file;
- (NSString*) decodeValueAndRemoveQuotes : (NSString*)string;

- (NSString*) decodePOString : (NSString*)string;
- (NSString*) encodePOString : (NSString*)string;

- (NSArray*) splitString : (NSString*) string separator:(NSString*)separator;
@end
