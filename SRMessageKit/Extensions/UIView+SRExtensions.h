//
//  UIView+SRExtensions.h
//  SRMessageKit
//
//  Created by vi~ on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SRExtensions)

- (void)fillSuperView;

- (NSArray *)addConstraints:(NSLayoutYAxisAnchor *_Nullable)top
                       left:(NSLayoutXAxisAnchor *_Nullable)left
                     bottom:(NSLayoutYAxisAnchor *_Nullable)bottom
                      right:(NSLayoutXAxisAnchor *_Nullable)right
                topConstant:(CGFloat)topConstant
               leftConstant:(CGFloat)leftConstant
             bottomConstant:(CGFloat)bottomConstant
              rightConstant:(CGFloat)rightConstant
              widthConstant:(CGFloat)widthConstant
             heightConstant:(CGFloat)heightConstant;

@end

NS_ASSUME_NONNULL_END
