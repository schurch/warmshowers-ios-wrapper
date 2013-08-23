//
//  WSMessage.h
//  WSAPIClient
//
//  Created by Stefan Church on 23/08/2013.
//  Copyright (c) 2013 Stefan Church. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSMessage : NSObject

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSArray *participants;
@property (nonatomic, strong) NSDate *threadLastUpdated;
@property (nonatomic, strong) NSDate *threadStarted;

@property (nonatomic) NSInteger count;
@property (nonatomic, getter = isMessageNew) BOOL messageNew;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
