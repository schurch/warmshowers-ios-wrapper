//
//  WSFeedback.m
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

#import "WSFeedback.h"

@implementation WSFeedback

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.userId = dictionary[@"uid"];
        self.fullName = dictionary[@"fullname"];
        
        NSString *nameField = dictionary[@"name"];
        NSString *nameOneField = dictionary[@"name_1"];
        
        // Look for @ symbol and set email to that field
        if ([nameField rangeOfString:@"@"].location != NSNotFound) {
            self.email = nameField;
            self.username = nameOneField;
        }
        else if ([nameOneField rangeOfString:@"@"].location != NSNotFound) {
            self.email = nameOneField;
            self.username = nameField;
        }
        else {
            self.username = nameField;
        }
        
        if (dictionary[@"field_hosting_date_value"]) {
            self.feedbackDate = [NSDate dateWithTimeIntervalSince1970:[dictionary[@"field_hosting_date_value"] integerValue]];
        }
        
        self.feedbackText = dictionary[@"body"];
        
        NSString *userStatus = [[dictionary[@"field_guest_or_host_value"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];

        if ([userStatus isEqualToString:@"host"]) {
            self.feedbackUserStatus = WSFeedbackUserTypeHost;
        }
        else if ([userStatus isEqualToString:@"guest"]) {
            self.feedbackUserStatus = WSFeedbackUserTypeGuest;
        }
        else if ([userStatus isEqualToString:@"met traveling"]) {
            self.feedbackUserStatus = WSFeedbackUserTypeMetTraveling;
        }
        else {
            self.feedbackUserStatus = WSFeedbackUserTypeOther;
        }
    }
    return self;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.userId = [decoder decodeObjectForKey:@"userId"];
        self.fullName = [decoder decodeObjectForKey:@"fullName"];
        self.username = [decoder decodeObjectForKey:@"username"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.feedbackDate = [decoder decodeObjectForKey:@"feedbackDate"];
        self.feedbackText = [decoder decodeObjectForKey:@"feedbackText"];
        self.feedbackUserStatus = [decoder decodeIntegerForKey:@"feedbackUserStatus"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.userId forKey:@"userId"];
    [encoder encodeObject:self.fullName forKey:@"fullName"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.feedbackDate forKey:@"feedbackDate"];
    [encoder encodeObject:self.feedbackText forKey:@"feedbackText"];
    [encoder encodeInteger:self.feedbackUserStatus forKey:@"feedbackUserStatus"];
}

@end
