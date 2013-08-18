//
//  WSLocation.m
//  WSAPIClient
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import "WSLocation.h"

@implementation WSLocation

- (CLLocationCoordinate2D)centerCoordinateForBoundingArea
{
    return CLLocationCoordinate2DMake((self.minimumCoordinateForBoundingArea.latitude + self.maximumCoordinateForBoundingArea.latitude / 2), (self.minimumCoordinateForBoundingArea.longitude + self.maximumCoordinateForBoundingArea.longitude / 2));
}

@end
