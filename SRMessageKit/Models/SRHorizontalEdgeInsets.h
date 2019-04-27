//
//  SRHorizontalEdgeInsets.h
//  SRMessageKit
//
//  Created by vi~ on 2019/4/27.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRHorizontalEdgeInsets : NSObject

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign, readonly) CGFloat horizontal;

- (instancetype)initWithLeft:(CGFloat)left right:(CGFloat)right;

+ (SRHorizontalEdgeInsets *)zero;

- (BOOL)isEqual:(SRHorizontalEdgeInsets *)object;

@end

NS_ASSUME_NONNULL_END
