//
//  WSUserDetails.m
//  WSAPIClient
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
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
