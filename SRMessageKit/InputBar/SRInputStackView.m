//
//  SRInputStackView.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/30.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRInputStackView.h"

@implementation SRInputStackView

- (instancetype)initWithAxis:(UILayoutConstraintAxis)axis spacing:(CGFloat)spacing {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.axis = axis;
        self.spacing = spacing;
    }
    return self;
}

- (void)setup {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.distribution = UIStackViewDistributionFill;
    self.alignment = UIStackViewAlignmentBottom;
}

@end
