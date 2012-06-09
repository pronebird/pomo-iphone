//
//  GettextHelpers.m
//  pomo
//
//  Created by Andrej Mihajlov on 4/7/12.
//  Copyright (c) 2012 Andrej Mihajlov. All rights reserved.
//

#import "GettextHelpers.h"
#import "TranslationCenter.h"

NSString* __(NSString* singular) {
	return ___(singular, DEFAULT_TEXTDOMAIN);
}

NSString* _x(NSString* singular, NSString* context) {
	return __x(singular, context, DEFAULT_TEXTDOMAIN);
}

NSString* _nx(NSString* singular, NSString* plural, NSInteger n, NSString* context) {
	return __nx(singular, plural, n, context, DEFAULT_TEXTDOMAIN);
}

NSString* _n(NSString* singular, NSString* plural, NSInteger n) {
	return __n(singular, plural, n, DEFAULT_TEXTDOMAIN);
}

NSString* ___(NSString* singular, NSString* domain) 
{
	return [[TranslationCenter sharedCenter] translate:singular 
												domain:domain];
}

NSString* __x(NSString* singular, NSString* context, NSString* domain) 
{
	return [[TranslationCenter sharedCenter] translate:singular 
											   context:context 
												domain:domain];
}

NSString* __nx(NSString* singular, NSString* plural, NSInteger n, NSString* context, NSString* domain) 
{
	return [[TranslationCenter sharedCenter] translatePlural:singular 
													  plural:plural 
													   count:n 
													 context:context 
													  domain:domain];
}

NSString* __n(NSString* singular, NSString* plural, NSInteger n, NSString* domain) {
	return __nx(singular, plural, n, nil, domain);
}
