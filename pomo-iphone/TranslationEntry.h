//
//  TranslationEntry.h
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrej Mihajlov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TranslationEntry : NSObject

@property (assign) BOOL is_plural;
@property (strong, nonatomic) NSString* context;
@property (strong, nonatomic) NSString* singular;
@property (strong, nonatomic) NSString* plural;
@property (strong, nonatomic) NSMutableArray* translations;
@property (strong, nonatomic) NSString* translator_comments;
@property (strong, nonatomic) NSString* extracted_comments;
@property (strong, nonatomic) NSMutableArray* references;
@property (strong, nonatomic) NSMutableArray* flags;

- (NSString*)key;

+ (NSString*)stringKey:(NSString*)singular;
+ (NSString*)stringKey:(NSString*)singular context:(NSString*)context;

- (void)debugPrint;

@end

NS_ASSUME_NONNULL_END