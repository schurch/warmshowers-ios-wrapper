//
//  WSUserDetails.m
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

#import "WSUserDetails.h"

@implementation WSUserDetails

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.username = dictionary[@"name"];
        self.fullName = dictionary[@"fullname"];
        self.email = dictionary[@"mail"];
        
#warning Work out timezone information. Ideally these will be UTC..
        if (dictionary[@"created"]) {
            self.joined = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"created"] integerValue]];
        }
        if (dictionary[@"login"]) {
            self.lastLogin = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"login"] integerValue]];
        }
        
        self.additionalAddress = dictionary[@"additional"];
        self.homePhoneNumber = dictionary[@"homephone"];
        self.mobilePhoneNumber = dictionary[@"mobilephone"];
        self.workPhoneNumber = dictionary[@"workphone"];
        self.faxNumber = dictionary[@"fax_number"];
        self.website = [NSURL URLWithString:dictionary[@"URL"]];
        
        self.preferedNotice = dictionary[@"preferred_notice"];
        self.nearestLargeCity = dictionary[@"nearest_large_city"];
        self.nearestHotel = dictionary[@"motel"];
        self.nearestCampground = dictionary[@"campground"];
        self.nearestBikeshop = dictionary[@"bikesho"];
        self.languagesSpoken = dictionary[@"languagesspoken"];
        
        self.comments = dictionary[@"comments"];
        
        self.maxGuests = [dictionary[@"maxcyclists"] integerValue];
        
        self.servicesAvailable = [dictionary[@"services_available"] boolValue];
        self.bedAvailable = [dictionary[@"bed"] boolValue];
        self.foodAvailable = [dictionary[@"food"] boolValue];
        self.laundryAvailable = [dictionary[@"laundry"] boolValue];
        self.lawnSpaceAvailable = [dictionary[@"lawnspace"] boolValue];
        self.sagAvailable = [dictionary[@"sag"] boolValue];
        self.showerAvailable = [dictionary[@"shower"] boolValue];
        self.storageAvailable = [dictionary[@"storage"] boolValue];
        self.kitchenAvailable = [dictionary[@"kitchenuse"] boolValue];
    }
    return self;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.username = [decoder decodeObjectForKey:@"username"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.joined = [decoder decodeObjectForKey:@"joined"];
        self.lastLogin = [decoder decodeObjectForKey:@"lastLogin"];
        self.additionalAddress = [decoder decodeObjectForKey:@"additionalAddress"];
        self.homePhoneNumber = [decoder decodeObjectForKey:@"homePhoneNumber"];
        self.mobilePhoneNumber = [decoder decodeObjectForKey:@"mobilePhoneNumber"];
        self.workPhoneNumber = [decoder decodeObjectForKey:@"workPhoneNumber"];
        self.faxNumber = [decoder decodeObjectForKey:@"faxNumber"];
        self.website = [decoder decodeObjectForKey:@"website"];
        self.preferedNotice = [decoder decodeObjectForKey:@"preferedNotice"];
        self.nearestLargeCity = [decoder decodeObjectForKey:@"nearestLargeCity"];
        self.nearestHotel = [decoder decodeObjectForKey:@"nearestHotel"];
        self.nearestCampground = [decoder decodeObjectForKey:@"nearestCampground"];
        self.nearestBikeshop = [decoder decodeObjectForKey:@"nearestBikeshop"];
        self.languagesSpoken = [decoder decodeObjectForKey:@"languagesSpoken"];
        self.comments = [decoder decodeObjectForKey:@"comments"];
        self.maxGuests = [decoder decodeIntegerForKey:@"maxGuests"];
        self.servicesAvailable = [decoder decodeBoolForKey:@"servicesAvailable"];
        self.bedAvailable = [decoder decodeBoolForKey:@"bedAvailable"];
        self.foodAvailable = [decoder decodeBoolForKey:@"foodAvailable"];
        self.laundryAvailable = [decoder decodeBoolForKey:@"laundryAvailable"];
        self.lawnSpaceAvailable = [decoder decodeBoolForKey:@"lawnSpaceAvailable"];
        self.sagAvailable = [decoder decodeBoolForKey:@"sagAvailable"];
        self.showerAvailable = [decoder decodeBoolForKey:@"showerAvailable"];
        self.storageAvailable = [decoder decodeBoolForKey:@"storageAvailable"];
        self.kitchenAvailable = [decoder decodeBoolForKey:@"kitchenAvailable"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.joined forKey:@"joined"];
    [encoder encodeObject:self.lastLogin forKey:@"lastLogin"];
    [encoder encodeObject:self.additionalAddress forKey:@"additionalAddress"];
    [encoder encodeObject:self.homePhoneNumber forKey:@"homePhoneNumber"];
    [encoder encodeObject:self.mobilePhoneNumber forKey:@"mobilePhoneNumber"];
    [encoder encodeObject:self.workPhoneNumber forKey:@"workPhoneNumber"];
    [encoder encodeObject:self.faxNumber forKey:@"faxNumber"];
    [encoder encodeObject:self.website forKey:@"website"];
    [encoder encodeObject:self.preferedNotice forKey:@"preferedNotice"];
    [encoder encodeObject:self.nearestLargeCity forKey:@"nearestLargeCity"];
    [encoder encodeObject:self.nearestHotel forKey:@"nearestHotel"];
    [encoder encodeObject:self.nearestCampground forKey:@"nearestCampground"];
    [encoder encodeObject:self.nearestBikeshop forKey:@"nearestBikeshop"];
    [encoder encodeObject:self.languagesSpoken forKey:@"languagesSpoken"];
    [encoder encodeObject:self.comments forKey:@"comments"];
    [encoder encodeInteger:self.maxGuests forKey:@"maxGuests"];
    [encoder encodeBool:self.servicesAvailable forKey:@"servicesAvailable"];
    [encoder encodeBool:self.bedAvailable forKey:@"bedAvailable"];
    [encoder encodeBool:self.foodAvailable forKey:@"foodAvailable"];
    [encoder encodeBool:self.laundryAvailable forKey:@"laundryAvailable"];
    [encoder encodeBool:self.lawnSpaceAvailable forKey:@"lawnSpaceAvailable"];
    [encoder encodeBool:self.sagAvailable forKey:@"sagAvailable"];
    [encoder encodeBool:self.showerAvailable forKey:@"showerAvailable"];
    [encoder encodeBool:self.storageAvailable forKey:@"storageAvailable"];
    [encoder encodeBool:self.kitchenAvailable forKey:@"kitchenAvailable"];
}

@end
