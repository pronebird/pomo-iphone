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

`%{app-bundle-path}/%{textdomain}-%{language}.%{format}`

where %{language} is two letter code (e.g. ru, en, es, etc..)
%{format} is "mo" or "po". Mo files have higher priority since it's more compact format and supposed to be used for distribution.
%{textdomain} - default or your own textdomain that you specify in your source code

Example path may look like that:

`/MyApp.app/default-es.mo`

## Build notes

- Link your app against libstdc++.dylib, there are bits of C++ inside.

- Pomo-iphone depends on muparser-iphone. So at the end you'll have a workspace with muparser-iphone and pomo-iphone compiled in the same order as mentioned.

- Link your app against libpomo-iphone

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

Also you can use --add-comments=/ flag in Parser commands to enable translators' comments. In this example all comments starting with triple slash will be treated as translators' comments.

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


## License (MIT)

Copyright (c) 2012 Andrej Mihajlov

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.