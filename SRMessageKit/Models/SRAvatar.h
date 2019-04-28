//
//  SRAvatar.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRAvatar : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *initials;

- (instancetype)initWithImage:(UIImage *)image initials:(NSString *)initials;

@end

NS_ASSUME_NONNULL_END
