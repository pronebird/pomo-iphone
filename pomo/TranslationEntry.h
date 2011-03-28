//
//  TranslationEntry.h
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TranslationEntry : NSObject {
	
    bool is_plural;
	
	NSString* context;
	NSString* singular;
	NSString* plural;
	NSMutableArray* translations;
	NSString* translator_comments;
	NSString* extracted_comments;
	NSMutableArray* references;
	NSMutableArray* flags;
}

@property (assign) bool is_plural;
@property (retain, nonatomic) NSString* context;
@property (retain, nonatomic) NSString* singular;
@property (retain, nonatomic) NSString* plural;
@property (retain, nonatomic) NSMutableArray* translations;
@property (retain, nonatomic) NSString* translator_comments;
@property (retain, nonatomic) NSString* extracted_comments;
@property (retain, nonatomic) NSMutableArray* references;
@property (retain, nonatomic) NSMutableArray* flags;

- (id) init;
- (void) dealloc;

@end
