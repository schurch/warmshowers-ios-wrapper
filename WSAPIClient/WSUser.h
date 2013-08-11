//
//  WSUser.h
//  WSAPIClient
//
//  Created by Stefan Church on 11/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSUser : NSObject

@property (nonatomic) NSNumber *userId;
@property (nonatomic, strong) NSString *fullName;

@property (nonatomic, strong) NSString *imagePath;

@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *postcode;

@property (nonatomic) float latitude;
@property (nonatomic) float longitude;
@property (nonatomic) float distance;

@property (nonatomic, getter = isCurrentlyUnavailable) BOOL currentlyUnavailable; // are they available to host

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
