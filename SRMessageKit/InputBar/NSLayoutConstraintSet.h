//
//  NSLayoutConstraintSet.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/30.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSLayoutConstraintSet : NSObject

@property (nonatomic, strong) NSLayoutConstraint *sr_top;
@property (nonatomic, strong) NSLayoutConstraint *sr_bottom;
@property (nonatomic, strong) NSLayoutConstraint *sr_left;
@property (nonatomic, strong) NSLayoutConstraint *sr_right;
@property (nonatomic, strong) NSLayoutConstraint *sr_centerX;
@property (nonatomic, strong) NSLayoutConstraint *sr_centerY;
@property (nonatomic, strong) NSLayoutConstraint *sr_width;
@property (nonatomic, strong) NSLayoutConstraint *sr_height;

- (instancetype)initWithTop:(NSLayoutConstraint *_Nullable)top
                     bottom:(NSLayoutConstraint *_Nullable)bottom
                       left:(NSLayoutConstraint *_Nullable)left
                      right:(NSLayoutConstraint *_Nullable)right
                    centerX:(NSLayoutConstraint *_Nullable)centerX
                    centerY:(NSLayoutConstraint *_Nullable)centerY
                      width:(NSLayoutConstraint *_Nullable)width
                     height:(NSLayoutConstraint *_Nullable)height;

- (NSLayoutConstraintSet *)acctivate;

- (NSLayoutConstraintSet *)deactivate;

@end

NS_ASSUME_NONNULL_END
