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

@end
