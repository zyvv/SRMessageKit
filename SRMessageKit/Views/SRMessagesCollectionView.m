//
//  SRMessagesCollectionView.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/29.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessagesCollectionView.h"
#import "SRMessageContentCell.h"
#import "SRTextMessageCell.h"
#import "SRMediaMessageCell.h"

@interface SRMessagesCollectionView ()

@property (nonatomic, strong) NSIndexPath *indexPathForLastItem;

@end

static NSString *reuseViewID = @"SRMessageReusableView";
static NSString *textCellID = @"SRTextMessageCell";
static NSString *mediaCellID = @"SRMediaMessageCell";

@implementation SRMessagesCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self registerReuseableViews];
    }
    return self;
}

- (NSIndexPath *)indexPathForLastItem {
    NSInteger lastSection = self.numberOfSections - 1;
    if (lastSection >= 0 && [self numberOfItemsInSection:lastSection] > 0) {
        return [NSIndexPath indexPathForItem:[self numberOfItemsInSection:lastSection]-1 inSection:lastSection];
    }
    return nil;
}

- (void)registerReuseableViews {
    [self registerClass:[SRTextMessageCell class] forCellWithReuseIdentifier:textCellID];
    [self registerClass:[SRMediaMessageCell class] forCellWithReuseIdentifier:mediaCellID];
    [self registerClass:[SRMessageReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseViewID];
    [self registerClass:[SRMessageReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseViewID];
}

- (void)setupGestureRecongnizers {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.delaysTouchesBegan = YES;
    [self addGestureRecognizer:tapGesture];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tap {
    if (tap.state == UIGestureRecognizerStateEnded) {
        return;
    }
    CGPoint touchLocation = [tap locationInView:self];
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:touchLocation];
    if (!indexPath) {
        return;
    }
    SRMessageContentCell *cell = (SRMessageContentCell *)[self cellForItemAtIndexPath:indexPath];
    [cell handleTapGesture:tap];
}

- (void)scrollToBottom:(BOOL)animated {
    CGFloat collectionViewContentHeight = self.collectionViewLayout.collectionViewContentSize.height;
    
    [self performBatchUpdates:^{
        [self scrollRectToVisible:CGRectMake(0, collectionViewContentHeight - 1.0, 1.0, 1.0) animated:animated];
    } completion:nil];
    
}

- (void)reloadDataAndKeepOffset {
    [self setContentOffset:self.contentOffset animated:NO];
    
    CGSize beforeContentSize = self.contentSize;
    [self reloadData];
    [self layoutIfNeeded];
    CGSize afterContentSize = self.contentSize;
    
    CGPoint newOffset = CGPointMake(self.contentOffset.x + (afterContentSize.width - beforeContentSize.width), self.contentOffset.y + (afterContentSize.height - beforeContentSize.height));
    [self setContentOffset:newOffset animated:NO];
}

@end
