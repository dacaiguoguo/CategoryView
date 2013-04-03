//
//  YKDataMode.m
//  Category
//
//  Created by  yanguo.sun on 13-4-2.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import "YKDataMode.h"
//
//@implementation YKDataMode
//- (id)init{
//    self = [super init];
//    if (self) {
//    }
//    return self;
//}
//
//
//@end
@implementation YKDataMoudleList
- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}
- (NSString *)description{
    return  [NSString stringWithFormat:@"dd:%@",self.open?@"YES":@"NO"];
    
}

@end
