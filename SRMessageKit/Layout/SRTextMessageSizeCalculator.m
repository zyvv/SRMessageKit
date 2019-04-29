//
//  SRTextMessageSizeCalculator.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/29.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRTextMessageSizeCalculator.h"
#import "SRMessagesCollectionViewLayoutAttributes.h"
#import "SRMessagesCollectionViewFlowLayout.h"

@implementation SRTextMessageSizeCalculator

- (UIEdgeInsets)incomingMessageLabelInsets {
    return UIEdgeInsetsMake(7, 18, 7, 14);
}

- (UIEdgeInsets)outgoingMessageLabelInsets {
    return UIEdgeInsetsMake(7, 14, 7, 18);
}

- (UIFont *)messageLabelFont {
    if (!_messageLabelFont) {
        _messageLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    }
    return _messageLabelFont;
}

- (UIEdgeInsets)messageLabelInsetsForMessage:(SRMessageType *)messageType {
    id<SRMessagesDataSource> dataSource = self.messageLayout.messagesDataSource;
    BOOL isFromCurrentSender = [dataSource isFromCurrentSender:messageType];
    return isFromCurrentSender ? self.outgoingMessageLabelInsets : self.incomingMessageLabelInsets;
}

- (CGFloat)messageContainerMaxWidthForMessage:(SRMessageType *)message {
    CGFloat maxWidth = [super messageContainerMaxWidthForMessage:message];
    UIEdgeInsets textInsets = [self messageLabelInsetsForMessage:message];
    return maxWidth - (textInsets.left + textInsets.right);
}

- (CGSize)messageContainerSizeForMessage:(SRMessageType *)message {
    CGFloat maxWidth = [self messageContainerMaxWidthForMessage:message];
    CGSize messageContainerSize;
    NSAttributedString *attributedText;
    switch (message.kind.kind) {
        case SRMessagesKindAttributedText:
            attributedText = message.kind.attributedText;
            break;
        case SRMessagesKindText:
            attributedText = [[NSAttributedString alloc] initWithString:message.kind.text attributes:@{NSFontAttributeName: self.messageLabelFont}];;
            break;
        case SRMessagesKindEmoji:
            attributedText = [[NSAttributedString alloc] initWithString:message.kind.emojiString attributes:@{NSFontAttributeName: self.messageLabelFont}];;
            break;
        default:
            break;
    }
    messageContainerSize = [self labelSizeForAttributedText:attributedText consideringMaxWidth:maxWidth];
    
    UIEdgeInsets messageInsets = [self messageLabelInsetsForMessage:message];
    messageContainerSize.width += (messageInsets.left + messageInsets.right);
    messageContainerSize.height += (messageInsets.top + messageInsets.bottom);
    return messageContainerSize;
}

- (void)configure:(UICollectionViewLayoutAttributes *)attributes {
    [super configure:attributes];
    if (![attributes isKindOfClass:[SRMessagesCollectionViewLayoutAttributes class]]) {
        return;
    }
    SRMessagesCollectionViewLayoutAttributes *messageAttributes = (SRMessagesCollectionViewLayoutAttributes *)attributes;
    
    id<SRMessagesDataSource> dataSource = self.messageLayout.messagesDataSource;
    NSIndexPath *indexPath = attributes.indexPath;
    SRMessageType *message = [dataSource messageForItemAtIndexPath:indexPath inMessagesCollectionView:self.messageLayout.messagesCollectionView];
    
    
    messageAttributes.messageLabelInsets = [self messageLabelInsetsForMessage:message];
    messageAttributes.messageLabelFont = self.messageLabelFont;
    
    switch (message.kind.kind) {
        case SRMessagesKindAttributedText:
        {
            if (message.kind.attributedText.string.length > 0) {
                UIFont *font = [message.kind.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:nil];
                if (font) {
                    messageAttributes.messageLabelFont = font;
                }
            }
        }
            break;
            
        default:
            break;
    }
}

@end
