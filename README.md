# POMO-iphone

POMO-iphone is a gettext reader for iPhone written in Obj-C/C++. It supposed to be a good substitution for outdated Apple translation system. However I still use default mechanisms to translate settings.bundle and views, so this solution is not 100% perfect.

## Basic usage

See [GettextHelpers.h](https://github.com/pronebird/pomo-iphone/blob/master/pomo-iphone/GettextHelpers.h) and [TranslationCenter.h](https://github.com/pronebird/pomo-iphone/blob/master/pomo-iphone/TranslationCenter.h)

    // we import TranslationCenter only to load textdomain,
    // so you'll need it probably once
    #import "TranslationCenter.h"

    // include shorthandle functions
    #import "GettextHelpers.h"

    ...

    TranslationCenter* translator = [TranslationCenter sharedCenter];

    // here we load default textdomain, TEXTDOMAIN constant defined in GettextHelpers.h
    [translator loadTextDomain:TEXTDOMAIN];

    int num_apples = 10;

    NSLog(@"Gettext translated string: %@", ___(@"Hi, this is gettext!", TEXTDOMAIN));
    NSLog(@"Gettext translated plural: %@", __n(@"%d apple", @"%d apples", num_apples, TEXTDOMAIN));

    // translate and format altogether
    NSLog(@"Gettext translated plural: %@",
        [NSString stringWithFormat:__n(@"%d apple", @"%d apples", num_apples, TEXTDOMAIN), num_apples]);

## TranslationCenter

TranslationCenter used to load textdomains and translate strings, it has few options that you can override, to obtain shared center use following code:

    TranslationCenter* translator = [TranslationCenter sharedCenter];

`translator.defaultPath` - by default it's path to your app bundle
`translator.language` - by default it's current UI language

You can use TranslationCenter directly to translate strings, however it's not really pleasant, so I suggest to use GettextHelpers which provide bunch of shorthandle functions.

## Single textdomain shorthandles

Single textdomain shorthandles use default textdomain and help you to keep your code shorter if you don't need more than one textdomain in your app.

`__(singular)` - single string translation

`_n(singular, plural, number)` - plural translation

`_x(singular, context)` - single string translation with context

`_nx(singular, plural, number, context)` - plural translation with context

## Other shorthandles with custom textdomain

Using following functions you must explicitly specify textdomain, useful if you have many textdomains in your app:

`___(singular, textdomain)` - single string translation

`__n(singular, plural, number, textdomain)` - plural translation

`__x(singular, context, textdomain)` - single string translation with context

`__nx(singular, plural, number, context, textdomain)` - plural translation with context

## Textdomain lookup algorithm

TranslationCenter looks for .mo or .po files with the following pattern:

`%{app-bundle-path}/%{textdomain}-%{language}.%{format}.`

where %{language} is two letter code (e.g. ru, en, es, etc..)
%{format} is "mo" or "po". Mo files have bigger priority since it's more compact format and supposed to be used for distribution.
%{textdomain} - default or your own textdomain that you specify in your source code

Example path may look like that:

`/MyApp.app/default-es.mo`

## Compilation notes

- It's necessary to use additional linker flag for your project otherwise you'll catch crash on first invocation, for some reason RegexKitLite NSString category doesn't exist after compilation. Add this to other linker flags of your app:

`-ObjC`

More info here: https://developer.apple.com/library/mac/#qa/qa2006/qa1490.html

- Your app must be linked against libicucore.dlyb because RegexKitLite uses this library internally.

- Link your app against libstdc++.dylib, there are bits of C++ inside.

- Pomo-iphone depends on muparser-iphone. So at the end you'll have a workspace with muparser-iphone and pomo-iphone compiled in the same order.

## Poedit Settings

If you use Poedit, follow the instructions below to setup Objective-C parser.

Go to Poedit > Preferences and add new parser with the following settings:

- List of extensions:
`*.m;*.mm;*.c;*.h;`

- Parser command:
`xgettext --force-po -o %o %C %K %F -L ObjectiveC`

- An item in keywords list:
`-k%k`

- An item in input files:
`%f`

- Source code charset:
`--from-code=%c`

## Poedit Catalog Settings

Setup the following keywords for your catalog to make Poedit work with your source code:

    __
    _nx:4c,1,2
    _x:2c,1
    _n:1,2
    _n_noop:1,2
    _nx_noop:4c,1,2
    ___
    __nx:4c,1,2
    __x:2c,1
    __n:1,2

