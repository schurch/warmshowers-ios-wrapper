//
//  WSUser.m
//  WSAPIClient
//
//  Created by Stefan Church on 11/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import "WSUser.h"

@implementation WSUser

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.userId = dictionary[@"uid"];
        self.fullName = dictionary[@"name"];
        
        self.imagePath = dictionary[@"picture"];
        
        self.street = dictionary[@"street"];
        self.city = dictionary[@"city"];
        self.province = dictionary[@"province"];
        self.country = dictionary[@"country"];
        self.postcode = dictionary[@"postal_code"];
        
        self.latitude = [dictionary[@"latitude"] floatValue];
        self.longitude = [dictionary[@"longitude"] floatValue];
        self.distance = [dictionary[@"distance"] floatValue];
        
        self.currentlyUnavailable = [dictionary[@"notcurrentlyavailable"] boolValue];
    }
    return self;
}

@end
