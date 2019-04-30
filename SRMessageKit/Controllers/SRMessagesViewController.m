//
//  SRMessagesViewController.m
//  SRMessageKit
//
//  Created by vi~ on 2019/4/28.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRMessagesViewController.h"
#import "SRMessagesViewController+Menu.h"
#import "SRMessagesViewController+Keyboard.h"
#import "SRTextMessageCell.h"
#import "SRMediaMessageCell.h"
#import "SRMessagesCollectionViewFlowLayout.h"

@interface SRMessagesViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) BOOL isFirstLayout;

@end

@implementation SRMessagesViewController

- (SRMessagesCollectionView *)messagesCollectionView {
    if (!_messagesCollectionView) {
        _messagesCollectionView = [SRMessagesCollectionView messagesCollectionView];
    }
    return _messagesCollectionView;
}

- (SRMessageInputBar *)messageInputBar {
    if (!_messageInputBar) {
        _messageInputBar = [[SRMessageInputBar alloc] init];
    }
    return _messageInputBar;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isFirstLayout = YES;
    }
    return self;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (UIView *)inputAccessoryView {
    return self.messageInputBar;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)setAdditionalBottomInset:(CGFloat)additionalBottomInset {
    CGFloat delta = additionalBottomInset - _additionalBottomInset;
    _additionalBottomInset = additionalBottomInset;
    self.messageCollectionViewBottomInset += delta;
}

- (void)setMessageCollectionViewBottomInset:(CGFloat)messageCollectionViewBottomInset {
    _messageCollectionViewBottomInset = messageCollectionViewBottomInset;
    UIEdgeInsets messagesCollectionViewContentInset = self.messagesCollectionView.contentInset;
    messagesCollectionViewContentInset = UIEdgeInsetsMake(messagesCollectionViewContentInset.top, messagesCollectionViewContentInset.left, _messageCollectionViewBottomInset, messagesCollectionViewContentInset.right);
    UIEdgeInsets messagesCollectionViewScrollIndicatorInsets = self.messagesCollectionView.scrollIndicatorInsets;
    messagesCollectionViewScrollIndicatorInsets = UIEdgeInsetsMake(messagesCollectionViewScrollIndicatorInsets.top, messagesCollectionViewScrollIndicatorInsets.left, _messageCollectionViewBottomInset, messagesCollectionViewScrollIndicatorInsets.right);
}

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupDefaults];
    [self setupSubviews];
    [self setupConstraints];
    [self setupDelegates];
    [self addMenuControllerObservers];
    [self addObservers];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.isMessagesControllerBeingDismissed = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isMessagesControllerBeingDismissed = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.isMessagesControllerBeingDismissed = NO;
}

- (void)viewDidLayoutSubviews {
    if (self.isFirstLayout) {
        
    }
    self.isFirstLayout = NO;
}

- (void)dealloc {
    [self removeKeyboardObservers];
    [self removeMenuControllerObservers];
    [self removeObservers];
    [self clearMemoryCache];
}

#pragma mark - Methods [Private]
- (void)setupDefaults {
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.messagesCollectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    self.messagesCollectionView.alwaysBounceVertical = YES;
}

- (void)setupDelegates {
    self.messagesCollectionView.delegate = self;
    self.messagesCollectionView.dataSource = self;
}

- (void)setupSubviews {
    [self.view addSubview:self.messagesCollectionView];
}

- (void)setupConstraints {
    self.messagesCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *top = [self.messagesCollectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:self.topLayoutGuide.length];
    NSLayoutConstraint *bottom = [self.messagesCollectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor];
    if (@available(iOS 11.0, *)) {
        NSLayoutConstraint *leading = [self.messagesCollectionView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor];
        NSLayoutConstraint *trailing = [self.messagesCollectionView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor];
        [NSLayoutConstraint activateConstraints:@[top, bottom, leading, trailing]];
    } else {
        NSLayoutConstraint *leading = [self.messagesCollectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor];
        NSLayoutConstraint *trailing = [self.messagesCollectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor];
        [NSLayoutConstraint activateConstraints:@[top, bottom, leading, trailing]];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    SRMessagesCollectionView *msgCollectionView = (SRMessagesCollectionView *)collectionView;
    return [msgCollectionView.messageDataSource numberOfSectionInMessagesCollectionView:msgCollectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    SRMessagesCollectionView *msgCollectionView = (SRMessagesCollectionView *)collectionView;
    return [msgCollectionView.messageDataSource numberOfItemsInSection:section InMessagesCollectionView:msgCollectionView];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SRMessagesCollectionView *msgCollectionView = (SRMessagesCollectionView *)collectionView;
    id<SRMessagesDataSource>messagesDataSource = msgCollectionView.messageDataSource;
    SRMessageType *message = [messagesDataSource messageForItemAtIndexPath:indexPath inMessagesCollectionView:msgCollectionView];
    switch (message.kind.kind) {
        case SRMessagesKindText:
        case SRMessagesKindAttributedText:
        case SRMessagesKindEmoji:
        {
            SRTextMessageCell *cell = [msgCollectionView dequeueReusableCellWithReuseIdentifier:textCellID forIndexPath:indexPath];
            [cell configureWithMessageType:message atIndexPath:indexPath messageCollectionView:msgCollectionView];
            return cell;
        }
            break;
        case SRMessagesKindVideo:
        case SRMessagesKindPhoto:
        {
            SRMediaMessageCell *cell = [msgCollectionView dequeueReusableCellWithReuseIdentifier:mediaCellID forIndexPath:indexPath];
            [cell configureWithMessageType:message atIndexPath:indexPath messageCollectionView:msgCollectionView];
            return cell;
        }
            break;
        case SRMessagesKindCustom:
        {
            return [messagesDataSource customCellForMessage:message atIndexPath:indexPath inMessagesCollectionView:msgCollectionView];
        }
            break;
        default:
            break;
    }
    return [UICollectionViewCell new];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    SRMessagesCollectionView *msgCollectionView = (SRMessagesCollectionView *)collectionView;
    id<SRMessagesDisplayDelegate>displayDelegate = msgCollectionView.messageDisplayDelegate;

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return [displayDelegate messageHeaderViewForIndexPath:indexPath inMessageCollectionView:msgCollectionView];
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter
                ]) {
        return [displayDelegate messageFooterViewForIndexPath:indexPath inMessageCollectionView:msgCollectionView];
    }
    return [UICollectionReusableView new];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (![collectionViewLayout isKindOfClass:[SRMessagesCollectionViewFlowLayout class]]) {
        return CGSizeZero;
    }
    SRMessagesCollectionViewFlowLayout *messagesFlowLayout = (SRMessagesCollectionViewFlowLayout *)collectionViewLayout;
    return [messagesFlowLayout sizeForItemAtIndexPath:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    SRMessagesCollectionView *msgCollectionView = (SRMessagesCollectionView *)collectionView;
    id<SRMessagesLayoutDelegate>layoutDelegate = msgCollectionView.messageLayoutDelegate;
    return [layoutDelegate headerViewSizeForSection:section inMessageCollectionView:msgCollectionView];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    SRMessagesCollectionView *msgCollectionView = (SRMessagesCollectionView *)collectionView;
    id<SRMessagesLayoutDelegate>layoutDelegate = msgCollectionView.messageLayoutDelegate;
    return [layoutDelegate footerViewSizeForSection:section inMessageCollectionView:msgCollectionView];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
    SRMessagesCollectionView *msgCollectionView = (SRMessagesCollectionView *)collectionView;
    id<SRMessagesDataSource>messagesDataSource = msgCollectionView.messageDataSource;
    SRMessageType *message = [messagesDataSource messageForItemAtIndexPath:indexPath inMessagesCollectionView:msgCollectionView];
    switch (message.kind.kind) {
        case SRMessagesKindText:
        case SRMessagesKindAttributedText:
        case SRMessagesKindEmoji:
        case SRMessagesKindPhoto:
            self.selectedIndexPathForMenu = indexPath;
            return YES;
            break;
        default:
            return NO;
            break;
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    return action == @selector(copy:);
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
//    SRMessagesCollectionView *msgCollectionView = (SRMessagesCollectionView *)collectionView;
//    id<SRMessagesDataSource>messagesDataSource = msgCollectionView.messageDataSource;
    
}

#pragma mark - Helpers
- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearMemoryCache) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

- (void)clearMemoryCache {
//    SRMessageStyle.
}

@end
