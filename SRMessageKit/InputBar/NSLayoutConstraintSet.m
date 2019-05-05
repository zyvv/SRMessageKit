//
//  NSLayoutConstraintSet.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/30.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "NSLayoutConstraintSet.h"

@interface NSLayoutConstraint ()

@property (nonatomic, strong) NSArray *availableConstraints;

@end

@implementation NSLayoutConstraintSet

- (instancetype)initWithTop:(NSLayoutConstraint *_Nullable)top
                     bottom:(NSLayoutConstraint *_Nullable)bottom
                       left:(NSLayoutConstraint *_Nullable)left
                      right:(NSLayoutConstraint *_Nullable)right
                    centerX:(NSLayoutConstraint *_Nullable)centerX
                    centerY:(NSLayoutConstraint *_Nullable)centerY
                      width:(NSLayoutConstraint *_Nullable)width
                     height:(NSLayoutConstraint *_Nullable)height {
    self = [super init];
    if (self) {
        self.sr_top = top;
        self.sr_bottom = bottom;
        self.sr_left = left;
        self.sr_right  = right;
        self.sr_centerX = centerX;
        self.sr_centerY = centerY;
        self.sr_width = width;
        self.sr_height = height;
    }
    return self;
}

- (NSArray *)availableConstraints {
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:0];
    if (self.sr_top) {
        [constraints addObject:self.sr_top];
    }
    if (self.sr_bottom) {
        [constraints addObject:self.sr_bottom];
    }
    if (self.sr_right) {
        [constraints addObject:self.sr_right];
    }
    if (self.sr_centerX) {
        [constraints addObject:self.sr_centerX];
    }
    if (self.sr_centerY) {
        [constraints addObject:self.sr_centerY];
    }
    if (self.sr_width) {
        [constraints addObject:self.sr_width];
    }
    if (self.sr_height) {
        [constraints addObject:self.sr_height];
    }
    return [constraints copy];
}

- (NSLayoutConstraintSet *)acctivate {
    [NSLayoutConstraint activateConstraints:self.availableConstraints];
    return self;
}

- (NSLayoutConstraintSet *)deactivate {
    [NSLayoutConstraint deactivateConstraints:self.availableConstraints];
    return self;
}

@end
