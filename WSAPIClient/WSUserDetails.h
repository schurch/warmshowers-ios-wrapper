//
//  WSUserDetails.h
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

#import <Foundation/Foundation.h>

#import "WSUser.h"

@interface WSUserDetails : WSUser<NSCoding>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSDate *joined;
@property (nonatomic, strong) NSDate *lastLogin;

@property (nonatomic, strong) NSString *additionalAddress;
@property (nonatomic, strong) NSString *homePhoneNumber;
@property (nonatomic, strong) NSString *mobilePhoneNumber;
@property (nonatomic, strong) NSString *workPhoneNumber;
@property (nonatomic, strong) NSString *faxNumber;
@property (nonatomic, strong) NSURL *website;

@property (nonatomic, strong) NSString *preferedNotice;
@property (nonatomic, strong) NSString *nearestLargeCity;
@property (nonatomic, strong) NSString *nearestHotel;
@property (nonatomic, strong) NSString *nearestCampground;
@property (nonatomic, strong) NSString *nearestBikeshop;
@property (nonatomic, strong) NSString *languagesSpoken;

@property (nonatomic, strong) NSString *comments;

@property (nonatomic) NSInteger maxGuests;

@property (nonatomic, getter = areServicesAvailable) BOOL servicesAvailable; // do they have services to offer
// services offered
@property (nonatomic, getter = isBedAvailable) BOOL bedAvailable;
@property (nonatomic, getter = isFoodAvailable) BOOL foodAvailable;
@property (nonatomic, getter = isLaundryAvailable) BOOL laundryAvailable;
@property (nonatomic, getter = isLawnSpaceAvailable) BOOL lawnSpaceAvailable;
@property (nonatomic, getter = isSagAvailable) BOOL sagAvailable;
@property (nonatomic, getter = isShowerAvailable) BOOL showerAvailable;
@property (nonatomic, getter = isStorageAvailable) BOOL storageAvailable;
@property (nonatomic, getter = isKitchenAvailable) BOOL kitchenAvailable;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
