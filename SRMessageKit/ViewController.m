//
//  ViewController.m
//  SRMessageKit
//
//  Created by vi~ on 2019/4/27.
//  Copyright © 2019 zhangyangwei.com. All rights reserved.
//

#import "ViewController.h"
#import "SRChatViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)btnAction:(id)sender {
    SRChatViewController *vc = [[SRChatViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
