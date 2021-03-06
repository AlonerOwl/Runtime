//
//  Person.h
//  Runtime
//
//  Created by admin on 2019/5/26.
//  Copyright © 2019 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic,   copy) NSString * name;

- (instancetype)initWithDict:(NSDictionary *)dict;
- (NSDictionary *)convertModelToDict;

- (void)sendMessage:(NSString *)msg;

@end

NS_ASSUME_NONNULL_END
