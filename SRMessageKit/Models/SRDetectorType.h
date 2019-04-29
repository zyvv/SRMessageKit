//
//  SRDetectorType.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum SRDetectorType: NSUInteger {
    SRDetectorTypeAddress,
    SRDetectorTypeDate,
    SRDetectorTypePhoneNumber,
    SRDetectorTypeUrl,
    SRDetectorTypeTransitInformation,
} SRDetectorType;

NSTextCheckingType textCheckingType(SRDetectorType type);

//@interface SRDetectorType : NSObject
//
//@end

NS_ASSUME_NONNULL_END
