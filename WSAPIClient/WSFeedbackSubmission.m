//
//  WSFeedbackSubmission.m
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
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF ME_RCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "WSFeedbackSubmission.h"

@implementation WSFeedbackSubmission

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.username = [decoder decodeObjectForKey:@"username"];
        self.feedbackText = [decoder decodeObjectForKey:@"feedbackText"];
        self.feedbackDate = [decoder decodeObjectForKey:@"feedbackDate"];
        self.feedbackUserType = [decoder decodeIntegerForKey:@"feedbackUserType"];
        self.feedbackValue = [decoder decodeIntegerForKey:@"feedbackValue"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.feedbackText forKey:@"feedbackText"];
    [encoder encodeObject:self.feedbackDate forKey:@"feedbackDate"];
    [encoder encodeInteger:self.feedbackUserType forKey:@"feedbackUserType"];
    [encoder encodeInteger:self.feedbackValue forKey:@"feedbackValue"];
}

@end
