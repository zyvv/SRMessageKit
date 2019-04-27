//
//  SRLabelAlignment.m
//  SRMessageKit
//
//  Created by vi~ on 2019/4/27.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRLabelAlignment.h"

@implementation SRLabelAlignment

- (instancetype)initWithTextAlignment:(NSTextAlignment)textAlignment textInsets:(UIEdgeInsets)textInsets {
    self = [super init];
    if (self) {
        self.textAlignment = textAlignment;
        self.textInsets = textInsets;
    }
    return self;
    
}

- (BOOL)isEqual:(SRLabelAlignment *)object {
    return self.textAlignment == object.textAlignment && self.textInsets.top == object.textInsets.top && self.textInsets.left == object.textInsets.left && self.textInsets.bottom == object.textInsets.bottom && self.textInsets.right == object.textInsets.bottom;
}

@end
