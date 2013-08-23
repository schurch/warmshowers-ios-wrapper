//
//  WSMessageParticipant.h
//  WSAPIClient
//
//  Created by Stefan Church on 23/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSMessageParticipant : NSObject

@property (nonatomic) NSNumber *userId;
@property (nonatomic, strong) NSString *username;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
