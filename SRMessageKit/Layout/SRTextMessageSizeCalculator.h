//
//  SRTextMessageSizeCalculator.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/29.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessageSizeCalculator.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRTextMessageSizeCalculator : SRMessageSizeCalculator

@property (nonatomic, assign) UIEdgeInsets incomingMessageLabelInsets;
@property (nonatomic, assign) UIEdgeInsets outgoingMessageLabelInsets;

@property (nonatomic, strong) UIFont *messageLabelFont;



@end

NS_ASSUME_NONNULL_END
