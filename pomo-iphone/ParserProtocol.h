//
//  ParserProtocol.h
//  pomo
//
//  Created by Andrej Mihajlov on 4/7/12.
//  Copyright (c) 2012 Andrej Mihajlov. All rights reserved.
//

@protocol ParserProtocol <NSObject>

- (BOOL)importFileAtPath:(NSString*)filename;

@end
