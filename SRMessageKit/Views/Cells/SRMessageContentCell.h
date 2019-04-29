//
//  SRMessageContentCell.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessageCollectionViewCell.h"
#import "SRAvatarView.h"
#import "SRMessageContainerView.h"
#import "SRInsetLabel.h"
#import "SRMessagesCollectionView.h"
#import "SRMessageType.h"
#import "SRMessagesCollectionViewLayoutAttributes.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRMessageContentCell : SRMessageCollectionViewCell

@property (nonatomic, strong) SRAvatarView *avatarView;

@property (nonatomic, strong) SRMessageContainerView *messageContainerView;

@property (nonatomic, strong) SRInsetLabel *cellTopLabel;

@property (nonatomic, strong) SRInsetLabel *messageTopLabel;

@property (nonatomic, strong) SRInsetLabel *messageBottomLabel;

@property (nonatomic, strong) UIView *accessoryView;

@property (nonatomic, weak) id<SRMessageCellDelegate>delegate;

- (void)setupSubViews;

- (void)configureWithMessageType:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath messageCollectionView:(SRMessagesCollectionView *)messageCollectionView;

- (void)handleTapGesture:(UIGestureRecognizer *)gesture;

@end

NS_ASSUME_NONNULL_END
