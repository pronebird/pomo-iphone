//
//  PO.m
//  pomo
//
//  Created by pronebird on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PO.h"

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
		
		NSString* str = nil;
		
		while((str = [self readLine:file encoding:NSUTF8StringEncoding]) != nil) { 
			NSLog(@"LINE: %@", str);
		}
		
		fclose(file);
	}
	
	return true;
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

- (TranslationEntry*) readEntry: (NSFileHandle*)file
{
	return nil;
}

@end
