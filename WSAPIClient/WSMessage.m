//
//  WSMessage.m
//  WSAPIClient
//
//  Created by Stefan Church on 24/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import "WSMessage.h"

#import "WSMessageAuthor.h"

@implementation WSMessage

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.messageId = dictionary[@"mid"];
        self.messageThreadId = dictionary[@"thread_id"];
        self.subject = dictionary[@"subject"];
        self.body = dictionary[@"body"];
        self.author = [[WSMessageAuthor alloc] initWithDictionary:dictionary[@"author"]];
        
        if (dictionary[@"timestamp"]) {
            self.createdAt = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"timestamp"] integerValue]];
        }
        
        self.newMessage = [dictionary[@"is_new"] boolValue];
    }
    return self;
}

@end
