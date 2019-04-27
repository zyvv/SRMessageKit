//
//  SRHorizontalEdgeInsets.m
//  SRMessageKit
//
//  Created by vi~ on 2019/4/27.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRHorizontalEdgeInsets.h"

@implementation SRHorizontalEdgeInsets

- (instancetype)initWithLeft:(CGFloat)left right:(CGFloat)right {
    self = [super init];
    if (self) {
        self.left = left;
        self.right = right;
    }
    return self;
}

- (CGFloat)horizontal {
    return self.left + self.right;
}

+ (SRHorizontalEdgeInsets *)zero {
    return [[SRHorizontalEdgeInsets alloc] initWithLeft:0 right:0];
}

- (BOOL)isEqual:(SRHorizontalEdgeInsets *)object {
    return self.left = object.left && self.right == object.right;
}

@end
