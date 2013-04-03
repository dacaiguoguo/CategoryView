//
//  YKDataBase.m
//  Category
//
//  Created by  YK on 13-4-3.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import "YKDataBase.h"

@implementation YKDataBase
@dynamic title_cate;
@dynamic subTitle_cate;
@dynamic subArray;

- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}
- (NSString *)title_cate{
    return [self.dataStore valueForKey:K_title];
}

- (NSArray *)subArray{
    return [self.dataStore valueForKey:K_subArray];
}
- (NSString *)subTitle_cate{
    return [self.dataStore valueForKey:K_subTitle];
}
- (void)setTitle_cate:(NSString *)title_cate{
    [self.dataStore setValue:title_cate forKey:K_title];
}
- (void)setSubTitle_cate:(NSString *)subTitle_cate{
    [self.dataStore setValue:subTitle_cate forKey:K_subTitle];
}

- (void)setSubArray:(NSArray *)subArray{
    [self.dataStore setValue:subArray forKey:K_subArray];
}
@end
