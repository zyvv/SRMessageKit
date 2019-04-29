//
//  SRMessagesCollectionViewFlowLayout.m
//  SRMessageKit
//
//  Created by vi~ on 2019/4/27.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessagesCollectionViewFlowLayout.h"
#import "SRMessagesCollectionViewLayoutAttributes.h"
#import "SRCellSizeCalculator.h"
#import "SRTextMessageSizeCalculator.h"
#import "SRMediaMessageSizeCalculator.h"

@implementation SRMessagesCollectionViewFlowLayout

- (SRMessagesCollectionView *)messagesCollectionView {
    return (SRMessagesCollectionView *)self.collectionView;
}

- (id<SRMessagesDataSource>)messagesDataSource  {
    return self.messagesCollectionView.messageDataSource;
}

- (id<SRMessagesLayoutDelegate>)messagesLayoutDelegate {
    return self.messagesCollectionView.messageLayoutDelegate;
}

- (CGFloat)itemWidth {
    return self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right;
}

#pragma mark - Initializers
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
        [self setupObserver];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Methods
- (void)setupView {
    self.sectionInset = UIEdgeInsetsMake(4, 8, 4, 8);
}

- (void)setupObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

#pragma mark - Attributes
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
    for (SRMessagesCollectionViewLayoutAttributes *attributes in attributesArray) {
        if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
            SRCellSizeCalculator *cellSizeCalculator = [self cellSizeCalculatorForItemAtIndexPath:attributes.indexPath];
            [cellSizeCalculator configure:attributes];
        }
    }
    return attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
        SRCellSizeCalculator *cellSizeCalculator = [self cellSizeCalculatorForItemAtIndexPath:attributes.indexPath];
        [cellSizeCalculator configure:attributes];
    }
    return attributes;
}

#pragma mark - Layout Invalidation
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return self.collectionView.bounds.size.width != newBounds.size.width;
}

- (UICollectionViewLayoutInvalidationContext *)invalidationContextForBoundsChange:(CGRect)newBounds {
    UICollectionViewLayoutInvalidationContext *context = [super invalidationContextForBoundsChange:newBounds];
    if (![context isKindOfClass:[UICollectionViewFlowLayoutInvalidationContext class]]) {
        return context;
    }
    UICollectionViewFlowLayoutInvalidationContext *flowLayoutContext = (UICollectionViewFlowLayoutInvalidationContext *)context;
    flowLayoutContext.invalidateFlowLayoutDelegateMetrics = [self shouldInvalidateLayoutForBoundsChange:newBounds];
    return flowLayoutContext;
}

- (void)handleOrientationChange:(NSNotification *)notification {
    [self invalidateLayout];
}

#pragma mark - Cell Sizing

- (SRTextMessageSizeCalculator *)textMessageSizeCalculator {
    if (!_textMessageSizeCalculator) {
        _textMessageSizeCalculator = [[SRTextMessageSizeCalculator alloc] initWithLayout:self];
    }
    return _textMessageSizeCalculator;
}

- (SRTextMessageSizeCalculator *)attributedTextMessageSizeCalculator {
    if (!_attributedTextMessageSizeCalculator) {
        _attributedTextMessageSizeCalculator = [[SRTextMessageSizeCalculator alloc] initWithLayout:self];
    }
    return _attributedTextMessageSizeCalculator;
}

- (SRTextMessageSizeCalculator *)emojiMessageSizeCalculator {
    if (!_emojiMessageSizeCalculator) {
        _emojiMessageSizeCalculator = [[SRTextMessageSizeCalculator alloc] initWithLayout:self];
        _emojiMessageSizeCalculator.messageLabelFont = [UIFont systemFontOfSize:_emojiMessageSizeCalculator.messageLabelFont.pointSize * 2];
    }
    return _emojiMessageSizeCalculator;
}

- (SRCellSizeCalculator *)cellSizeCalculatorForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
