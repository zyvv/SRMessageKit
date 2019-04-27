//
//  SRAvatarPosition.m
//  SRMessageKit
//
//  Created by vi~ on 2019/4/27.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRAvatarPosition.h"

@implementation SRAvatarPosition

- (instancetype)initWithHorizontal:(SRAvatarPositionHorizontal)horizontal vertical:(SRAvatarPositionVertical)vertical {
    self = [super init];
    if (self) {
        self.horizontal = horizontal;
        self.vertical = vertical;
    }
    return self;
}

- (instancetype)initWithVertical:(SRAvatarPositionVertical)vertical {
    return [self initWithHorizontal:SRAvatarPositionHorizontalNatural vertical:vertical];
}

- (BOOL)isEqual:(SRAvatarPosition *)object {
    return self.vertical == object.vertical && self.horizontal == object.horizontal;
}

@end
