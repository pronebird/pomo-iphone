//
//  AMMOParser.m
//  pomo
//
//  Created by pronebird on 12/4/11.
//  Copyright (c) 2011 Andrei Mikhailov. All rights reserved.
//

#import "MOParser.h"

typedef struct _mo_header {
	int32_t magic;
	int32_t revision;
	int32_t num_strings;
	int32_t orig_strings_addr;
	int32_t trans_strings_addr;
	int32_t hash_table_size;
	int32_t hash_table_offset;
} mo_header;

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
	size_t mosz = sizeof(mo);
	
	int32_t magic_big = 0x950412de, magic_little = 0xde120495;
	BOOL is_little = FALSE;
	
	NSFileHandle* handle = [NSFileHandle fileHandleForReadingAtPath:filename];
	NSData* hdr_data = [handle readDataOfLength:mosz];
	
	if(hdr_data.length == mosz)
	{
		memcpy(&mo, hdr_data.bytes, mosz);
		
		is_little = mo.magic == magic_little;
		
		NSLog(@"AMMOParser::importFileAtPath: is_little %d", is_little);
		
		if(mo.magic == magic_big || is_little)
		{
			
		}
	}
	
	return FALSE;
}

@end
