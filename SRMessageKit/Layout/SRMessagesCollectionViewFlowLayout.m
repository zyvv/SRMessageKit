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

@implementation SRMessagesCollectionViewFlowLayout

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

- (SRCellSizeCalculator *)cellSizeCalculatorForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
