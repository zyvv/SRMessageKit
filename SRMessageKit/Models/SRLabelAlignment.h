//
//  SRLabelAlignment.h
//  SRMessageKit
//
//  Created by vi~ on 2019/4/27.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRLabelAlignment : NSObject

@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) UIEdgeInsets textInsets;

- (instancetype)initWithTextAlignment:(NSTextAlignment)textAlignment textInsets:(UIEdgeInsets)textInsets;

- (BOOL)isEqual:(SRLabelAlignment *)object;

@end

NS_ASSUME_NONNULL_END
