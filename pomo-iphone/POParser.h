//
//  POParser.h
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrej Mihajlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GettextTranslations.h"
#import "ParserProtocol.h"

@interface POParser : GettextTranslations<ParserProtocol>

- (id)init;
- (void)dealloc;
- (BOOL)importFileAtPath:(NSString*)filename;

@end

@interface POParser(ProtectedMethods)

- (TranslationEntry*)readEntry:(NSString*)entryString;
- (NSString*)decodeValueAndRemoveQuotes:(NSString*)string;

- (NSString*)decodePOString:(NSString*)string;
- (NSString*)encodePOString:(NSString*)string;

- (NSArray*)splitString:(NSString*)string 
			  separator:(NSString*)separator;
@end
