//
//  WSMessageThread.m
//  WSAPIClient
//
//  Created by Stefan Church on 24/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import "WSMessageThread.h"

#import "WSMessage.h"
#import "WSMessageAuthor.h"

@implementation WSMessageThread

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.messageThreadId = dictionary[@"thread_id"];
        self.subject = dictionary[@"subject"];
        self.messageCount = [dictionary[@"message_count"] integerValue];
        
        NSMutableArray *participants = [[NSMutableArray alloc] init];
        [dictionary[@"participants"] enumerateKeysAndObjectsUsingBlock:^(id key, NSDictionary *participantData, BOOL *stop) {
            WSMessageAuthor *participant = [[WSMessageAuthor alloc] initWithDictionary:participantData];
            [participants addObject:participant];
        }];
        
        self.participants = [participants copy];
        
        NSMutableArray *messages = [[NSMutableArray alloc] init];
        [dictionary[@"messages"] enumerateObjectsUsingBlock:^(NSDictionary *messageData, NSUInteger idx, BOOL *stop) {
            WSMessage *message = [[WSMessage alloc] initWithDictionary:messageData];
            [messages addObject:message];
        }];
        
        self.messages = [messages copy];
    }
    return self;
}

@end
