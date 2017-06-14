//
//  GettextTranslations.mm
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011-2017 Andrej Mihajlov. All rights reserved.
//

#import "GettextTranslations.h"
#import "muParserInt.h"

@interface GettextTranslations()

@property (readwrite, assign) NSUInteger numPlurals;
@property (readwrite) NSString *pluralRule;

@end

@implementation GettextTranslations {
    mu::ParserInt *_muParser;
}

- (instancetype)init {
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.numPlurals = 0;
    self.pluralRule = nil;
    
    _muParser = new mu::ParserInt();
    _muParser->EnableBuiltInOprt();
    _muParser->DefineOprt("%", fmod, 5);
    
    return self;
}

- (void)dealloc {
    delete _muParser;
    _muParser = NULL;
}

- (NSDictionary *)_scanPluralFormsString:(NSString *)src {
    NSMutableDictionary<NSString *, NSString *>  *result = [[NSMutableDictionary alloc] init];
    NSArray<NSString *> *strings = [src componentsSeparatedByString:@";"];
    NSCharacterSet *charset = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    for(NSString *str in strings)  {
        NSScanner *scanner = [NSScanner scannerWithString:str];
        NSString *key = nil;
        
        if([scanner scanUpToString:@"=" intoString:&key]) {
            NSString *trimmedValue = [[str substringFromIndex:scanner.scanLocation + 1] stringByTrimmingCharactersInSet:charset];
            NSString *trimmedKey = [key stringByTrimmingCharactersInSet:charset];
            
            result[trimmedKey] = trimmedValue;
        }
    }
    
    return [result copy];
}

- (void)setHeader:(NSString*)header value:(NSString*)value {
    [super setHeader:header value:value];
    
    if(![header isEqualToString:@"Plural-Forms"]) {
        return;
    }
    
    NSDictionary<NSString *, NSString *> *dict = [self _scanPluralFormsString:[self header:header]];
    NSString *nplurals = dict[@"nplurals"];
    NSString *rule = dict[@"plural"];
    
    self.numPlurals = (NSUInteger)nplurals.integerValue;
    
    if(rule) {
        self.pluralRule = [rule stringByReplacingOccurrencesOfString:@";" withString:@""];
        _muParser->SetExpr(self.pluralRule.UTF8String);
    } else {
        self.pluralRule = nil;
    }
}

- (NSUInteger)selectPluralForm:(NSInteger)count {
    if(self.pluralRule) {
        _muParser->DefineConst("n", count);
        
        try {
            return (NSUInteger)_muParser->Eval();
        } catch (mu::ParserInt::exception_type &e) {
            NSLog(@"muParser error: %s", e.GetMsg().c_str());
        }
    }
    
    return [super selectPluralForm:count];
}

@end
