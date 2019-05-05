//
//  UIView+SRExtensions.m
//  SRMessageKit
//
//  Created by vi~ on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "UIView+SRExtensions.h"

@implementation UIView (SRExtensions)

- (void)fillSuperView {
    if (!self.superview) {
        return;
    }
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *left = [self.leftAnchor constraintEqualToAnchor:self.superview.leftAnchor];
    NSLayoutConstraint *right = [self.rightAnchor constraintEqualToAnchor:self.superview.rightAnchor];
    NSLayoutConstraint *top = [self.topAnchor constraintEqualToAnchor:self.superview.topAnchor];
    NSLayoutConstraint *bottom = [self.bottomAnchor constraintEqualToAnchor:self.superview.bottomAnchor];
    [NSLayoutConstraint activateConstraints:@[left, right, top, bottom]];
}

- (NSArray *)addConstraints:(NSLayoutYAxisAnchor *)top
                       left:(NSLayoutXAxisAnchor *)left
                     bottom:(NSLayoutYAxisAnchor *)bottom
                      right:(NSLayoutXAxisAnchor *)right
                topConstant:(CGFloat)topConstant
               leftConstant:(CGFloat)leftConstant
             bottomConstant:(CGFloat)bottomConstant
              rightConstant:(CGFloat)rightConstant
              widthConstant:(CGFloat)widthConstant
             heightConstant:(CGFloat)heightConstant {
    if (!self.superview) {
        return @[];
    }
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:0];
    if (top) {
         NSLayoutConstraint *constraint = [self.topAnchor constraintEqualToAnchor:top constant:topConstant];
        constraint.identifier = @"top";
        [constraints addObject:constraint];
    }
    if (left) {
        NSLayoutConstraint *constraint = [self.leftAnchor constraintEqualToAnchor:left constant:leftConstant];
        constraint.identifier = @"left";
        [constraints addObject:constraint];
    }
    if (bottom) {
        NSLayoutConstraint *constraint = [self.bottomAnchor constraintEqualToAnchor:bottom constant:-bottomConstant];
        constraint.identifier = @"bottom";
        [constraints addObject:constraint];
    }
    if (right) {
        NSLayoutConstraint *constraint = [self.rightAnchor constraintEqualToAnchor:right constant:-rightConstant];
        constraint.identifier = @"right";
        [constraints addObject:constraint];
    }
    if (widthConstant > 0) {
        NSLayoutConstraint *constraint = [self.widthAnchor constraintEqualToConstant:widthConstant];
        constraint.identifier = @"width";
        [constraints addObject:constraint];
    }
    if (heightConstant > 0) {
        NSLayoutConstraint *constraint = [self.heightAnchor constraintEqualToConstant:heightConstant];
        constraint.identifier = @"height";
        [constraints addObject:constraint];
    }
    [NSLayoutConstraint activateConstraints:constraints];
    return constraints;
}
@end
