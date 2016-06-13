//
//  MOParser.h
//  pomo
//
//  Created by pronebird on 12/4/11.
//  Copyright (c) 2011 Andrej Mihajlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GettextTranslations.h"
#import "ParserProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MOParser : GettextTranslations<ParserProtocol>

- (BOOL)importFileAtPath:(NSString*)filename;

@end


@interface MOParser(ProtectedMethods)

- (NSArray*)splitString:(NSString*)string separator:(NSString*)separator;

@end

NS_ASSUME_NONNULL_END