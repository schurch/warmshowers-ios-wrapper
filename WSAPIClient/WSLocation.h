//
//  WSLocation.h
//  WSAPIClient
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface WSLocation : NSObject

@property (nonatomic) CLLocationCoordinate2D minimumCoordinateForBoundingArea;
@property (nonatomic) CLLocationCoordinate2D maximumCoordinateForBoundingArea;

- (CLLocationCoordinate2D)centerCoordinateForBoundingArea;

@end
