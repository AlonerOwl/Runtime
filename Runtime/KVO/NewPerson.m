//
//  NewPerson.m
//  Runtime
//
//  Created by wukong on 2019/6/12.
//  Copyright © 2019 admin. All rights reserved.
//

#import "NewPerson.h"
#import <objc/message.h>

@implementation NewPerson

void setterMethod(id self, SEL _cmd, NSString *name) {
    // 1、调用父类方法
    // 2、通知观察者调用observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
    struct objc_super superClass = {
        self,
        class_getSuperclass([self class])
    };
    objc_msgSendSuper(&superClass, _cmd, name);
    
    id observer = objc_getAssociatedObject(self, (__bridge const void *)@"objc");
    
    NSString *methodName = NSStringFromSelector(_cmd);
    NSString *key = getValueKey(methodName);
    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:), key, self, @{key : name}, nil);
}

NSString *getValueKey(NSString *setter) {
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString *key = [setter substringWithRange:range];
    NSString *letter = [[setter substringToIndex:1] lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:letter];
    return key;
}

- (void)zf_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    
    // 获取当前类的名字
    NSString *oldName = NSStringFromClass([self class]);
    // 构建新类是名字
    NSString *newName = [NSString stringWithFormat:@"CustomKVO_%@", oldName];
    // 新建一个类，这个类是当前类的子类
    Class customClass = objc_allocateClassPair([self class], newName.UTF8String, 0);
    // 注册该类
    objc_registerClassPair(customClass);
    
    // 修改 isa 指针
    object_setClass(self, customClass);
    
    // 重写 set 方法
    NSString *methodName = [NSString stringWithFormat:@"set%@", keyPath.capitalizedString];
    SEL sel = NSSelectorFromString(methodName);
    class_addMethod(customClass, sel, (IMP)setterMethod, "v@:@");
    
    objc_setAssociatedObject(self, (__bridge const void *)@"objc", observer, OBJC_ASSOCIATION_ASSIGN);
}

@end
