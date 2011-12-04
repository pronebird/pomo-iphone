//
//  TranslationCenter.h
//  pomo
//
//  Created by pronebird on 4/18/11.
//  Copyright 2011 Andrei Mikhailov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TranslationCenter : NSObject {
    NSMutableDictionary* domains;
	NSString* defaultPath;
	NSString* locale;
}

@property (readwrite, nonatomic, retain) NSString* defaultPath;
@property (readwrite, nonatomic, retain) NSString* locale;
@property (readonly, nonatomic, retain) NSMutableDictionary* domains;

+ (id)sharedCenter;
+ (NSString*)stringFullPath:(NSString*)path forDomain:(NSString*)domain locale:(NSString*)locale;

- (id)init;
- (void)dealloc;

- (BOOL)loadTextDomain:(NSString*)domain;
- (BOOL)loadTextDomain:(NSString*)domain path:(NSString*)path;
- (BOOL)unloadTextDomain:(NSString*)domain;

@end
