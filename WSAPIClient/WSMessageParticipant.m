//
//  WSMessageParticipant.m
//  WSAPIClient
//
//  Created by Stefan Church on 23/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import "WSMessageParticipant.h"

@implementation WSMessageParticipant

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.userId = dictionary[@"uid"];
        self.username = dictionary[@"name"];
    }
    return self;
}

@end
