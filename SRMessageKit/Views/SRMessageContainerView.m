//
//  SRMessageContainerView.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessageContainerView.h"

@interface SRMessageContainerView ()

@property (nonatomic, strong) UIImageView *imageMask;

@end

@implementation SRMessageContainerView

@synthesize style = _style;

- (UIImageView *)imageMask {
    return [UIImageView new];
}

- (void)setStyle:(SRMessageStyle *)style {
    if (_style != style) {
        _style = style;
    }
    [self appleMessageStyle];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self sizeMaskToView];
}

- (SRMessageStyle *)style {
    if (!_style) {
        _style = [[SRMessageStyle alloc] initWithStyle:SRMessagesStyleNone];
    }
    return _style;
}

- (void)sizeMaskToView {
    switch (self.style.style) {
        case SRMessagesStyleNone:
        case SRMessagesStyleCustom:
            break;
        case SRMessagesStyleBubble:
        case SRMessagesStyleBubbleTail:
        case SRMessagesStyleBubbleOutline:
        case SRMessagesStyleBubbleTailOutline:
            self.imageMask.frame = self.bounds;
            break;
        default:
            break;
    }
}

- (void)appleMessageStyle {
    switch (self.style.style) {
        case SRMessagesStyleBubble:
        case SRMessagesStyleBubbleTail:
        {
            self.imageMask.image = self.style.image;
            [self sizeMaskToView];
            self.maskView = self.imageMask;
            self.image = nil;
        }
            break;
        case SRMessagesStyleBubbleOutline:
        {
            SRMessageStyle *bubbleStyle = [[SRMessageStyle alloc] initWithStyle:SRMessagesStyleBubble];
            self.imageMask.image = bubbleStyle.image;
            [self sizeMaskToView];
            self.maskView = self.imageMask;
            self.image = [self.style.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            self.tintColor = bubbleStyle.bubbleOutlineColor;
        }
        case SRMessagesStyleBubbleTailOutline:
        {
            SRMessageStyle *bubbleStyle = [[SRMessageStyle alloc] initWithStyle:SRMessagesStyleBubbleTail];
            bubbleStyle.bubbleTailStyle = self.style.bubbleTailOutlineStyle;
            bubbleStyle.bubbleTailCorner = self.style.bubbleTailOutlineCorner;
            self.imageMask.image = bubbleStyle.image;
            [self sizeMaskToView];
            self.maskView = self.imageMask;
            self.image = [self.style.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            self.tintColor = bubbleStyle.bubbleTailOutlineColor;
        }
        case SRMessagesStyleNone:
        {
            self.maskView = nil;
            self.image = nil;
            self.tintColor = nil;
        }
        case SRMessagesStyleCustom:
        {
            self.maskView = nil;
            self.image = nil;
            self.tintColor = nil;
            self.style.custom(self);
        }

            break;
        default:
            break;
    }
}

@end
