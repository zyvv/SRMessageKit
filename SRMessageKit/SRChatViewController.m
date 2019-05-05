//
//  SRChatViewController.m
//  SRMessageKit
//
//  Created by cssr_iOS on 2019/5/5.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "SRChatViewController.h"
#import "SRMessageKitDateFormatter.h"
#import "SRMessage.h"

@interface SRChatViewController ()<SRMessagesDataSource, SRMessageInputBarDelegate>

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) NSMutableArray *messageList;

@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation SRChatViewController

- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
    }
    return _refreshControl;
}

- (NSMutableArray *)messageList {
    if (!_messageList) {
        _messageList = [NSMutableArray arrayWithCapacity:0];
    }
    return _messageList;
}

- (NSDateFormatter *)formatter {
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.dateStyle = NSDateFormatterMediumStyle;
    }
    return _formatter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureMessageCollectionView];
    [self configureMessageInputBar];
    [self loadFirstMessage];

}

- (void)loadFirstMessage {
    
}

- (void)loadMoreMessage {
    [self.messagesCollectionView reloadDataAndKeepOffset];
    [self.refreshControl endRefreshing];
}

- (void)configureMessageCollectionView {
    self.messagesCollectionView.messageDataSource = self;
//    self.messagesCollectionView.messageCellDelegate = self;
    
    self.scrollsToBottomOnKeyboardBeginsEditing = YES;
    self.maintainPositionOnKeyboardFrameChanged = YES;
    
    [self.messagesCollectionView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(loadMoreMessage) forControlEvents:UIControlEventValueChanged];
}

- (void)configureMessageInputBar {
    self.messageInputBar.delegate = self;
    self.messageInputBar.inputTextView.tintColor = [UIColor whiteColor];
    self.messageInputBar.sendButton.tintColor = [UIColor yellowColor];
}

- (void)inserMessage:(SRMessage *)message {
    [self.messageList addObject:message];
    
    [self.messagesCollectionView performBatchUpdates:^{
        [self.messagesCollectionView insertSections:[NSIndexSet indexSetWithIndex:self.messageList.count - 1]];
        if (self.messageList.count >= 2) {
            [self.messagesCollectionView reloadSections:[NSIndexSet indexSetWithIndex:self.messageList.count - 2]];
        }
    } completion:^(BOOL finished) {
        if ([self isLastSectionVisible]) {
            [self.messagesCollectionView scrollToBottom:YES];
        }
    }];
}


- (BOOL)isLastSectionVisible {
    if (self.messageList.count <= 0) {
        return NO;
    }
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:0 inSection:self.messageList.count - 1];
    return [[self.messagesCollectionView indexPathsForVisibleItems] containsObject:lastIndexPath];
}

#pragma mark - MessagesDataSource
- (SRSender *)currentSender {
    return [[SRSender alloc] initWithSenderID:@"sodfjd" displayName:@"张三"];
}

- (NSInteger)numberOfSectionInMessagesCollectionView:(SRMessagesCollectionView *)messagesCollectionView {
    return self.messageList.count;
}

- (SRMessageType *)messageForItemAtIndexPath:(NSIndexPath *)indexPath inMessagesCollectionView:(SRMessagesCollectionView *)messagesCollectionView {
    return self.messageList[indexPath.section];
}

- (NSAttributedString *)cellTopLabelAttributedTextForMessage:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSAttributedString *)messageTopLabelAttributedTextForMessage:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath {
    NSString *name = messageType.sender.displayName;
    return [[NSAttributedString alloc] initWithString:name attributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1]}];
}

- (NSAttributedString *)messageBottomLabelAttributedText:(SRMessageType *)messageType atIndexPath:(NSIndexPath *)indexPath {
    NSString *dateString = [self.formatter stringFromDate:messageType.sentDate];
    return [[NSAttributedString alloc] initWithString:dateString attributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2]}];
}

- (UICollectionViewCell *)customCellForMessage:(SRMessageType *)mssageType atIndexPath:(NSIndexPath *)indexPath inMessagesCollectionView:(SRMessagesCollectionView *)messagesCollectionView {
    return [UICollectionViewCell new];
}


- (BOOL)isFromCurrentSender:(SRMessageType *)messageType {
    return [messageType.sender.senderID isEqualToString:[self currentSender].senderID];
}


- (NSInteger)numberOfItemsInSection:(NSInteger)section InMessagesCollectionView:(SRMessagesCollectionView *)messagesCollectionView {
    return 1;
}


- (void)didTapAvatarInCell:(SRMessageCollectionViewCell *)cell {
    
}

- (void)didTapMessageInCell:(SRMessageCollectionViewCell *)cell {
    
}

- (void)didTapCellTopLabelInCell:(SRMessageCollectionViewCell *)cell {
    
}

- (void)didTapMessageTopLabelInCell:(SRMessageCollectionViewCell *)cell {
    
}

- (void)messageInputBar:(SRMessageInputBar *)inputBar didPressSendButtonWithText:(NSString *)text {
    for (NSObject *component in inputBar.inputTextView.components) {
        SRMessage *message = [[SRMessage alloc] init];
        message.sender = [self currentSender];
        message.messageId = [self uuid];
        message.sentDate = [NSDate date];
        if ([component isKindOfClass:[NSString class]]) {
            SRMessageKind *kind = [[SRMessageKind alloc] init];
            kind.kind = SRMessagesKindText;
            kind.text = (NSString *)component;
            message.kind = kind;
            
        } else if ([component isKindOfClass:[UIImage class]]) {
            SRMessageKind *kind = [[SRMessageKind alloc] init];
            kind.kind = SRMessagesKindPhoto;
            SRMediaItem *item = [[SRMediaItem alloc] init];
            item.image = (UIImage *)component;
            kind.photo = item;
        }
        [self inserMessage:message];
    }
    inputBar.inputTextView.text = @"";
    [self.messagesCollectionView scrollToBottom:YES];
}


-(NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

@end
