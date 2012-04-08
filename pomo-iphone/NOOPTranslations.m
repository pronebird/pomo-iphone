//
//  NOOPTranslations.m
//  pomo
//
//  Created by pronebird on 4/18/11.
//  Copyright 2011 Andrej Mihajlov. All rights reserved.
//

#import "NOOPTranslations.h"


@implementation NOOPTranslations

- (NSString*)translate:(NSString*)singular context:(NSString*)context
{
	return singular;
}

- (NSString*)translatePlural:(NSString*)singular plural:(NSString*)plural count:(NSInteger)count context:(NSString*)context
{	
	return count == 1 ? singular : plural;
}

@end
