//
//  TranslationCenter.h
//  pomo
//
//  Created by pronebird on 4/18/11.
//  Copyright 2011-2017 Andrej Mihajlov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TranslationCenter : NSObject {
    NSMutableDictionary *_domains;
    NSString *_defaultPath;
    NSString *_language;
}

@property (readwrite, nonatomic, copy) NSString *defaultPath;
@property (readwrite, nonatomic, copy) NSString *language;
@property (readonly, nonatomic) NSMutableDictionary *domains;

+ (TranslationCenter*)sharedCenter;
+ (NSString *)textDomainFileWithBasePath:(NSString *)path forDomain:(NSString *)domain language:(NSString *)language type:(NSString *)ext;

- (BOOL)loadTextDomain:(NSString *)domain;
- (BOOL)loadTextDomain:(NSString *)domain path:(NSString *)path;
- (BOOL)unloadTextDomain:(NSString *)domain;

- (NSString *)translate:(NSString *)singular domain:(NSString *)domain;
- (NSString *)translate:(NSString *)singular context:(nullable NSString *)context domain:(NSString *)domain;
- (NSString *)translatePlural:(NSString *)singular plural:(NSString *)plural count:(NSInteger)count context:(nullable NSString *)context domain:(NSString *)domain;

@end

NS_ASSUME_NONNULL_END
