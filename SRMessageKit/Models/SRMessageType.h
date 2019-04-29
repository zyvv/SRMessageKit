//
//  SRMessageType.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRSender.h"
#import "SRMessageKind.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRMessageType : NSObject

@property (nonatomic, strong) SRSender *sender;
@property (nonatomic, strong) NSString *messageId;
@property (nonatomic, strong) NSDate *sentDate;
@property (nonatomic, strong) SRMessageKind *kind;

@end

NS_ASSUME_NONNULL_END
