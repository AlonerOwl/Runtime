//
//  AssociatedManager.h
//  Runtime
//
//  Created by wukong on 2019/9/16.
//  Copyright © 2019 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

static void *ZFAlertDelegateBlock = "ZFAlertDelegateBlock";

@interface AssociatedManager : NSObject

+ (void)showAlert:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
