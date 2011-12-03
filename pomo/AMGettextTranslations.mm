//
//  Gettext_Translations.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrew Mikhailov. All rights reserved.
//

#import "AMGettextTranslations.h"
#import "RegexKitLite.h"
#include "muParserInt.h"

mu::value_type mod_operator(mu::value_type v1, mu::value_type v2) 
{
	mu::value_type mod = fmod(v1, v2);
	//std::cout << v1 << " % " << v2 << " = " << mod << std::endl;
	return mod;
}

@interface AMGettextTranslations()
@property (readwrite, assign) NSUInteger numPlurals;
@property (readwrite, retain) NSString* pluralRule;
@end

@implementation AMGettextTranslations

@synthesize numPlurals;
@synthesize pluralRule;

- (id)init
{
	self = [super init];
	
	if(self) {
		self.numPlurals = 0;
		self.pluralRule = nil;
	}
	
	return self;
}

- (void)dealloc {
	self.pluralRule = nil;
}

- (void)setHeader:(NSString*)header value:(NSString*)value
{
	[super setHeader:header value:value];
	
	if([header isEqualToString:@"Plural-Forms"]) {
		NSString *regEx = @"^\\s*nplurals\\s*=\\s*(\\d+)\\s*;\\s+plural\\s*=\\s*(.+)$";
		value = [self header:header];
		
		NSString* nplurals =  [value stringByMatching:regEx capture:1];
		NSString* rule =  [value stringByMatching:regEx capture:2];
		
		if(nplurals)
			self.numPlurals = (NSUInteger)[nplurals integerValue];
		
		if(rule)
		{
			self.pluralRule = [rule stringByReplacingOccurrencesOfString:@";" withString:@""];

			for(double x = 1; x <= 5; x++) 
			{
				mu::ParserInt parser;
				double retval;
				//(n % 10==1 && n % 100 != 11) ? 0 : ((n % 10 >= 2 && n % 10 <= 4 && (n % 100 < 10 || n % 100 >= 20)) ? 1 : 2)

				parser.EnableBuiltInOprt();
				parser.DefineOprt("%", mod_operator, 5);
				parser.DefineConst("n", x);
				parser.SetExpr([self.pluralRule UTF8String]);
				
				try
				{
					retval = parser.Eval();
					std::cout << "retval is: " << retval << std::endl;
				}
				catch (mu::ParserInt::exception_type &e)
				{
					std::cout << e.GetMsg() << std::endl;
				}
			}
		} 
		else 
		{
			self.pluralRule = nil;
		}
		
		NSLog(@"nplurals: %@. rule: %@", nplurals, rule);
	}
}

- (uint8)gettext_selectPluralForm:(NSInteger)count
{
	return [super selectPluralForm:count];
}

@end
