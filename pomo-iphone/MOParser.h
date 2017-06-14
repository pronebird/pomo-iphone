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

- (BOOL)importFileAtPath:(NSString *)filename;

@end

NS_ASSUME_NONNULL_END
