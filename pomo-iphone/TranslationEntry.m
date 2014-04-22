//
//  TranslationEntry.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrej Mihajlov. All rights reserved.
//

#import "TranslationEntry.h"


@implementation TranslationEntry

- (id)init {
	if(self = [super init]) {
		self.is_plural = NO;
		self.context = nil;
		self.singular = nil;
		self.plural = nil;
		self.translations = [NSMutableArray new];
		self.translator_comments = nil;
		self.extracted_comments = nil;
		self.references = [NSMutableArray new];
		self.flags = [NSMutableArray new];
	}
	return self;
}


- (NSString*)key {
	return [TranslationEntry stringKey:self.singular context:self.context];
}

+ (NSString*)stringKey:(NSString*)singular {
	return [self stringKey:singular context:nil];
}

+ (NSString*)stringKey:(NSString*)singular context:(NSString*)context {
	if(singular == nil)
		return nil;
	
	return (context == nil || [context isEqualToString:@""]) ? singular : [NSString stringWithFormat:@"%@%c%@", context, '\4', singular];	
}

- (void)debugPrint {
	NSLog(@"new entry\nsingular: %@\nplural: %@\nis_plural: %d\ntranslator comments:%@\n", self.singular, self.plural, self.is_plural, self.translator_comments);
	
	NSLog(@"translations:\n");
	NSUInteger i = 0;
	for(NSString* tr in self.translations) {
		NSLog(@"[%lu] %@\n", (unsigned long)i++, tr);
	}
	
	NSLog(@"references:\n");
	i = 0;
	for(NSString* ref in self.references) {
		NSLog(@"[%lu] %@\n", (unsigned long)i++, ref);
	}
	
	NSLog(@"flags:\n");
	i = 0;
	for(NSString* flag in self.flags) {
		NSLog(@"[%lu] %@\n", (unsigned long)i++, flag);
	}
	
	NSLog(@"--");
}

@end
