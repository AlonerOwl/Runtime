//
//  AssociatedManager.m
//  Runtime
//
//  Created by wukong on 2019/9/16.
//  Copyright © 2019 admin. All rights reserved.
//

#import "AssociatedManager.h"

@implementation AssociatedManager

+ (void)showAlert:(UIViewController *)vc {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题" message:@"描述" delegate:vc cancelButtonTitle:@"取消" otherButtonTitles:@"继续", nil];
    void (^block)(NSInteger) = ^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
            NSLog(@"取消");
        } else {
            NSLog(@"继续");
        }
    };
    // 设置关联
    objc_setAssociatedObject(alertView, ZFAlertDelegateBlock, block, OBJC_ASSOCIATION_COPY);
    [alertView show];
}

@end
