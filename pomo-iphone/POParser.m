//
//  POParser.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011-2017 Andrej Mihajlov. All rights reserved.
//

#import "POParser.h"

@implementation POParser

- (BOOL)importFileAtPath:(NSString *)filename {
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filename encoding:NSUTF8StringEncoding error:&error];
    if(!fileContents) {
        NSLog(@"Error reading %@. Reason: %@", filename, error.localizedDescription);
        return false;
    }

    NSArray<NSString *> *split = [fileContents componentsSeparatedByString:@"\n\n"];
    for(NSString* str in split) {
        TranslationEntry* entry = [self readEntry:str];
        if(entry) {
            [self addEntry:entry];
        }
    }

    return YES;
}

- (TranslationEntry *)readEntry:(NSString *)entryString {
    TranslationEntry* entry = nil;
    NSArray* strings = [entryString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    for(NSString *s in strings) {
        NSString *str = s;
        
        if(!str.length) {
            continue;
        }
            
        if(!entry) {
            entry = [TranslationEntry new];
        }
        
        // parse header
        if([str characterAtIndex:0] == '"' && [str characterAtIndex:str.length-1] == '"')
        {
            str = [str substringWithRange:NSMakeRange(1, str.length - 2)];
            NSArray* arr = [self splitString:str separator:@":"];
            
            if(arr.count < 2)
                continue;
            
            NSString* value = [[self decodePOString:arr[1]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            //NSLog(@"Header %@ found: %@", [arr objectAtIndex:0], value);
            
            [self setHeader:arr[0] value:value];
        }
        else // parse actual entry
        {
            NSArray* arr = [self splitString:str separator:@" "];
            NSString* key, *value;
            NSUInteger keylen = 0;
            unichar c;
            
            if(arr.count < 2) {
                continue;
            }
            
            key = arr[0];
            value = arr[1];
            
            keylen = key.length;
            
            if([str characterAtIndex:0] == '#') // #. section
            {
                // don't use "key" here because of #_ (space) format 
                // for translator comments
                c = [str characterAtIndex:1];
                
                switch(c) 
                {
                    // reference
                    case ':':
                        [entry.references addObject:value];
                    break;
                    
                    // flag
                    case ',':
                        [entry.flags addObject:value];
                    break;
                        
                    // translator comments
                    case ' ':
                        entry.translator_comments = value;
                    break;
                    
                    // extracted comments
                    case '.':
                        entry.extracted_comments = value;
                    break;
                    
                    // previous message, not implemented
                    case '|':
                        break;
                        
                    default:
                        continue;
                        break;
                }
            }
            else if([key isEqualToString:@"msgctxt"]) // msgctxt
            {
                entry.context = [self decodeValueAndRemoveQuotes:value];
            }
            else if([key isEqualToString:@"msgid"]) // msgid
            {
                entry.singular = [self decodeValueAndRemoveQuotes:value];
            }
            else if([key isEqualToString:@"msgstr"]) // msgid
            {
                [entry.translations addObject:[self decodeValueAndRemoveQuotes:value]];
            }
            else if([key isEqualToString:@"msgid_plural"]) // msgid
            {
                entry.plural = [self decodeValueAndRemoveQuotes:value];
                entry.is_plural = YES;
            }
            else if(keylen >= 8 && [[key substringWithRange:NSMakeRange(0, 7)] isEqualToString:@"msgstr["])
            {
                [entry.translations addObject:[self decodeValueAndRemoveQuotes:value]];
            }
        }
    }
    
    return entry;
}

- (NSString *)decodeValueAndRemoveQuotes:(NSString *)string {
    NSString *decodedString = [self decodePOString:string];
    NSUInteger x = 0, y = decodedString.length;
    if(y == 0) {
        return decodedString;
    }
    
    if([decodedString characterAtIndex:0] == '"') {
        x += 1;
    }
    
    if(x < y && [decodedString characterAtIndex:decodedString.length - 1] == '"') {
        y -= 1;
    }
    
    return [decodedString substringWithRange:NSMakeRange(x, y-x)];
}

- (NSString *)decodePOString:(NSString *)string {
    string = [string stringByReplacingOccurrencesOfString:@"\\\\" withString:@"\\"];
    string = [string stringByReplacingOccurrencesOfString:@"\\t" withString:@"\t"];
    string = [string stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    string = [string stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];

    return string;
}

- (NSString *)encodePOString:(NSString *)string {
    string = [string stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    string = [string stringByReplacingOccurrencesOfString:@"\\t" withString:@"\t"];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    string = [string stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];

    return string;
}

- (NSArray<NSString *> *)splitString:(NSString *)string separator:(NSString *)separator {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    NSScanner* scan = [NSScanner scannerWithString:string];
    NSString* token;
    
    if([scan scanUpToString:separator intoString:&token]) {
        NSUInteger pos = scan.scanLocation + 1;
        [array addObject:token];
        
        if(pos < string.length) {
            [array addObject:[string substringFromIndex:pos]];
        }
    }
    
    return [NSArray arrayWithArray:array];    
}

@end




