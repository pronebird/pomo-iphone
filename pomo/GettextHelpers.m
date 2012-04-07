//
//  GettextHelpers.m
//  pomo
//
//  Created by Andrei Mikhailov on 4/7/12.
//  Copyright (c) 2012 Andrei Mikhailov. All rights reserved.
//

#import "GettextHelpers.h"
#import "TranslationCenter.h"

NSString* __(NSString* singular, NSString* domain) {
	return [[TranslationCenter sharedCenter] translate:singular domain:domain];
}

NSString* _c(NSString* singular, NSString* context, NSString* domain) {
	return [[TranslationCenter sharedCenter] translate:singular context:context domain:domain];
}

NSString* _nc(NSString* singular, NSString* plural, NSInteger n, NSString* context, NSString* domain) {
	return [[TranslationCenter sharedCenter] translatePlural:singular plural:plural count:n context:context domain:domain];
}

NSString* _n(NSString* singular, NSString* plural, NSInteger n, NSString* domain) {
	return _nc(singular, plural, n, nil, domain);
}
