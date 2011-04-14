//
//  NSStringExt.h
//  pomo
//
//  Created by pronebird on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (NSStringExt)

- (NSArray*) componentsSeparatedByString:(NSString *)separator limit: (NSUInteger)limit;
- (NSArray*) split : (NSString*)separator;

@end
