//
//  SRMessagesCollectionView.h
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/29.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRSender.h"
#import "SRMessageType.h"
#import "SRMessageStyle.h"
#import "SRMessageReusableView.h"
#import "SRAvatarView.h"
#import "SRDetectorType.h"
#import "SRCellSizeCalculator.h"
#import "SRMessageCollectionViewCell.h"

@class SRMessagesCollectionView;
@protocol SRMessagesDataSource <NSObject>

- (SRSender *)currentSender;

- (BOOL)isFromCurrentSender:(SRMessageType *)messageType;

- (SRMessageType *)messageForItemAtIndexPath:(NSIndexPath *)indexPath inMessagesCollectionView:(SRMessagesCollectionView *)messagesCollectionView;

- (NSInteger)numberOfSectionInMessagesCollectionView:(SRMessagesCollectionView *)messagesCollectionView;

- (NSInteger)numberOfItemsInSection:(NSInteger)section InMessagesCollectionView:(SRMessagesCollectionView *)messagesCollectionView;

- (NSAttributedString *)cellTopLabelAttributedTextForMessage:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath;

- (NSAttributedString *)messageTopLabelAttributedTextForMessage:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath;

- (NSAttributedString *)messageBottomLabelAttributedText:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath;

- (UICollectionViewCell *)customCellForMessage:(SRMessageType *)mssageType atIndexPath:(NSIndexPath *)indexPath inMessagesCollectionView:(SRMessagesCollectionView *)messagesCollectionView;

@end

@protocol SRMessagesDisplayDelegate <NSObject>

- (SRMessageStyle *)messageStyleForMessageType:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath inMessageCollectionView:(SRMessagesCollectionView *)messageCollectionView;

- (UIColor *)backgroundColorForMessage:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath inMessageCollectionView:(SRMessagesCollectionView *)messageCollectionView;

- (SRMessageReusableView *)messageHeaderViewForIndexPath:(NSIndexPath *)indexPath inMessageCollectionView:(SRMessagesCollectionView *)messageCollectionView;

- (SRMessageReusableView *)messageFooterViewForIndexPath:(NSIndexPath *)indexPath inMessageCollectionView:(SRMessagesCollectionView *)messageCollectionView;

- (void)configureAvatarView:(SRAvatarView *)avatarView forMessage:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath inMessageCollectionView:(SRMessagesCollectionView *)messageCollectionView;

- (void)configureAccessoryView:(UIView *)accessoryView forMessage:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath inMessageCollectionView:(SRMessagesCollectionView *)messageCollectionView;

- (UIColor *)textColorForMessage:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath inMessageCollectionView:(SRMessagesCollectionView *)messageCollectionView;

- (NSArray *)enabledDetectoresForMessage:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath inMessageCollectionView:(SRMessagesCollectionView *)messageCollectionView;

- (NSDictionary *)detectorAttributesForDetector:(SRDetectorType)detector messageType:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath;

- (void)configureMediaMessageImageView:(UIImageView *)imageView forMessageType:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath inMessageCollectionView:(SRMessagesCollectionView *)messageCollectionView;

@end

@protocol SRMessagesLayoutDelegate <NSObject>

- (CGSize)headerViewSizeForSection:(NSInteger)section inMessageCollectionView:(SRMessagesCollectionView *)messageCollectionView;

- (CGSize)footerViewSizeForSection:(NSInteger)section inMessageCollectionView:(SRMessagesCollectionView *)messageCollectionView;

- (CGFloat)cellTopLabelHeightForMessageType:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath inMessageCollectionView:(SRMessagesCollectionView *)messageCollectionView;

- (CGFloat)messageTopLabelHeight:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath inMessageCollectionView:(SRMessagesCollectionView *)messageCollectionView;

- (CGFloat)messageBottomLabelHeight:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath inMessageCollectionView:(SRMessagesCollectionView *)messageCollectionView;

- (SRCellSizeCalculator *)customCellSizeCalculator:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath inMessageCollectionView:(SRMessagesCollectionView *)messageCollectionView;

@end

static NSString *reuseViewID = @"SRMessageReusableView";
static NSString *textCellID = @"SRTextMessageCell";
static NSString *mediaCellID = @"SRMediaMessageCell";


@interface SRMessagesCollectionView : UICollectionView

@property (nonatomic, weak) id<SRMessagesDataSource> messageDataSource;
@property (nonatomic, weak) id<SRMessagesDisplayDelegate> messageDisplayDelegate;
@property (nonatomic, weak) id<SRMessagesLayoutDelegate> messageLayoutDelegate;
@property (nonatomic, weak) id<SRMessageCellDelegate> messageCellDelegate;

+ (instancetype)messagesCollectionView;

- (void)scrollToBottom:(BOOL)animated;

- (void)reloadDataAndKeepOffset;



@end
