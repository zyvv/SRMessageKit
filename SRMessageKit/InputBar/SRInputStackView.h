//
//  SRInputStackView.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/30.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum SRInputStackViewPosition: NSUInteger {
    SRInputStackViewLeft,
    SRInputStackViewRight,
    SRInputStackViewBottom,
    SRInputStackViewTop,
} SRInputStackViewPosition;

@interface SRInputStackView : UIStackView

- (instancetype)initWithAxis:(UILayoutConstraintAxis)axis spacing:(CGFloat)spacing;

- (void)setup;

@end

NS_ASSUME_NONNULL_END
