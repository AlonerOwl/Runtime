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
#import <objc/message.h>

@implementation Person

#pragma mark - 字典转模型

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        for (NSString *key in dict.allKeys) {
            id value = dict[key];
            NSString *methodName = [NSString stringWithFormat:@"set%@", key.capitalizedString];
            SEL sel = NSSelectorFromString(methodName);
            if (sel) {
                ((void(*)(id, SEL, id))objc_msgSend)(self, sel, value);
            }
        }
    }
    return self;
}

/*
 key -  class_addProperty 遍历所有的属性
 value - get方法(objc_msgSend)
 */
- (NSDictionary *)convertModelToDict {
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(self, &count);
    if (count != 0) {
        NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
        for (int i = 0; i < count; i++) {
            const void *propertyName = property_getName(properties[i]);
            NSString *name = [NSString stringWithUTF8String:propertyName];
            SEL sel = NSSelectorFromString(name);
            if (sel) {
                id value = ((id(*)(id, SEL))objc_msgSend)(self, sel);
                if (value) {
                    tempDict[name] = value;
                } else {
                    tempDict[name] = @"";
                }
            }
        }
        free(properties);
        return tempDict;
    }
    free(properties);
    return nil;
}

#pragma mark - 消息发送机制

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
