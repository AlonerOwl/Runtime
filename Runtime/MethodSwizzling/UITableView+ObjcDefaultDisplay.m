//
//  UITableView+ObjcDefaultDisplay.m
//  Runtime
//
//  Created by admin on 2019/5/27.
//  Copyright © 2019 admin. All rights reserved.
//

#import "UITableView+ObjcDefaultDisplay.h"
#import <objc/runtime.h>

static char ZFDefualtView;

@implementation UITableView (ObjcDefaultDisplay)

+ (void)load {
    Method originMethod = class_getInstanceMethod(self, @selector(reloadData));
    Method currentMethod = class_getInstanceMethod(self, @selector(zf_reloadData));
    // 使用自己写的方法替换系统方法
    method_exchangeImplementations(originMethod, currentMethod);
}

- (void)zf_reloadData {
    [self zf_reloadData];
    [self fillDefualtView];
}

- (void)fillDefualtView {
    id<UITableViewDataSource> dataSource = self.dataSource;
    NSInteger section = [dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)] ? [dataSource numberOfSectionsInTableView:self] : 1;
    NSInteger row = 0;
    for (NSInteger i = 0; i < section; i++) {
        row = [dataSource tableView:self numberOfRowsInSection:section];
    }
    if (!row) {
        self.zfDefualtView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.zfDefualtView.backgroundColor = [UIColor redColor];
        [self addSubview:self.zfDefualtView];
    } else {
        self.zfDefualtView.hidden = YES;
    }
}

- (void)setZfDefualtView:(UIView *)zfDefualtView {
    objc_setAssociatedObject(self, &ZFDefualtView, zfDefualtView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)zfDefualtView {
    return objc_getAssociatedObject(self, &ZFDefualtView);
}

@end
