//
//  SRSender.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRSender : NSObject

@property (nonatomic, copy) NSString *senderID;
@property (nonatomic, copy) NSString *displayName;

- (instancetype)initWithSenderID:(NSString *)senderID displayName:(NSString *)displayName;

- (BOOL)isEqual:(SRSender *)object;

@end

NS_ASSUME_NONNULL_END
