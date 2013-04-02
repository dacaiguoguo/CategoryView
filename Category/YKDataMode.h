//
//  YKDataMode.h
//  Category
//
//  Created by  YK on 13-4-2.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKDataMode : NSObject
@property (nonatomic, retain) NSDictionary *dataDic;
@property (assign,getter = isOpen) BOOL open_cate;
@property (nonatomic, retain) UIView *headerView_cate;
- (void)setAttribute:(id)obj forKey:(NSString*)key;
- (id)attributeForKey:(NSString *)key;
@end
