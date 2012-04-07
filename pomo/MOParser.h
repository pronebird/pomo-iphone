//
//  MOParser.h
//  pomo
//
//  Created by pronebird on 12/4/11.
//  Copyright (c) 2011 Andrei Mikhailov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GettextTranslations.h"
#import "ParserProtocol.h"

@interface MOParser : GettextTranslations<ParserProtocol> {
	
}

- (id)init;
- (void)dealloc;

- (BOOL)importFileAtPath:(NSString*)filename;

@end
