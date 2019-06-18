//
//  NewPerson.h
//  Runtime
//
//  Created by wukong on 2019/6/12.
//  Copyright © 2019 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewPerson : NSObject

@property (nonatomic, strong) NSString *name;

- (void)zf_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;

@end

NS_ASSUME_NONNULL_END
