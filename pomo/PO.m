//
//  PO.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PO.h"
#import "NSStringExt.h"

#define PO_LINE_BUF 100

@implementation PO

- (id) init
{
	self = [super init];
	
	if(self)
	{
		
	}
	
	return self;
}

- (void) dealloc
{
	[super dealloc];
}

- (bool) importFileAtPath : (NSString*)filename
{
	FILE* file;
	const char* cstrFilename = [filename cStringUsingEncoding:NSUTF8StringEncoding];

	if((file = fopen(cstrFilename, "rb")) != NULL) {
		
		TranslationEntry* entry = nil;
		
		while((entry = [self readEntry:file]) != nil)
		{ 
			NSLog(@"new entry\nsingular: %@\nplural: %@\nis_plural: %d\ntranslations:\n", entry.singular, entry.plural, entry.is_plural);
			
			NSUInteger i = 0;
			for(NSString* tr in entry.translations) {
				NSLog(@"[%lu] %@\n", i++, tr);
			}
			
			[self addEntry:entry];
		}
		
		fclose(file);
		
		return true;
	}
	
	return false;
}

- (NSString*) readLine : (FILE*)file encoding: (NSStringEncoding)encoding
{
	char* buf;
	char c;
	size_t bufsz = PO_LINE_BUF;
	size_t strsz = 0;
	size_t readlen = 0;
	
	NSString* ret = nil;
	
	buf = (char*)malloc(bufsz * sizeof(c));
	
	assert(buf != NULL);
	
	while (!feof(file))
	{
		readlen = fread(&c, sizeof(c), 1, file);
		
		if(readlen < 1)
			c = '\n';

		if(strsz >= bufsz) {
			bufsz += PO_LINE_BUF;
			buf = realloc(buf, bufsz);
			
			assert(buf != NULL);
		}
		
		buf[strsz++] = c;
		
		if(c == '\n')
		{
			buf[strsz-1] = '\0';
			ret = [NSString stringWithCString:buf encoding:encoding];
			break;
		}
	}
	
	free(buf);

	return ret;
}

- (TranslationEntry*) readEntry: (FILE*)file
{
	TranslationEntry* entry = nil;
	
	NSString* str = nil;
	
	while((str = [self readLine:file encoding:NSUTF8StringEncoding]) != nil && str.length)
	{
		if(!entry) {
			entry = [[[TranslationEntry alloc] init] autorelease];
		}
		
		// parse header
		if([str characterAtIndex:0] == '"' && [str characterAtIndex:str.length-1] == '"')
		{
			str = [str substringWithRange:NSMakeRange(1, str.length - 2)];
			NSArray* arr = [str split:@":"];
			
			if(arr.count < 2)
				continue;
			
			NSString* value = [[arr objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			
			NSLog(@"Header <%@> found: %@", [arr objectAtIndex:0], [self decodePOString:value]);
			
			[self setHeader:[arr objectAtIndex:0] value:value];
		}
		else // parse actual entry
		{
			NSArray* arr = [str split:@" "];
			NSString* key, *value;
			NSUInteger keylen = 0;
			unichar c;
			
			if(arr.count < 2)
				continue;
			
			key = [arr objectAtIndex:0];
			value = [arr objectAtIndex:1];
			
			keylen = key.length;
			
			if([str characterAtIndex:0] == '#') // #. section
			{
				if(keylen < 2)
					continue;
				
				c = [key characterAtIndex:1];
				
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
				entry.is_plural = true;
			}
			else if(keylen >= 8 && [[key substringWithRange:NSMakeRange(0, 7)] isEqualToString:@"msgstr["])
			{
				[entry.translations addObject:[self decodeValueAndRemoveQuotes:value]];
			}
		}
	}
	
	return entry;
}

- (NSString*) decodeValueAndRemoveQuotes : (NSString*)string
{
	NSUInteger x = 0, y = 0;
	
	string = [self decodePOString:string];
	
	y = string.length;
	
	if(y) 
	{
		if([string characterAtIndex:0] == '"')
			x++;
		
		if(x < y && [string characterAtIndex:string.length-1] == '"')
			y--;
		
		string = [string substringWithRange:NSMakeRange(x, y-x)];
	}
	
	return string;
}

- (NSString*) decodePOString : (NSString*)string
{
	string = [string stringByReplacingOccurrencesOfString:@"\\\\" withString:@"\\"];
	string = [string stringByReplacingOccurrencesOfString:@"\\t" withString:@"\t"];
	string = [string stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
	string = [string stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];

	return string;
}

- (NSString*) encodePOString : (NSString*)string
{
	string = [string stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
	string = [string stringByReplacingOccurrencesOfString:@"\\t" withString:@"\t"];
	string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
	string = [string stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];

	return string;
}

@end




