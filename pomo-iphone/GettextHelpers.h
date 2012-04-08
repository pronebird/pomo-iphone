//
//  GettextHelpers.h
//  pomo
//
//  Created by Andrej Mihajlov on 4/7/12.
//  Copyright (c) 2012 Andrej Mihajlov. All rights reserved.
//

#define DEFAULT_TEXTDOMAIN @"default"

// Shorthandles that use DEFAULT_TEXTDOMAIN
inline NSString* __(NSString* singular);
inline NSString* _x(NSString* singular, NSString* context);
inline NSString* _nx(NSString* singular, NSString* plural, NSInteger n, NSString* context);
inline NSString* _n(NSString* singular, NSString* plural, NSInteger n);

inline NSString* ___(NSString* singular, NSString* domain);
inline NSString* __x(NSString* singular, NSString* context, NSString* domain);
inline NSString* __nx(NSString* singular, NSString* plural, NSInteger n, NSString* context, NSString* domain);
inline NSString* __n(NSString* singular, NSString* plural, NSInteger n, NSString* domain);

// @TODO: find a way for noops
//#define _n_noop(a, b) ()
//#define _nx_noop(a, b) ()
