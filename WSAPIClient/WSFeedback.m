//
//  WSFeedback.m
//  WSAPIClient
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
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

@end
