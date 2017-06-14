//
//  TranslationEntry.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011-2017 Andrej Mihajlov. All rights reserved.
//

#import "TranslationEntry.h"


@implementation TranslationEntry

- (instancetype)init {
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.singular = @"";
    self.plural = @"";
    self.translator_comments = @"";
    self.extracted_comments = @"";
    self.is_plural = NO;
    self.translations = [[NSMutableArray alloc] init];
    self.references = [[NSMutableArray alloc] init];
    self.flags = [[NSMutableArray alloc] init];
    
    return self;
}


- (NSString *)key {
    return [TranslationEntry stringKey:self.singular context:self.context];
}

+ (NSString *)stringKey:(NSString *)singular {
    return [self stringKey:singular context:nil];
}

+ (NSString *)stringKey:(NSString *)singular context:(NSString *)context {
    return (context == nil || [context isEqualToString:@""]) ? singular : [NSString stringWithFormat:@"%@%c%@", context, '\4', singular];    
}

- (void)debugPrint {
    NSLog(@"new entry\nsingular: %@\nplural: %@\nis_plural: %d\ntranslator comments:%@\n", self.singular, self.plural, self.is_plural, self.translator_comments);
    
    NSLog(@"translations:\n");
    NSUInteger i = 0;
    [self.translations enumerateObjectsUsingBlock:^(NSString *tr, NSUInteger idx, BOOL *stop) {
        NSLog(@"[%@] %@\n", @(idx + 1), tr);
    }];
    
    NSLog(@"references:\n");
    [self.references enumerateObjectsUsingBlock:^(NSString *ref, NSUInteger idx, BOOL *stop) {
        NSLog(@"[%@] %@\n", @(idx + 1), ref);
    }];
    
    NSLog(@"flags:\n");
    [self.flags enumerateObjectsUsingBlock:^(NSString *flag, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"[%@] %@\n", @(i + 1), flag);
    }];
    
    NSLog(@"--");
}

@end
