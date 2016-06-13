//
//  GettextHelpers.h
//  pomo
//
//  Created by Andrej Mihajlov on 4/7/12.
//  Copyright (c) 2012 Andrej Mihajlov. All rights reserved.
//

#import "TranslationCenter.h"

NS_ASSUME_NONNULL_BEGIN

#define DEFAULT_TEXTDOMAIN @"default"
#define OVERLOADABLE_FUNC __attribute__((overloadable))

#if !__has_extension(attribute_overloadable)
#error GettextHelpers require overloadable extension
#endif

/**
 *  Translate a string using provided text domain
 *
 *  @param singular an original string
 *  @param domain   a text domain
 *
 *  @return a translated string on success, otherwise original string
 */
NS_INLINE NSString *_(NSString *singular, NSString *domain) OVERLOADABLE_FUNC NS_SWIFT_UNAVAILABLE("Use __(singular, domain) instead.") {
	return [[TranslationCenter sharedCenter] translate:singular domain:domain];
};

/**
 *  Translate a string using provided text domain
 *  This is a swift-friendly version of _(singular, domain)
 *
 *  @param singular an original string
 *  @param domain   a text domain
 *
 *  @return a translated string on success, otherwise original string
 */
NS_INLINE NSString *__(NSString *singular, NSString *domain) OVERLOADABLE_FUNC {
    return _(singular, domain);
};

/**
 *  Translate a string from default text domain
 *
 *  @param singular an original string
 *
 *  @return a translated string on success, otherwise original string
 */
NS_INLINE NSString *_(NSString *singular) OVERLOADABLE_FUNC NS_SWIFT_UNAVAILABLE("Use __(singular) instead.") {
	return _(singular, DEFAULT_TEXTDOMAIN);
};

/**
 *  Translate a string from default text domain.
 *  This is a swift-friendly version of _(singular)
 *
 *  @param singular an original string
 *
 *  @return a translated string on success, otherwise original string
 */
NS_INLINE NSString *__(NSString *singular) OVERLOADABLE_FUNC {
    return _(singular, DEFAULT_TEXTDOMAIN);
};

/**
 *  Translate a string using provided text domain and context
 *
 *  @param singular an original string
 *  @param context  a context
 *  @param domain   a text domain
 *
 *  @return a translated string on success, otherwise original string
 */
NS_INLINE NSString *_x(NSString *singular, NSString *context, NSString *domain) OVERLOADABLE_FUNC {
	return [[TranslationCenter sharedCenter] translate:singular context:context domain:domain];
};

/**
 *  Translate a string using context and default text domain
 *
 *  @param singular an original string
 *  @param context  a context
 *
 *  @return a translated string on success, otherwise original string
 */
NS_INLINE NSString *_x(NSString *singular, NSString *context) OVERLOADABLE_FUNC {
	return _x(singular, context, DEFAULT_TEXTDOMAIN);
};

/**
 *  Translate a string respecting provided number, using context and text domain
 *
 *  @param singular a singular string
 *  @param plural   a plural string
 *  @param n        a number used to lookup a translation with correct inflection
 *  @param context  a context
 *  @param domain   a text domain
 *
 *  @return a translated string on success, otherwise original string
 */
NS_INLINE NSString *_nx(NSString *singular, NSString *plural, NSInteger n, NSString *context, NSString *domain) OVERLOADABLE_FUNC {
	return [[TranslationCenter sharedCenter] translatePlural:singular plural:plural count:n context:context domain:domain];
};

/**
 *  Translate a string respecting provided number, using context and default text domain
 *  @param singular a singular string
 *  @param plural   a plural string
 *  @param n        a number used to lookup a translation with correct inflection
 *  @param context  a context
 *
 *  @return a translated string on success, otherwise original string
 */
NS_INLINE NSString *_nx(NSString *singular, NSString *plural, NSInteger n, NSString *context) OVERLOADABLE_FUNC {
	return _nx(singular, plural, n, context, DEFAULT_TEXTDOMAIN);
};

/**
 *  Translate a string respecting provided number, using default text domain
 *
 *  @param singular a singular string
 *  @param plural   a plural string
 *  @param n        a number used to lookup a translation with correct inflection
 *  @param domain   a text domain
 *
 *  @return a translated string on success, otherwise original string
 */
NS_INLINE NSString *_n(NSString *singular, NSString *plural, NSInteger n, NSString *domain) OVERLOADABLE_FUNC {
	return [[TranslationCenter sharedCenter] translatePlural:singular plural:plural count:n context:nil domain:domain];
};

/**
 *  Translate a string respecting provided number, using default text domain
 *
 *  @param singular a singular string
 *  @param plural   a plural string
 *  @param n        a number used to lookup a translation with correct inflection
 *
 *  @return a translated string on success, otherwise original string
 */
NS_INLINE NSString *_n(NSString *singular, NSString *plural, NSInteger n) OVERLOADABLE_FUNC {
	return _n(singular, plural, n, DEFAULT_TEXTDOMAIN);
};


#define _n_noop(singular, plural, domain)
#define _nx_noop(singular, plural, context, domain)

NS_ASSUME_NONNULL_END