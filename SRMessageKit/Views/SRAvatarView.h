//
//  SRAvatarView.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRAvatar.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRAvatarView : UIImageView

@property (nonatomic, copy) NSString *initials;
@property (nonatomic, strong) UIFont *placeholderFont;
@property (nonatomic, strong) UIColor *placeholderTextColor;
@property (nonatomic, assign) CGFloat fontMinimumScaleFactor;
@property (nonatomic, assign) BOOL adjustsFontSizeToFitWidth;
@property (nonatomic, strong) SRAvatar *avatar;
@property (nonatomic, assign) CGFloat corner;

@end

NS_ASSUME_NONNULL_END
