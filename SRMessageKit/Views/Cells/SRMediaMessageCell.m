//
//  SRMediaMessageCell.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/29.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMediaMessageCell.h"
#import <Masonry/Masonry.h>

@implementation SRMediaMessageCell

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (void)setupConstraints {
    [self.messageContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.messageContainerView);
    }];
}

- (void)setupSubViews {
    [super setupSubViews];
    [self.messageContainerView addSubview:self.imageView];
    [self setupConstraints];
}

- (void)configureWithMessageType:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath messageCollectionView:(SRMessagesCollectionView *)messageCollectionView {
    [super configureWithMessageType:messageType atIndexPath:indexPath messageCollectionView:messageCollectionView];
    id displayDelegate = messageCollectionView.messageDisplayDelegate;

    switch (messageType.kind.kind) {
        case SRMessagesKindPhoto:
            self.imageView.image = messageType.kind.photo.image;
            break;
        case SRMessagesKindVideo:
            self.imageView.image = messageType.kind.photo.image;
            break;
        default:
            break;
    }
    [displayDelegate configureMediaMessageImageView:self.imageView forMessageType:messageType atIndexPath:indexPath inMessageCollectionView:messageCollectionView];
}

@end
