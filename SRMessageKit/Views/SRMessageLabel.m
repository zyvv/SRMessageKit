//
//  SRMessageLabel.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessageLabel.h"
#import "NSArray+SRExtensions.h"

@interface SRMessageLabel ()

@property (nonatomic, strong) NSLayoutManager *layoutManager;
@property (nonatomic, strong) NSTextContainer *textContainer;
@property (nonatomic, strong) NSTextStorage *textStorage;
@property (nonatomic, strong) NSMutableDictionary *rangesForDetectors;
@property (nonatomic, assign) BOOL isConfiguring;
@property (nonatomic, strong) UIFont *messageLabelFont;
@property (nonatomic, assign) BOOL attributesNeedUpdate;

@end

@implementation SRMessageLabel

- (NSLayoutManager *)layoutManager {
    if (!_layoutManager) {
        _layoutManager = [[NSLayoutManager alloc] init];
        [_layoutManager addTextContainer:self.textContainer];
    }
    return _layoutManager;
}

- (NSTextContainer *)textContainer {
    if (!_textContainer) {
        _textContainer = [[NSTextContainer alloc] init];
        _textContainer.lineFragmentPadding = 0;
        _textContainer.maximumNumberOfLines = self.numberOfLines;
        _textContainer.lineBreakMode = self.lineBreakMode;
        _textContainer.size = self.bounds.size;
    }
    return _textContainer;
}

- (NSTextStorage *)textStorage {
    if (!_textStorage) {
        _textStorage = [[NSTextStorage alloc] init];
        [_textStorage addLayoutManager:self.layoutManager];
    }
    return _textStorage;
}

- (void)setEnabledDetectors:(NSArray *)enabledDetectors {
    if (_enabledDetectors != enabledDetectors) {
        _enabledDetectors = enabledDetectors;
    }
    [self setTextStorage:self.attributedText shouldParse:YES];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setTextStorage:self.attributedText shouldParse:YES];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setTextStorage:self.attributedText shouldParse:YES];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setTextStorage:self.attributedText shouldParse:NO];
}

- (void)setTextColor:(UIColor *)textColor {
    [super setTextColor:textColor];
    [self setTextStorage:self.attributedText shouldParse:NO];
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode {
    [super setLineBreakMode:lineBreakMode];
    self.textContainer.lineBreakMode = lineBreakMode;
    if (!self.isConfiguring) {
        [self setNeedsDisplay];
    }
}

- (void)setNumberOfLines:(NSInteger)numberOfLines {
    [super setNumberOfLines:numberOfLines];
    self.textContainer.maximumNumberOfLines = numberOfLines;
    if (!self.isConfiguring) {
        [self setNeedsDisplay];
    }
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    [self setTextStorage:self.attributedText shouldParse:NO];
}

- (void)setTextInsets:(UIEdgeInsets)textInsets {
    _textInsets = textInsets;
    if (!self.isConfiguring) {
        [self setNeedsDisplay];
    }
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width += (self.textInsets.left + self.textInsets.right);
    size.width += (self.textInsets.top + self.textInsets.bottom);
    return size;
}

- (NSMutableDictionary *)rangesForDetectors {
    if (!_rangesForDetectors) {
        _rangesForDetectors = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _rangesForDetectors;
}

+ (NSDictionary *)defaultAttributes {
    return @{NSForegroundColorAttributeName: [UIColor darkTextColor],
             NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
             NSUnderlineColorAttributeName: [UIColor darkTextColor]
             };
}

#pragma mark - Initializers
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark - Open Methods
- (void)drawTextInRect:(CGRect)rect {
    CGRect insetRect = UIEdgeInsetsInsetRect(rect, self.textInsets);
    self.textContainer.size = CGSizeMake(CGRectGetWidth(insetRect), CGRectGetHeight(insetRect));
    CGPoint origin = insetRect.origin;
    NSRange range = [self.layoutManager glyphRangeForTextContainer:self.textContainer
                     ];
    [self.layoutManager drawBackgroundForGlyphRange:range atPoint:origin];
    [self.layoutManager drawGlyphsForGlyphRange:range atPoint:origin];
}

#pragma mark - Public Methods
- (void)configure:(void(^)())block {
    self.isConfiguring = YES;
    block();
}

#pragma mark - Private Methods
- (void)setupView {
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByWordWrapping;
}

- (void)setTextStorage:(NSAttributedString *)newText shouldParse:(BOOL)shouldParse {
    if (!newText || newText.length == 0) {
        [self.textStorage setAttributedString:[[NSAttributedString alloc] init]];
        [self setNeedsDisplay];
        return;
    }
    NSParagraphStyle *style = [self paragraphStyleForText:newText];
    NSRange range = NSMakeRange(0, newText.length);
    
    NSMutableAttributedString *mutableText = [[NSMutableAttributedString alloc] initWithAttributedString:newText];
    [mutableText addAttribute:NSParagraphStyleAttributeName value:style range:range];
    
    if (shouldParse) {
        [self.rangesForDetectors removeAllObjects];
    }
}

- (NSParagraphStyle *)paragraphStyleForText:(NSAttributedString *)text {
    if (!text || text.length == 0) {
        return [[NSParagraphStyle alloc] init];
    }
    NSRange range = NSMakeRange(0, text.length);
    NSMutableParagraphStyle *existingStyle = [text attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:&range];
    existingStyle = existingStyle ? existingStyle : [[NSMutableParagraphStyle alloc] init];
    existingStyle.lineBreakMode = self.lineBreakMode;
    existingStyle.alignment = self.textAlignment;
    return existingStyle;
}

#pragma mark - Parsing Text
- (NSArray *)parseText:(NSAttributedString *)text {
//    if (self.enabledDetectors.count == 0) {
//        return @[];
//    }
//    NSTextCheckingTypes types = [[self.enabledDetectors reduce:@(0) block:^id(NSNumber *obj1, NSNumber *obj2) {
//        NSTextCheckingType type1 = obj1.integerValue;
//        NSTextCheckingType type2 = obj2.integerValue;
//        return @(type1 | type2);
//    }] integerValue];
//    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:types error:nil];
//    NSRange range = NSMakeRange(0, text.length);
//    NSArray *matches = [detector matchesInString:text.string options:NSMatchingReportProgress range:range];
//    if (!matches) {
//        matches = @[];
//    }
//    if (self.enabledDetectors containsObject:@()) {
//        <#statements#>
//    }
    return @[];
}

- (void)setRnagesForDetectorsInCheckingResults:(NSArray *)checkingResults {
    
}

#pragma mark - Gesture Handling
- (int)stringIndexAtLocation:(CGPoint)location {
    if (self.textStorage.length == 0) {
        return 0;
    }
    location.x -= self.textInsets.left;
    location.y -= self.textInsets.top;
    
    NSUInteger index = [self.layoutManager glyphIndexForPoint:location inTextContainer:self.textContainer];
    CGRect lineRect = [self.layoutManager lineFragmentUsedRectForGlyphAtIndex:index effectiveRange:nil];
    int characterIndex = 0;
    if (CGRectContainsPoint(lineRect, location)) {
        characterIndex = (int)[self.layoutManager characterIndexForGlyphAtIndex:index];
    }
    return characterIndex;
}

- (BOOL)handleGesture:(CGPoint)touchLocation {
    int index = [self stringIndexAtLocation:touchLocation];
    if (index <= 0) {
        return NO;
    }
    return NO;
}

@end
