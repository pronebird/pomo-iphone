//
//  GettextTranslations.mm
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrej Mihajlov. All rights reserved.
//

#import "GettextTranslations.h"
#import "muParserInt.h"

@interface GettextTranslations()

@property (readwrite, assign) NSUInteger numPlurals;
@property (readwrite, strong) NSString* pluralRule;

@end

@implementation GettextTranslations {
	mu::ParserInt * mParser;
}

- (id)init {
	if(self = [super init]) {
		self.numPlurals = 0;
		self.pluralRule = nil;
		
		mParser = new mu::ParserInt();
		mParser->EnableBuiltInOprt();
		mParser->DefineOprt("%", fmod, 5);
	}
	return self;
}

- (void)dealloc {
	delete mParser;
	mParser = NULL;
}

- (NSDictionary*)_scanPluralFormsString:(NSString*)src {
	NSMutableDictionary* result = [NSMutableDictionary new];
	NSArray* strings = [src componentsSeparatedByString:@";"];
	NSCharacterSet* charset = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	
	for(NSString* str in strings)  {
		NSScanner* scanner = [NSScanner scannerWithString:str];
		NSString* key = nil;
		
		if([scanner scanUpToString:@"=" intoString:&key]) {
			[result setObject:[[str substringFromIndex:scanner.scanLocation+1] stringByTrimmingCharactersInSet:charset] 
					   forKey:[key stringByTrimmingCharactersInSet:charset]];
		}
	}
	
	return result;
}

- (void)setHeader:(NSString*)header value:(NSString*)value {
	[super setHeader:header value:value];
	
	if([header isEqualToString:@"Plural-Forms"]) {
		NSDictionary* dict = [self _scanPluralFormsString:[self header:header]];		
		NSString* nplurals = [dict objectForKey:@"nplurals"];
		NSString* rule = [dict objectForKey:@"plural"];
		
		if(nplurals)
			self.numPlurals = (NSUInteger)[nplurals integerValue];
		else
			self.numPlurals = 0;
		
		if(rule) {
			self.pluralRule = [rule stringByReplacingOccurrencesOfString:@";" withString:@""];
			
			mParser->SetExpr([self.pluralRule UTF8String]);
		} else {
			self.pluralRule = nil;
		}
		
		NSLog(@"nplurals: %@. rule: %@", nplurals, rule);
	}
}

- (NSUInteger)selectPluralForm:(NSInteger)count {
	double retval;
	
	if(self.pluralRule) {
		mParser->DefineConst("n", count);
		
		try {
			retval = mParser->Eval();
			//std::cout << "retval for " << count << " is " << retval << std::endl;
			
			return (NSUInteger)retval;
		}
		catch (mu::ParserInt::exception_type &e)
		{
			std::cout << "Gettext parser error: " << e.GetMsg() << std::endl;
		}
	}
	
	return [super selectPluralForm:count];
}

@end
