//
//  WSMessage.m
//  WSAPIClient
//
//  The MIT License (MIT)
//
//  Copyright (c) 2013 Stefan Church
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
