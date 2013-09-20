//
//  WSMessageThread.m
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

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.messageThreadId = [decoder decodeObjectForKey:@"messageThreadId"];
        self.messages = [decoder decodeObjectForKey:@"messages"];
        self.participants = [decoder decodeObjectForKey:@"participants"];
        self.subject = [decoder decodeObjectForKey:@"subject"];
        self.messageCount = [decoder decodeIntegerForKey:@"messageCount"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.messageThreadId forKey:@"messageThreadId"];
    [encoder encodeObject:self.messages forKey:@"messages"];
    [encoder encodeObject:self.participants forKey:@"participants"];
    [encoder encodeObject:self.subject forKey:@"subject"];
    [encoder encodeInteger:self.messageCount forKey:@"messageCount"];
}

@end
