//
//  WSMessage.m
//  WSAPIClient
//
//  Created by Stefan Church on 23/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import "WSMessageThreadSummary.h"

#import "WSMessageAuthor.h"

@implementation WSMessageThreadSummary

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.threadSubject = dictionary[@"subject"];
        
        NSMutableArray *participants = [[NSMutableArray alloc] init];
        
        NSArray *participantsData = dictionary[@"participants"];
        [participantsData enumerateObjectsUsingBlock:^(NSDictionary *participantData, NSUInteger idx, BOOL *stop) {
            WSMessageAuthor *participant = [[WSMessageAuthor alloc] initWithDictionary:participantData];
            [participants addObject:participant];
        }];
        
        self.participants = participants;
        
        if (dictionary[@"last_updated"]) {
            self.lastUpdated = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"last_updated"] integerValue]];
        }
        
        if (dictionary[@"thread_started"]) {
            self.started = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"thread_started"] integerValue]];
        }
        
        self.messageCount = [dictionary[@"count"] integerValue];
        self.threadNew = [dictionary[@"is_new"] boolValue];
    }
    return self;
}

@end
