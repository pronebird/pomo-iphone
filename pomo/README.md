== Cocoa POMO ==

Cocoa POMO is a gettext reader for iPhone written in Objective-C.

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

NSLog(@"Gettext translated string: %@", __(@"Hi, this is gettext!", TEXTDOMAIN));
NSLog(@"Gettext translated plural: %@", _n(@"%d apple", @"%d apples", TEXTDOMAIN));

...

`

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

    __
    _e
    _nx
    _x
    _n:1,2
    _n_noop:1,2
    _nx_noop:1,2

