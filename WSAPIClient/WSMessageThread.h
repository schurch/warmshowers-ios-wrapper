//
//  WSMessageThread.h
//  WSAPIClient
//
//  Created by Stefan Church on 24/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSMessageThread : NSObject

@property (nonatomic, strong) NSNumber *messageThreadId;
@property (nonatomic, strong) NSArray *messages;
@property (nonatomic, strong) NSArray *participants;
@property (nonatomic, strong) NSString *subject;

@property (nonatomic) NSInteger messageCount;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
