== POMO-iphone ==

POMO-iphone is a gettext reader for iPhone written in Obj-C/C++. It supposed to be a good substitution for outdated Apple translation system. However I still use default mechanisms to translate settings.bundle and views, so this solution is not 100% perfect but it perfectly substitutes lousy NSLocalizedString functionality.

== Basic usage ==

See GettextHelpers.h and TranslationCenter.h

`
#import "TranslationCenter.h"
#import "GettextHelpers.h"

// this is your app domain
// you can have multiple domains within app
#define TEXTDOMAIN @"domain"

...

TranslationCenter* translator = [TranslationCenter sharedCenter];
translator.defaultPath = @"/path/to/translations/folder/"; // bundle path by default
translator.locale = @"en_US"; // current locale by default

// will load domain-en_US.mo or domain-en_US.po if there no .mo available
[translator loadTextDomain:TEXTDOMAIN];

int num_apples = 10;

NSLog(@"Gettext translated string: %@", ___(@"Hi, this is gettext!", TEXTDOMAIN));
NSLog(@"Gettext translated plural: %@", __n(@"%d apple", @"%d apples", num_apples, TEXTDOMAIN));
`

= Single textdomain shorthandles =

Single textdomain shorthandles use DEFAULT_TEXTDOMAIN ('default') for textdomain

`__(singular)` - single string translation
`_n(singular, plural, number)` - plural translation
`_x(singular, context)` - single string translation with context
`_nx(singular, plural, number, context)` - plural translation with context

= Other shorthandles with custom textdomain =

Using these functions you must explicitly specify textdomain, useful if you have many textdomains, for example, translation splitted on many .po files.

`___(singular, textdomain)` - single string translation
`__n(singular, plural, number, textdomain)` - plural translation
`__x(singular, context, textdomain)` - single string translation with context
`__nx(singular, plural, number, context, textdomain)` - plural translation with context

== Textdomain lookup alghorithm ==

If you don't need more than one textdomain in your app then you can use Single textdomain shorthandles to make your life easier, in this case, by default, TranslationCenter will be looking for .mo or .po files with the following pattern: 

`%{app-bundle-path}/default-%{language}.%{format}.`

where %{language} is two letter code (e.g. ru, en, es, etc..)
%{format} is "mo" or "po". Mo files have bigger priority since it's more compact format and supposed to be used for distribution with apps.

== Compilation notes ==

1. It's necessary to use additional linker flag for your project otherwise you'll catch crash on first invocation, for some reason RegexKitLite NSString category doesn't exist after compilation. Add this to other linker flags of your app: 

`-ObjC`

More info here: https://developer.apple.com/library/mac/#qa/qa2006/qa1490.html

2. Your app must be linked against libicucore.dlyb because RegexKitLite uses this library internally.

3. Link your app against libstdc++.dylib, there are bits of C++ inside.

4. Pomo-iphone depends on muparser-iphone. So at the end you'll have a workspace with muparser-iphone and pomo-iphone compiled in the same order. 

== Poedit Settings ==

If you use Poedit, follow the instructions below to setup Objective-C parser for it:

Go to Poedit > Preferences and add new parser, I use similar parser as C/C++ that's already there.

List of extensions:
`*.m;*.mm;*.c;*.h;`

Parser command:
`xgettext --force-po -o %o %C %K %F -L ObjectiveC`

An item in keywords list:
`-k%k`

An item in input files:
`%f`

Source code charset:
`--from-code=%c`

== Catalog Settings ==

Setup the following keywords:

`
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
`

