//
//  Person.m
//  Runtime
//
//  Created by admin on 2019/5/26.
//  Copyright © 2019 admin. All rights reserved.
//

#import "Person.h"
#import "SpareWheel.h"
#import <objc/runtime.h>

@implementation Person

void sendMessage(id self, SEL _cmd, NSString *msg) {
    NSLog(@"---%@", msg);
}

// 动态方法解析
+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    NSString *methodName = NSStringFromSelector(sel);
//    if ([methodName isEqualToString:@"sendMessage:"]) {
//        // v - void, @ - 对象, : - SEL
//        // 运行时将方法动态添加
//        class_addMethod(self, sel, (IMP)sendMessage, "v@:@");
//    }
    return NO;
}

// 快速转发
- (id)forwardingTargetForSelector:(SEL)aSelector {
//    NSString *methodName = NSStringFromSelector(aSelector);
//    if ([methodName isEqualToString:@"sendMessage:"]) {
//        return [SpareWheel new];
//    }
    return [super forwardingTargetForSelector:aSelector];
}

// 慢速转发

// 1、方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSString *methodName = NSStringFromSelector(aSelector);
    if ([methodName isEqualToString:@"sendMessage:"]) {
        // v - void, @ - 对象, : - SEL
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    return [super methodSignatureForSelector:aSelector];
}

// 2、消息转发
- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    SEL sel = [anInvocation selector]; // 获取方法编号
//    SpareWheel *tempObj = [SpareWheel new];
//    if ([tempObj respondsToSelector:sel]) {
//        [anInvocation invokeWithTarget:tempObj]; // 指定方法接收者
//    } else {
//        [super forwardInvocation:anInvocation];
//    }
    [super forwardInvocation:anInvocation];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector { // 实现该方法后，找不到方法时，上报错误，不会崩溃
    NSLog(@"找不到方法");
}

@end
