//
//  GettextHelpers.h
//  pomo
//
//  Created by Andrei Mikhailov on 4/7/12.
//  Copyright (c) 2012 Andrei Mikhailov. All rights reserved.
//

NSString* __(NSString* singular, NSString* domain);
NSString* _c(NSString* singular, NSString* context, NSString* domain);
NSString* _nc(NSString* singular, NSString* plural, NSInteger n, NSString* context, NSString* domain);
NSString* _n(NSString* singular, NSString* plural, NSInteger n, NSString* domain);
