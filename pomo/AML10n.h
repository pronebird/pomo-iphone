//
//  AML10n.h
//  pomo
//
//  Created by pronebird on 4/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef AML10N_NOMACRO

//define __(a) [[AML10n singleton] translate]

#endif

@interface AML10n : NSObject {
    NSMutableDictionary* domains;
	NSString* defaultPath;
	NSString* locale;
}

@property (readwrite, nonatomic, retain) NSString* defaultPath;
@property (readwrite, nonatomic, retain) NSString* locale;
@property (readonly, nonatomic, retain) NSMutableDictionary* domains;

+ (id)singleton;
+ (NSString*)stringFullPath:(NSString*)path forDomain:(NSString*)domain locale:(NSString*)locale;

- (id)init;
- (void)dealloc;

- (bool)loadTextDomain:(NSString*)domain;
- (bool)loadTextDomain:(NSString*)domain path:(NSString*)path;

- (bool)unloadTextDomain:(NSString*)domain;

@end
