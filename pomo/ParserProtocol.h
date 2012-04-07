//
//  ParserProtocol.h
//  pomo
//
//  Created by Andrei Mikhailov on 4/7/12.
//  Copyright (c) 2012 Andrei Mikhailov. All rights reserved.
//

@protocol ParserProtocol <NSObject>

- (BOOL)importFileAtPath:(NSString*)filename;

@end
