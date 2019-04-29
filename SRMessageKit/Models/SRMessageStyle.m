//
//  SRMessageStyle.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessageStyle.h"
#import "NSBundle+SRExtensions.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface SRMessageStyle ()

@property (nonatomic, copy) NSString *imageCacheKey;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *imagePath;

@end

@implementation SRMessageStyle

NSString * tailCornerRawValue(SRTailCorner corner) {
    switch (corner) {
        case SRTailCornerBottomRight:
            return @"bottomRight";
            break;
        case SRTailCornerBottomLeft:
            return @"bottomLeft";
            break;
        case SRTailCornerTopLeft:
            return @"topLeft";
            break;
        case SRTailCornerTopRigth:
            return @"topRight";
            break;
    }
}

NSString * imageNameSuffix(SRTailStyle style) {
    switch (style) {
        case SRTailStyleCurved:
            return @"_tail_v2";
            break;
        case SRTailStylePointedEdge:
            return @"_tail_v1";
            break;
    }
}

UIImageOrientation imageOrientation(SRTailCorner corner) {
    switch (corner) {
        case SRTailCornerBottomRight:
            return UIImageOrientationUp;
            break;
        case SRTailCornerBottomLeft:
            return UIImageOrientationUpMirrored;
            break;
        case SRTailCornerTopLeft:
            return UIImageOrientationDown;
            break;
        case SRTailCornerTopRigth:
            return UIImageOrientationDownMirrored;
            break;
    }
}

- (instancetype)initWithStyle:(SRMessagesStyle)style {
    self = [super init];
    if (self) {
        self.style = style;
    }
    return self;
}

- (UIImage *)image {
    if (!self.imageCacheKey || !self.imagePath) {
        return nil;
    }
    NSCache *cache = [SRMessageStyle bubbleImageCache];
    UIImage *cachedImage = [cache objectForKey:self.imageCacheKey];
    if (cachedImage) {
        return cachedImage;
    }
    UIImage *image = [UIImage imageWithContentsOfFile:self.imagePath];
    if (!image) {
        return nil;
    }
    switch (self.style) {
        case SRMessagesStyleNone:
            return nil;
            break;
        case SRMessagesStyleCustom:
            return nil;
            break;
        case SRMessagesStyleBubble:
            break;
        case SRMessagesStyleBubbleOutline:
            break;
        case SRMessagesStyleBubbleTail:
            image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:imageOrientation(self.bubbleTailCorner)];
            break;
        case SRMessagesStyleBubbleTailOutline:
            image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:imageOrientation(self.bubbleTailOutlineCorner)];
            break;
        default:
            break;
    }
    UIImage *stretchedImage = [self stretchImage:image];
    [cache setObject:stretchedImage forKey:self.imageCacheKey];
    return stretchedImage;
}

+ (NSCache *)bubbleImageCache {
    NSCache *cache = [[NSCache alloc] init];
    cache.name = @"com.srmessagekit.SRMessageKit.bubbleImageCache";
    return cache;
}

- (NSString *)imageCacheKey {
    if (!self.imageName) {
        return nil;
    }
    switch (self.style) {
        case SRMessagesStyleBubble:
            return self.imageName;
            break;
        case SRMessagesStyleBubbleOutline:
            return self.imageName;
            break;
        case SRMessagesStyleBubbleTail:
            return [NSString stringWithFormat:@"%@_%@", self.imageName, tailCornerRawValue(self.bubbleTailCorner)];
            break;
        case SRMessagesStyleBubbleTailOutline:
            return [NSString stringWithFormat:@"%@_%@", self.imageName, tailCornerRawValue(self.bubbleTailOutlineCorner)];
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)imageName {
    switch (self.style) {
        case SRMessagesStyleBubble:
            return @"bubble_full";
            break;
        case SRMessagesStyleBubbleOutline:
            return @"bubble_outlined";
            break;
        case SRMessagesStyleBubbleTail:
            return [NSString stringWithFormat:@"%@%@", @"bubble_full", imageNameSuffix(self.bubbleTailStyle)];
            break;
        case SRMessagesStyleBubbleTailOutline:
            return [NSString stringWithFormat:@"%@%@", @"bubble_outlined", imageNameSuffix(self.bubbleTailOutlineStyle)];
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)imagePath {
    if (!self.imageName) {
        return nil;
    }
    NSBundle *assetBundle = [NSBundle messageKietAssetBundle];
    return [assetBundle pathForResource:self.imageName ofType:@"png" inDirectory:@"Images"];
}

- (UIImage *)stretchImage:(UIImage *)image {
    CGPoint center = CGPointMake(image.size.width / 2.0, image.size.height / 2.0);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(center.y, center.x, center.y, center.x);
    return [image resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
}

@end
