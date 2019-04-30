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

- (instancetype)initWithTop:(NSLayoutConstraint *)top
                     bottom:(NSLayoutConstraint *)bottom
                       left:(NSLayoutConstraint *)left
                      right:(NSLayoutConstraint *)right
                    centerX:(NSLayoutConstraint *)centerX
                    centerY:(NSLayoutConstraint *)centerY
                      width:(NSLayoutConstraint *)width
                     height:(NSLayoutConstraint *)height {
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
    NSArray *constraints = @[self.sr_top, self.sr_bottom, self.sr_left, self.sr_right, self.sr_centerX, self.sr_centerY, self.sr_width, self.sr_height];
    NSMutableArray *available = [NSMutableArray arrayWithCapacity:0];
    for (NSLayoutConstraint *constraint in constraints) {
        if (constraint) {
            [available addObject:constraint];
        }
    }
    return [available copy];
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