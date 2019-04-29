//
//  SRMessageSizeCalculator.h
//  SRMessageKit
//
//  Created by vi~ on 2019/4/27.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRCellSizeCalculator.h"
#import "SRAvatarPosition.h"
#import "SRLabelAlignment.h"
#import "SRHorizontalEdgeInsets.h"

NS_ASSUME_NONNULL_BEGIN

@class SRMessagesCollectionViewFlowLayout;
@class SRMessageType;

@interface SRMessageSizeCalculator : SRCellSizeCalculator

- (instancetype)initWithLayout:(SRMessagesCollectionViewFlowLayout *)layout;

@property (nonatomic, assign) CGSize incomingAvatarSize;
@property (nonatomic, assign) CGSize outgoingAvatarSize;

@property (nonatomic, strong) SRAvatarPosition *incomingAvatarPosition;
@property (nonatomic, strong) SRAvatarPosition *outgoingAvatarPosition;

@property (nonatomic, assign) UIEdgeInsets incomingMessagePadding;
@property (nonatomic, assign) UIEdgeInsets outgoingMessagePadding;

@property (nonatomic, strong) SRLabelAlignment *incomingCellTopLabelAlignment;
@property (nonatomic, strong) SRLabelAlignment *outgoingCellTopLabelAlignment;

@property (nonatomic, strong) SRLabelAlignment *incomingMessageTopLabelAlignment;
@property (nonatomic, strong) SRLabelAlignment *outgoingMessageTopLabelAlignment;

@property (nonatomic, strong) SRLabelAlignment *incomingMessageBottomLabelAlignment;
@property (nonatomic, strong) SRLabelAlignment *outgoingMessageBottomLabelAlignment;

@property (nonatomic, assign) CGSize incomingAccessoryViewSize;
@property (nonatomic, assign) CGSize outgoingAccessoryViewSize;

@property (nonatomic, strong) SRHorizontalEdgeInsets *incomingAccessoryViewPadding;
@property (nonatomic, strong) SRHorizontalEdgeInsets *outgoingAccessoryViewPadding;

@property (nonatomic, strong, readonly) SRMessagesCollectionViewFlowLayout *messageLayout;

- (CGSize)messageContainerSizeForMessage:(SRMessageType *)message;

- (CGFloat)messageContainerMaxWidthForMessage:(SRMessageType *)message;

- (CGSize)labelSizeForAttributedText:(NSAttributedString *)attributedText consideringMaxWidth:(CGFloat)maxWidth;

@end

NS_ASSUME_NONNULL_END
