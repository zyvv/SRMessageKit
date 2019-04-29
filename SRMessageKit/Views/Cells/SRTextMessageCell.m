//
//  SRTextMessageCell.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/29.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRTextMessageCell.h"

@implementation SRTextMessageCell

- (SRMessageLabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[SRMessageLabel alloc] initWithFrame:CGRectZero];
    }
    return _messageLabel;
}

- (void)setDelegate:(id<SRMessageCellDelegate>)delegate {
    [super setDelegate:delegate];
//    self.messageLabel.delegate = delegate;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[SRMessagesCollectionViewLayoutAttributes class]]) {
        SRMessagesCollectionViewLayoutAttributes *attributes = (SRMessagesCollectionViewLayoutAttributes *)layoutAttributes;
        self.messageLabel.textInsets = attributes.messageLabelInsets;
        self.messageLabel.messageLabelFont = attributes.messageLabelFont;
        self.messageLabel.frame = self.messageContainerView.bounds;
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.messageLabel.attributedText = nil;
    self.messageLabel.text = nil;
}

- (void)setupSubViews {
    [super setupSubViews];
    [self.messageContainerView addSubview:self.messageLabel];
}

- (void)configureWithMessageType:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath messageCollectionView:(SRMessagesCollectionView *)messageCollectionView {
    [super configureWithMessageType:messageType atIndexPath:indexPath messageCollectionView:messageCollectionView];
    id displayDelegate = messageCollectionView.messageDisplayDelegate;
    NSArray *enabledDetectors = [displayDelegate enabledDetectoresForMessage:messageType atIndexPath:indexPath inMessageCollectionView:messageCollectionView];
    
    [self.messageLabel configure:^{
        self.messageLabel.enabledDetectors = enabledDetectors;
//        for (NSNumber *detector in enabledDetectors) {
//            NSDictionary *attributes = [displayDelegate detectorAttributesForDetector:[detector integerValue] messageType:messageType atIndexPath:indexPath];
//            self.messageLabel setattr
//        }
        switch (messageType.kind.kind) {
            case SRMessagesKindText:
            {
                UIColor *textColor = [displayDelegate textColorForMessage:messageType atIndexPath:indexPath inMessageCollectionView:messageCollectionView];
                self.messageLabel.text = messageType.kind.text;
                self.messageLabel.textColor = textColor;
                if (self.messageLabel.messageLabelFont) {
                    self.messageLabel.font = self.messageLabel.messageLabelFont;
                }
            }
                break;
            case SRMessagesKindEmoji:
            {
                UIColor *textColor = [displayDelegate textColorForMessage:messageType atIndexPath:indexPath inMessageCollectionView:messageCollectionView];
                self.messageLabel.text = messageType.kind.emojiString;
                self.messageLabel.textColor = textColor;
                if (self.messageLabel.messageLabelFont) {
                    self.messageLabel.font = self.messageLabel.messageLabelFont;
                }
            }
                break;
            case SRMessagesKindAttributedText:
                self.messageLabel.attributedText = messageType.kind.attributedText;
                break;
                
            default:
                break;
        }
    }];
    
}

@end
