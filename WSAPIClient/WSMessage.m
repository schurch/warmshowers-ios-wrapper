//
//  WSMessage.m
//  WSAPIClient
//
//  Created by Stefan Church on 23/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import "WSMessage.h"

#import "WSMessageParticipant.h"

@implementation WSMessage

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.message = dictionary[@"subject"];
        
        NSMutableArray *participants = [[NSMutableArray alloc] init];
        
        NSArray *participantsData = dictionary[@"participants"];
        [participantsData enumerateObjectsUsingBlock:^(NSDictionary *participantData, NSUInteger idx, BOOL *stop) {
            WSMessageParticipant *participant = [[WSMessageParticipant alloc] initWithDictionary:participantData];
            [participants addObject:participant];
        }];
        
        self.participants = participants;
        
        if (dictionary[@"last_updated"]) {
            self.threadLastUpdated = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"last_updated"] integerValue]];
        }
        
        if (dictionary[@"thread_started"]) {
            self.threadStarted = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"thread_started"] integerValue]];
        }
        
        self.count = [dictionary[@"count"] integerValue];
        self.messageNew = [dictionary[@"is_new"] boolValue];
    }
    return self;
}

@end
