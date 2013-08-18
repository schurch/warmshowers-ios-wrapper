//
//  WSFeedback.h
//  WSAPIClient
//
//  Created by Stefan Church on 10/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WSFeedbackUserType.h"

@interface WSFeedback : NSObject

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSDate *feedbackDate;
@property (nonatomic, strong) NSString *feedbackText;

@property (nonatomic) WSFeedbackUserType feedbackUserStatus;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
