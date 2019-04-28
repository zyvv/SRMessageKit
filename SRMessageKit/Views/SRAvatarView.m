//
//  SRAvatarView.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRAvatarView.h"
#import "NSAttributedString+SRExtensions.h"

#define DEGREES_TO_RADIANS(degrees)((M_PI * degrees)/180)

@interface SRAvatarView ()

@property (nonatomic, assign) CGFloat minimumFontSize;
@property (nonatomic, assign) CGFloat radius;

@end

@implementation SRAvatarView

@synthesize placeholderFont = _placeholderFont;
@synthesize placeholderTextColor = _placeholderTextColor;

- (void)setInitials:(NSString *)initials {
    if (_initials != initials) {
        _initials = initials;
    }
    [self setImageFromInitials:_initials];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    if (_placeholderFont != placeholderFont) {
        _placeholderFont = placeholderFont;
    }
    [self setImageFromInitials:self.initials];
}

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    if (_placeholderTextColor != placeholderTextColor) {
        _placeholderTextColor = placeholderTextColor;
    }
    [self setImageFromInitials:self.initials];
}

- (UIFont *)placeholderFont {
    if (!_placeholderFont) {
        _placeholderFont = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    }
    return _placeholderFont;
}

- (UIColor *)placeholderTextColor {
    if (_placeholderTextColor) {
        _placeholderTextColor = [UIColor whiteColor];
    }
    return _placeholderTextColor;
}

- (CGFloat)minimumFontSize {
    return self.placeholderFont.pointSize * self.fontMinimumScaleFactor;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setCorner:self.radius];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    [self setCorner:self.radius];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.fontMinimumScaleFactor = 0.5f;
        self.adjustsFontSizeToFitWidth = YES;
        [self prepareView];
    }
    return self;
}

- (void)setImageFromInitials:(NSString *)initials {
    self.image = [self getImageFromInitials:initials];
}

- (UIImage *)getImageFromInitials:(NSString *)initials {
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    if (width == 0 || height == 0) {
        return [[UIImage alloc] init];
    }
    UIFont *font = self.placeholderFont;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect textRect = [self calculateTextRectWithOuterViewWidth:width outerViewHeight:height];
    NSAttributedString *initialsText = [[NSAttributedString alloc] initWithString:initials attributes:@{NSFontAttributeName: font}];
    if (self.adjustsFontSizeToFitWidth && [initialsText widthConsideringHeight:CGRectGetHeight(textRect)] > CGRectGetWidth(textRect)) {
        CGFloat newFontSize = [self calculateFontSizeWithText:initials font:font width:CGRectGetWidth(textRect) height:CGRectGetHeight(textRect)];
        font = [self.placeholderFont fontWithSize:newFontSize];
    }
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle alloc] init];
    textStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *textFontAttributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName: _placeholderTextColor, NSParagraphStyleAttributeName: textStyle};
    CGFloat textTextHeight = [initials boundingRectWithSize:CGSizeMake(CGRectGetWidth(textRect), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:textFontAttributes context:nil].size.height;
    CGContextSaveGState(context);
    CGContextClipToRect(context, textRect);
    [initials drawInRect:CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (CGRectGetHeight(textRect) - textTextHeight) / 2.0, CGRectGetWidth(textRect), textTextHeight) withAttributes:textFontAttributes];
    CGContextRestoreGState(context);
    UIImage *renderedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (!renderedImage) {
        return [UIImage new];
    }
    return renderedImage;
}

- (CGFloat)calculateFontSizeWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width height:(CGFloat)height {
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: font}];
    if ([attributedText widthConsideringHeight:height] > width) {
        UIFont *newFont = [font fontWithSize:font.pointSize - 1];
        if (newFont.pointSize > self.minimumFontSize) {
            return font.pointSize;
        } else {
            return [self calculateFontSizeWithText:text font:newFont width:width height:height
                    ];        }
    }
    return font.pointSize;
}

- (CGRect)calculateTextRectWithOuterViewWidth:(CGFloat)outerViewWidth outerViewHeight:(CGFloat)outerViewHeight {
    if (outerViewWidth <= 0) {
        return CGRectZero;
    }
    CGFloat shortEdge = MIN(outerViewWidth, outerViewHeight);
    CGFloat w = shortEdge * sin(DEGREES_TO_RADIANS(45.0)) * 2;
    CGFloat h = shortEdge * cos(DEGREES_TO_RADIANS(45.0)) * 2;
    CGFloat startX = (outerViewWidth - w)/2.0;
    CGFloat startY = (outerViewHeight - h)/2.0;
    return CGRectMake(startX+2, startY, w-4, h);
}

- (void)prepareView {
    self.backgroundColor = [UIColor grayColor];
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    
}

- (void)setAvatar:(SRAvatar *)avatar {
    if (_avatar != avatar) {
        _avatar = avatar;
    }
    if (_avatar.image) {
        self.image = _avatar.image;
    } else {
        self.initials = avatar.initials;
    }
}

- (void)setCorner:(CGFloat)corner {
    _corner = corner;
    if (_corner <= 0) {
        CGFloat cornerRadius = MIN(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        self.layer.cornerRadius = cornerRadius / 2.0;
        return;
    }
    self.radius = _corner;
    self.layer.cornerRadius = self.radius;
}


@end
