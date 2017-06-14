//
//  TranslationCenter.m
//  pomo
//
//  Created by pronebird on 4/18/11.
//  Copyright 2011-2017 Andrej Mihajlov. All rights reserved.
//

#import "TranslationCenter.h"
#import "Translations.h"
#import "GettextTranslations.h"
#import "NOOPTranslations.h"
#import "POParser.h"
#import "MOParser.h"

static NOOPTranslations *sharedNOOPTranslations;

@interface TranslationCenter()
@property (readwrite, nonatomic) NSMutableDictionary *domains;
@end


@implementation TranslationCenter

+ (TranslationCenter*)sharedCenter {
    static TranslationCenter *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
        sharedNOOPTranslations = [[NOOPTranslations alloc] init];
    });
    return sharedInstance;
}

+ (NSString *)textDomainFileWithBasePath:(NSString *)path forDomain:(NSString *)domain language:(NSString *)language type:(NSString *)ext {
    NSString *filename = [NSString stringWithFormat:@"%@-%@.%@", domain, language, ext ? ext.lowercaseString : @"mo"];
    return [path stringByAppendingPathComponent:filename];
}

- (instancetype)init {
    if(self = [super init]) {
        NSString *preferredLanguage = [NSLocale preferredLanguages].firstObject;
        NSScanner *scanner = [[NSScanner alloc] initWithString:preferredLanguage];
        NSString *twoLetterLanguageCode;
        
        if(![scanner scanUpToString:@"-" intoString:&twoLetterLanguageCode]) {
            twoLetterLanguageCode = preferredLanguage;
        }
        
        self.language = twoLetterLanguageCode;
        self.defaultPath = [NSBundle mainBundle].bundlePath;
        self.domains = [NSMutableDictionary new];
    }
    return self;
}

- (BOOL)loadTextDomain:(NSString *)domain {
    NSParameterAssert(domain);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [TranslationCenter textDomainFileWithBasePath:self.defaultPath forDomain:domain language:self.language type:@"mo"];
    
    if(![fileManager fileExistsAtPath:path]) {
        path = [TranslationCenter textDomainFileWithBasePath:self.defaultPath forDomain:domain language:self.language type:@"po"];
        if(![fileManager fileExistsAtPath:path]) {
            return NO;
        }
    }
    
    return [self loadTextDomain:domain path:path];
}

- (BOOL)loadTextDomain:(NSString *)domain path:(NSString *)path {
    NSParameterAssert(domain);
    NSParameterAssert(path);
    
    id<ParserProtocol> parser;
    
    if([path.pathExtension isEqualToString:@"mo"]) {
        parser = [[MOParser alloc] init];
    } else if([path.pathExtension isEqualToString:@"po"]) {
        parser = [[POParser alloc] init];
    } else {
        return NO;
    }
    
    NSLog(@"Loading %@ using %@", path, NSStringFromClass([parser class]));
    
    if([parser importFileAtPath:path]) {
        (self.domains)[domain] = parser;
        return YES;
    }
    
    return NO;
}

- (BOOL)unloadTextDomain:(NSString *)domain {
    NSParameterAssert(domain);
    
    GettextTranslations *translations = (self.domains)[domain];
    if(translations) {
        [self.domains removeObjectForKey:domain];
        return YES;
    }
    
    return NO;
}

- (NSString *)translate:(NSString *)singular domain:(NSString *)domain {
    NSParameterAssert(singular);
    NSParameterAssert(domain);
    
    GettextTranslations *translations = (self.domains)[domain];
    if(translations) {
        return [translations translate:singular];
    }
    
    return [sharedNOOPTranslations translate:singular];
}

- (NSString *)translate:(NSString *)singular context:(NSString *)context domain:(NSString *)domain {
    NSParameterAssert(singular);
    NSParameterAssert(domain);
    
    GettextTranslations *translations = (self.domains)[domain];
    if(translations) {
        return [translations translate:singular context:context];
    }
    
    return [sharedNOOPTranslations translate:singular context:context];
}

- (NSString *)translatePlural:(NSString *)singular plural:(NSString *)plural count:(NSInteger)count context:(NSString *)context domain:(NSString *)domain
{
    NSParameterAssert(singular);
    NSParameterAssert(plural);
    NSParameterAssert(domain);
    
    GettextTranslations* translations = (self.domains)[domain];
    if(translations) {
        return [translations translatePlural:singular plural:plural count:count context:context];
    }
    
    return [sharedNOOPTranslations translatePlural:singular plural:plural count:count context:context];
}

@end
