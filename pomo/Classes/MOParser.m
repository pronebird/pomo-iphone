//
//  AMMOParser.m
//  pomo
//
//  Created by pronebird on 12/4/11.
//  Copyright (c) 2011 Andrej Mihajlov. All rights reserved.
//

#import "MOParser.h"

#pragma pack(4)
typedef struct _mo_header {
	int32_t magic;
	int32_t revision;
	int32_t num_strings;
	int32_t orig_strings_addr;
	int32_t trans_strings_addr;
	int32_t hash_table_size;
	int32_t hash_table_addr;
} mo_header;

typedef struct _mo_position {
	int32_t length;
	int32_t offset;
} mo_position;
#pragma pack()

@implementation MOParser

- (id)init
{
	self = [super init];
	
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

- (BOOL)importFileAtPath:(NSString*)filename
{
	mo_header mo;
	mo_position* originals = NULL, *translations = NULL;
	int32_t magic = 0x950412de, bufsize = 0, newbufsize, originals_lengths_length, translations_lenghts_length;
	char* buf = NULL;
	BOOL is_little_endian = FALSE, retval = FALSE;
	NSString* original_string = nil, *translation_string = nil;
	TranslationEntry* entry;

	FILE* fp = fopen([filename cStringUsingEncoding:NSUTF8StringEncoding], "rb");

	if(!fp)
		return FALSE;
	
	if(fread(&mo, sizeof(mo), 1, fp) != 1) {
		//NSLog(@"Cannot read file header. File probably corrupted.");
		goto cleanup;
	}

	is_little_endian = mo.magic == OSSwapInt32(magic);

	if(mo.magic != magic && !is_little_endian) {
		//NSLog(@"Magic number mismatch. File probably corrupted.");
		goto cleanup;
	}
		
	// swap to big endian
	if(is_little_endian)
	{
		mo.revision = OSSwapInt32(mo.revision);
		mo.num_strings = OSSwapInt32(mo.num_strings);
		mo.orig_strings_addr = OSSwapInt32(mo.orig_strings_addr);
		mo.trans_strings_addr = OSSwapInt32(mo.trans_strings_addr);
		mo.hash_table_size = OSSwapInt32(mo.hash_table_size);
		mo.hash_table_addr = OSSwapInt32(mo.hash_table_addr);
	}
	
	// support revision 0 of MO format specs only
	if(mo.revision != 0) {
		//NSLog(@"Unsupported mo.revision: %d", mo.revision);
		goto cleanup;
	}

	if(fseek(fp, mo.orig_strings_addr, SEEK_SET) != 0)
		goto cleanup;
	
	originals_lengths_length = mo.trans_strings_addr - mo.orig_strings_addr;
	translations_lenghts_length = mo.hash_table_addr - mo.trans_strings_addr;

	originals = malloc(originals_lengths_length);
	translations = malloc(translations_lenghts_length);
	
	if(fread(originals, sizeof(mo_position), mo.num_strings, fp) != mo.num_strings)
		goto cleanup;

	if(fread(translations, sizeof(mo_position), mo.num_strings, fp) != mo.num_strings)
		goto cleanup;
	
	for(uint i = 0; i < mo.num_strings; i++)
	{
		// swap to big endian
		if(is_little_endian)
		{
			originals[i].offset = OSSwapInt32(originals[i].offset);
			originals[i].length = OSSwapInt32(originals[i].length);
			translations[i].offset = OSSwapInt32(translations[i].offset);
			translations[i].length = OSSwapInt32(translations[i].length);
		}
		
		// allocate or reallocate string buffer if necessary
		newbufsize = MAX(256, MAX(translations[i].length, originals[i].length));
		if(bufsize < newbufsize)
		{
			bufsize = newbufsize;
			if(buf)
				buf = realloc(buf, newbufsize);
			else
				buf = malloc(newbufsize);
		}
		
		// read translation string
		if(fseek(fp, translations[i].offset, SEEK_SET) != 0)
			goto cleanup;

		if(fread(buf, 1, translations[i].length, fp) != translations[i].length)
			goto cleanup;

		buf[translations[i].length] = '\0';

		// parse header from translation string
		if(originals[i].length == 0)
		{
			translation_string = [NSString stringWithUTF8String:buf];
		} 
		else // otherwise build entry
		{
			entry = [[[TranslationEntry alloc] init] autorelease];

			for(char* p = buf; p - buf < translations[i].length; p += strlen(p) + 1)
				[entry.translations addObject:[NSString stringWithUTF8String:p]];

			fseek(fp, originals[i].offset, SEEK_SET);
			fread(buf, 1, originals[i].length, fp);
			buf[originals[i].length] = '\0';
			original_string = [NSString stringWithUTF8String:buf];

			entry.singular = original_string;
			if(strlen(buf) < originals[i].length) {
				entry.plural = [NSString stringWithUTF8String:buf + strlen(buf) + 1];
				entry.is_plural = TRUE;
			}
			
			//[entry debugPrint];
			[self addEntry:entry];
		}
	}
	
	// read headers
	int headers_start_pos = ftell(fp)+1;
	fseek(fp, 0, SEEK_END);
	int headers_end_pos = ftell(fp),
		headers_length = headers_end_pos - headers_start_pos;
	
	fseek(fp, headers_start_pos, SEEK_SET); // pass \0 to read headers
	if(headers_length && !feof(fp))
	{
		if(bufsize < headers_length) {
			bufsize = headers_length + 1;
			if(buf)
				buf = realloc(buf, bufsize);
			else
				buf = malloc(bufsize);
		}
		// there supposed to be some trash at the end of file
		// however it's separated from headers by \0
		// so we have small overhead..
		fread(buf, 1, headers_length, fp);
		buf[headers_length] = '\0';
		
		NSArray* strings = [[NSString stringWithCString:buf encoding:NSUTF8StringEncoding] componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
		
		for(NSString* str in strings)
		{
			NSArray* arr = [self splitString:str separator:@":"];
			
			if(arr.count < 2)
				continue;
			
			NSString* value = [[arr objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
			
			//NSLog(@"Header %@ found: %@", [arr objectAtIndex:0], value);
			
			[self setHeader:[arr objectAtIndex:0] value:value];
		}
	}
	
	retval = TRUE;

cleanup:
	
	free(originals);
	free(translations);
	free(buf);

	fclose(fp);
	
	return retval;
}

- (NSArray*)splitString:(NSString*)string separator:(NSString*)separator 
{
	NSScanner* scan = [NSScanner scannerWithString:string];
	NSString* token = nil;
	NSMutableArray* array = [[[NSMutableArray alloc] initWithCapacity:2] autorelease];
	
	if([scan scanUpToString:separator intoString:&token])
	{
		[array addObject:token];
		
		NSUInteger pos = [scan scanLocation]+1;
		
		if(pos < string.length)
			[array addObject:[string substringFromIndex:pos]];
	}
	
	
	return [NSArray arrayWithArray:array];	
}

@end
