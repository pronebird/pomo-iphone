//
//  TranslationEntry.h
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011-2017 Andrej Mihajlov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TranslationEntry : NSObject

@property (nonatomic) BOOL is_plural;
@property (nullable, nonatomic) NSString *context;
@property (nonatomic) NSString *singular;
@property (nonatomic) NSString *plural;
@property (nonatomic) NSMutableArray<NSString *> *translations;
@property (nonatomic) NSString *translator_comments;
@property (nonatomic) NSString *extracted_comments;
@property (nonatomic) NSMutableArray<NSString *> *references;
@property (nonatomic) NSMutableArray<NSString *> *flags;

- (NSString *)key;

+ (NSString *)stringKey:(NSString *)singular;
+ (NSString *)stringKey:(NSString *)singular context:(nullable NSString *)context;

- (void)debugPrint;

@end

NS_ASSUME_NONNULL_END
