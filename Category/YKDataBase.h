//
//  YKDataBase.h
//  Category
//
//  Created by  YK on 13-4-3.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKDataBase : NSObject
@property (nonatomic, retain) NSMutableDictionary *dataStore;
@property (nonatomic, copy) NSString *title_cate;
@property (nonatomic, copy) NSString *subTitle_cate;
@property (nonatomic, retain) NSArray *subArray;
@end
