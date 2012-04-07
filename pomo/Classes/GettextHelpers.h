//
//  GettextHelpers.h
//  pomo
//
//  Created by Andrej Mihajlov on 4/7/12.
//  Copyright (c) 2012 Andrej Mihajlov. All rights reserved.
//

#define DEFAULT_TEXTDOMAIN @"default"

NSString* __(NSString* singular, NSString* domain);
NSString* _x(NSString* singular, NSString* context, NSString* domain);
NSString* _nx(NSString* singular, NSString* plural, NSInteger n, NSString* context, NSString* domain);
NSString* _n(NSString* singular, NSString* plural, NSInteger n, NSString* domain);

// @TODO: find a way for noops
//#define _n_noop(a, b) ()
//#define _nx_noop(a, b) ()
