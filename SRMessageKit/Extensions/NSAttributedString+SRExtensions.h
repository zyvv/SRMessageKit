//
//  NSAttributedString+SRExtensions.h
//  SRMessageKit
//
//  Created by vi~ on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (SRExtensions)

- (CGFloat)widthConsideringHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
