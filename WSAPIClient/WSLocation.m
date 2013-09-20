//
//  WSLocation.m
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

#import "WSLocation.h"

@implementation WSLocation

- (CLLocationCoordinate2D)centerCoordinateForBoundingArea
{
    return CLLocationCoordinate2DMake((self.minimumCoordinateForBoundingArea.latitude + self.maximumCoordinateForBoundingArea.latitude / 2), (self.minimumCoordinateForBoundingArea.longitude + self.maximumCoordinateForBoundingArea.longitude / 2));
}


#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        CLLocationDegrees minimumLatitude = [decoder decodeDoubleForKey:@"minimumLatitude"];
        CLLocationDegrees minimumLongitude = [decoder decodeDoubleForKey:@"minimumLongitude"];
        self.minimumCoordinateForBoundingArea = CLLocationCoordinate2DMake(minimumLatitude, minimumLongitude);
        
        CLLocationDegrees maximumLatitude = [decoder decodeDoubleForKey:@"maximumLatitude"];
        CLLocationDegrees maximumLongitude = [decoder decodeDoubleForKey:@"maximumLongitude"];
        self.maximumCoordinateForBoundingArea = CLLocationCoordinate2DMake(maximumLatitude, maximumLongitude);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeDouble:self.minimumCoordinateForBoundingArea.latitude forKey:@"minimumLatitude"];
    [encoder encodeDouble:self.minimumCoordinateForBoundingArea.longitude forKey:@"minimumLongitude"];
    [encoder encodeDouble:self.maximumCoordinateForBoundingArea.latitude forKey:@"maximumLatitude"];
    [encoder encodeDouble:self.maximumCoordinateForBoundingArea.longitude forKey:@"maximumLongitude"];
}

@end
