//
//  SRMessagesCollectionViewLayoutAttributes.h
//  SRMessageKit
//
//  Created by vi~ on 2019/4/27.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRAvatarPosition.h"
#import "SRLabelAlignment.h"
#import "SRHorizontalEdgeInsets.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRMessagesCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes

@property (nonatomic, assign) CGSize avatarSize;
@property (nonatomic, strong) SRAvatarPosition *avatarPosition;

@property (nonatomic, assign) CGSize messageContainerSize;
@property (nonatomic, assign) UIEdgeInsets messageContainerPadding;
@property (nonatomic, strong) UIFont *messageLabelFont;
@property (nonatomic, assign) UIEdgeInsets messageLabelInsets;

@property (nonatomic, strong) SRLabelAlignment *cellTopLabelAlignment;
@property (nonatomic, assign) CGSize cellTopLabelSize;

@property (nonatomic, strong) SRLabelAlignment *messageTopLabelAlignment;
@property (nonatomic, assign) CGSize messageTopLabelSize;

@property (nonatomic, strong) SRLabelAlignment *messageBottomLabelAlignment;
@property (nonatomic, assign) CGSize messageBottomLabelSize;

@property (nonatomic, assign) CGSize accessoryViewSize;
@property (nonatomic, strong) SRHorizontalEdgeInsets *accessoryViewPadding;

- (BOOL)isEqual:(SRMessagesCollectionViewLayoutAttributes *)object;

@end

NS_ASSUME_NONNULL_END
