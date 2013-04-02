//
//  YKDataMode.m
//  Category
//
//  Created by  YK on 13-4-2.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import "YKDataMode.h"

@implementation YKDataMode
- (id)init{
    self = [super init];
    if (self) {
        self.dataDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
    }
    return self;
}
- (NSString *)description{
    return self.dataDic.description;
}
- (void)setAttribute:(id)obj forKey:(NSString*)key{}


- (id)attributeForKey:(NSString *)key{
    return nil;
}
@end
