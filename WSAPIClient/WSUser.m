//
//  WSUser.m
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

#pragma mark - NScoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.userId = [decoder decodeObjectForKey:@"userId"];
        self.fullName = [decoder decodeObjectForKey:@"fullName"];
        self.imagePath = [decoder decodeObjectForKey:@"imagePath"];
        self.street = [decoder decodeObjectForKey:@"street"];
        self.city = [decoder decodeObjectForKey:@"city"];
        self.province = [decoder decodeObjectForKey:@"province"];
        self.country = [decoder decodeObjectForKey:@"country"];
        self.postcode = [decoder decodeObjectForKey:@"postcode"];
        self.latitude = [decoder decodeFloatForKey:@"latitude"];
        self.longitude = [decoder decodeFloatForKey:@"longitude"];
        self.distance = [decoder decodeFloatForKey:@"distance"];
        self.currentlyUnavailable = [decoder decodeBoolForKey:@"currentlyUnavailable"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.userId forKey:@"userId"];
    [encoder encodeObject:self.fullName forKey:@"fullName"];
    [encoder encodeObject:self.imagePath forKey:@"imagePath"];
    [encoder encodeObject:self.street forKey:@"street"];
    [encoder encodeObject:self.city forKey:@"city"];
    [encoder encodeObject:self.province forKey:@"province"];
    [encoder encodeObject:self.country forKey:@"country"];
    [encoder encodeObject:self.postcode forKey:@"postcode"];
    [encoder encodeFloat:self.latitude forKey:@"latitude"];
    [encoder encodeFloat:self.longitude forKey:@"longitude"];
    [encoder encodeFloat:self.distance forKey:@"distance"];
    [encoder encodeBool:self.currentlyUnavailable forKey:@"currentlyUnavailable"];
}

@end
