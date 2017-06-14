//
//  POParser.h
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011-2017 Andrej Mihajlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GettextTranslations.h"
#import "ParserProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface POParser : GettextTranslations<ParserProtocol>

- (BOOL)importFileAtPath:(NSString *)filename;

@end

NS_ASSUME_NONNULL_END
