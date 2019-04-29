//
//  SRMessageContainerView.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SRMessageStyle;
@interface SRMessageContainerView : UIImageView

@property (nonatomic, strong) SRMessageStyle *style;

@end

NS_ASSUME_NONNULL_END
