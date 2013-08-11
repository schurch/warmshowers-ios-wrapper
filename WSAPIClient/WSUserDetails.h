//
//  WSUserDetails.h
//  WSAPIClient
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WSUser.h"

@interface WSUserDetails : WSUser

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
