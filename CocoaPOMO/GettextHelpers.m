//
//  GettextHelpers.m
//  pomo
//
//  Created by Andrej Mihajlov on 4/7/12.
//  Copyright (c) 2012 Andrej Mihajlov. All rights reserved.
//

#import "GettextHelpers.h"
#import "TranslationCenter.h"

NSString* __(NSString* singular, NSString* domain) {
	return [[TranslationCenter sharedCenter] translate:singular domain:domain];
}

NSString* _x(NSString* singular, NSString* context, NSString* domain) {
	return [[TranslationCenter sharedCenter] translate:singular context:context domain:domain];
}

NSString* _nx(NSString* singular, NSString* plural, NSInteger n, NSString* context, NSString* domain) {
	return [[TranslationCenter sharedCenter] translatePlural:singular plural:plural count:n context:context domain:domain];
}

NSString* _n(NSString* singular, NSString* plural, NSInteger n, NSString* domain) {
	return _nx(singular, plural, n, nil, domain);
}
