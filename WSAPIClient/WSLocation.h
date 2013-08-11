//
//  WSLocation.h
//  WSAPIClient
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSLocation : NSObject

@property (nonatomic) float minimumLatitude;
@property (nonatomic) float maximumLatitude;
@property (nonatomic) float minimumLongitude;
@property (nonatomic) float maximumLongitude;
@property (nonatomic) float centerLatitude;
@property (nonatomic) float centerLongitude;

@end
