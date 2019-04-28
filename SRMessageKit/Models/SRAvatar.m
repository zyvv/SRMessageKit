//
//  SRAvatar.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRAvatar.h"

@implementation SRAvatar

- (instancetype)initWithImage:(UIImage *)image initials:(NSString *)initials {
    self = [super init];
    if (self) {
        self.image = image;
        self.initials = initials ? initials : @"?";
    }
    return self;
}

@end
