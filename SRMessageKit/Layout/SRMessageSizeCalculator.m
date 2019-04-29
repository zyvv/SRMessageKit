//
//  SRMessageSizeCalculator.m
//  SRMessageKit
//
//  Created by vi~ on 2019/4/27.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessageSizeCalculator.h"
#import "SRMessagesCollectionViewLayoutAttributes.h"
#import "SRMessageType.h"
#import "SRMessagesCollectionViewFlowLayout.h"

@implementation SRMessageSizeCalculator

- (instancetype)initWithLayout:(SRMessagesCollectionViewFlowLayout *)layout {
    self = [super init];
    if (self) {
        self.layout = layout;
    }
    return self;
}

- (void)configure:(UICollectionViewLayoutAttributes *)attributes {
    if (![attributes isKindOfClass:[SRMessagesCollectionViewLayoutAttributes class]]) {
        return;
    }
    SRMessagesCollectionViewLayoutAttributes *messageAttributes = (SRMessagesCollectionViewLayoutAttributes *)attributes;
    id<SRMessagesDataSource> dataSource = self.messageLayout.messagesDataSource;
    NSIndexPath *indexPath = messageAttributes.indexPath;
    SRMessageType *message = [dataSource messageForItemAtIndexPath:indexPath inMessagesCollectionView:self.messageLayout.messagesCollectionView];
    
    messageAttributes.avatarSize = [self avatarSizeForMessage:message];
    messageAttributes.avatarPosition = [self avatarPositionForMessage:message];
    
//    messageAttributes.messageContainerPadding = [self messa]
    
}

#pragma mark - Avatar
- (SRAvatarPosition *)avatarPositionForMessage:(SRMessageType *)message {
    return nil;
}

- (CGSize)avatarSizeForMessage:(SRMessageType *)message {
    return CGSizeZero;
}

#pragma mark - Top cell Label

- (CGSize)cellTopLabelSizeForMessage:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath {
    id<SRMessagesLayoutDelegate> layoutDelegate = self.messageLayout.messagesLayoutDelegate;
    SRMessagesCollectionView *collectionView = self.messageLayout.messagesCollectionView;
    CGFloat height = [layoutDelegate cellTopLabelHeightForMessageType:messageType atIndexPath:indexPath inMessageCollectionView:collectionView];
    return CGSizeMake(self.messageLayout.itemWidth, height);
}

- (SRLabelAlignment *)cellTopLabelAlignmentForMessage:(SRMessageType *)message {
    id<SRMessagesDataSource> dataSource = self.messageLayout.messagesDataSource;
    BOOL isFromCurrentSender = [dataSource isFromCurrentSender:message];
    return isFromCurrentSender ? self.outgoingCellTopLabelAlignment : self.incomingCellTopLabelAlignment;
}

#pragma mark - Top message Label
- (CGSize)messageTopLabelSizeForMessage:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath {
    id<SRMessagesLayoutDelegate> layoutDelegate = self.messageLayout.messagesLayoutDelegate;
    SRMessagesCollectionView *collectionView = self.messageLayout.messagesCollectionView;
    CGFloat height = [layoutDelegate messageTopLabelHeight:messageType atIndexPath:indexPath inMessageCollectionView:collectionView];
    return CGSizeMake(self.messageLayout.itemWidth, height);
}

- (SRLabelAlignment *)messageTopLabelAlignmentForMessage:(SRMessageType *)message {
    id<SRMessagesDataSource> dataSource = self.messageLayout.messagesDataSource;
    BOOL isFromCurrentSender = [dataSource isFromCurrentSender:message];
    return isFromCurrentSender ? self.outgoingMessageTopLabelAlignment : self.incomingMessageTopLabelAlignment;
}

#pragma mark - Bottom Label
- (CGSize)messageBottomLabelSizeForMessage:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath {
    id<SRMessagesLayoutDelegate> layoutDelegate = self.messageLayout.messagesLayoutDelegate;
    SRMessagesCollectionView *collectionView = self.messageLayout.messagesCollectionView;
    CGFloat height = [layoutDelegate messageBottomLabelHeight:messageType atIndexPath:indexPath inMessageCollectionView:collectionView];
    return CGSizeMake(self.messageLayout.itemWidth, height);
}

- (SRLabelAlignment *)messageBottomLabelAlignmentForMessage:(SRMessageType *)message {
    id<SRMessagesDataSource> dataSource = self.messageLayout.messagesDataSource;
    BOOL isFromCurrentSender = [dataSource isFromCurrentSender:message];
    return isFromCurrentSender ? self.outgoingMessageBottomLabelAlignment : self.incomingMessageBottomLabelAlignment;
}

#pragma mark - Accessory View
- (CGSize)accessoryViewSizeForMessage:(SRMessageType *)message {
    id<SRMessagesDataSource> dataSource = self.messageLayout.messagesDataSource;
    BOOL isFromCurrentSender = [dataSource isFromCurrentSender:message];
    return isFromCurrentSender ? self.outgoingAccessoryViewSize : self.incomingAccessoryViewSize;
}

- (SRHorizontalEdgeInsets *)accessoryViewPaddingForMessage:(SRMessageType *)message {
    id<SRMessagesDataSource> dataSource = self.messageLayout.messagesDataSource;
    BOOL isFromCurrentSender = [dataSource isFromCurrentSender:message];
    return isFromCurrentSender ? self.outgoingAccessoryViewPadding : self.incomingAccessoryViewPadding;
}

#pragma mark - MessageContainer
- (UIEdgeInsets)messageContainerPaddingForMessage:(SRMessageType *)message {
    id<SRMessagesDataSource> dataSource = self.messageLayout.messagesDataSource;
    BOOL isFromCurrentSender = [dataSource isFromCurrentSender:message];
    return isFromCurrentSender ? self.outgoingMessagePadding : self.incomingMessagePadding;
}

- (CGSize)messageContainerSizeForMessage:(SRMessageType *)message {
    return CGSizeZero;
}

- (CGFloat)messageContainerMaxWidthForMessage:(SRMessageType *)message {
    CGFloat avatarWidth = [self avatarSizeForMessage:message].width;
    UIEdgeInsets messagePadding = [self messageContainerPaddingForMessage:message];
    CGFloat accessoryWidth = [self accessoryViewSizeForMessage:message].width;
    SRHorizontalEdgeInsets *accessoryPadding = [self accessoryViewPaddingForMessage:message];
    return self.messageLayout.itemWidth - avatarWidth - (messagePadding.left + messagePadding.right) - accessoryWidth - (accessoryPadding.left + accessoryPadding.right);
}


#pragma mark - Helpers
- (SRMessagesCollectionViewFlowLayout *)messageLayout {
    NSAssert([self.layout isKindOfClass:[SRMessagesCollectionViewFlowLayout class]], @"Layout object is missing or is not a SRMessagesCollectionViewFlowLayout");
    return (SRMessagesCollectionViewFlowLayout *)self.layout;
}

- (CGSize)labelSizeForAttributedText:(NSAttributedString *)attributedText consideringMaxWidth:(CGFloat)maxWidth {
    CGSize constraintBox = CGSizeMake(maxWidth, CGFLOAT_MAX);
    CGRect rect = [attributedText boundingRectWithSize:constraintBox options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return CGRectIntegral(rect).size;
}

@end
