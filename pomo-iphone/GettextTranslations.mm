//
//  GettextTranslations.mm
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 Andrej Mihajlov. All rights reserved.
//

#import "GettextTranslations.h"
#import "RegexKitLite.h"

using namespace mu;

@interface GettextTranslations()
@property (readwrite, assign) NSUInteger numPlurals;
@property (readwrite, retain) NSString* pluralRule;
@end

@implementation GettextTranslations

@synthesize numPlurals;
@synthesize pluralRule;

- (id)init
{
	self = [super init];
	
	if(self) {
		self.numPlurals = 0;
		self.pluralRule = nil;
		
		mParser = new ParserInt();
		mParser->EnableBuiltInOprt();
		mParser->DefineOprt("%", fmod, 5);
	}
	
	return self;
}

- (void)dealloc {
	self.pluralRule = nil;
	
	delete mParser;
	mParser = NULL;
	
	[super dealloc];
}

- (void)setHeader:(NSString*)header value:(NSString*)value
{
	[super setHeader:header value:value];
	
	if([header isEqualToString:@"Plural-Forms"])
	{
		NSString *regEx = @"^\\s*nplurals\\s*=\\s*(\\d+)\\s*;\\s+plural\\s*=\\s*(.+)$",
				*nplurals = nil, *rule = nil;
		
		value = [self header:header];
		nplurals =  [value stringByMatching:regEx capture:1];
		rule =  [value stringByMatching:regEx capture:2];

		if(nplurals)
			self.numPlurals = (NSUInteger)[nplurals integerValue];
		else
			self.numPlurals = 0;
		
		if(rule)
		{
			self.pluralRule = [rule stringByReplacingOccurrencesOfString:@";" withString:@""];

			mParser->SetExpr([self.pluralRule UTF8String]);
		}
		else
			self.pluralRule = nil;

		NSLog(@"nplurals: %@. rule: %@", nplurals, rule);
	}
}

- (NSUInteger)selectPluralForm:(NSInteger)count
{
	double retval;
	
	if(self.pluralRule)
	{
		mParser->DefineConst("n", count);
		
		try
		{
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
