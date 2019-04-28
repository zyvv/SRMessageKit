//
//  SRSender.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRSender.h"

@implementation SRSender

- (instancetype)initWithSenderID:(NSString *)senderID displayName:(NSString *)displayName {
    self = [super init];
    if (self) {
        self.senderID = senderID;
        self.displayName = displayName;
    }
    return self;
}

- (BOOL)isEqual:(SRSender *)object {
    return object.senderID == self.senderID;
}

@end
