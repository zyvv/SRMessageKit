//
//  NSAttributedString+SRExtensions.m
//  SRMessageKit
//
//  Created by vi~ on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "NSAttributedString+SRExtensions.h"

@implementation NSAttributedString (SRExtensions)

- (CGFloat)widthConsideringHeight:(CGFloat)height {
    CGSize constraintBox = CGSizeMake(CGFLOAT_MAX, height);
    CGRect rect = [self boundingRectWithSize:constraintBox options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return rect.size.width;
}

@end
