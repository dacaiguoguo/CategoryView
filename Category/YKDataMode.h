//
//  YKDataMode.h
//  Category
//
//  Created by  yanguo.sun on 13-4-2.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

@class YKSectionHeaderView;
@interface YKDataMoudleList : NSObject
@property (assign) BOOL open;
@property (nonatomic, copy) NSString *title_cate;
@property (nonatomic, copy) NSString *subTitle_cate;
@property (nonatomic, retain) YKSectionHeaderView *headerView_cate;
@property (nonatomic, retain) NSArray *subArray;

@end