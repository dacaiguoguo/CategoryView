//
//  YKDataMode.h
//  Category
//
//  Created by  yanguo.sun on 13-4-2.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

@class YKSectionHeaderView;

@interface YKDataMode : NSObject
@property (assign) BOOL open_cate;
@property (nonatomic, copy) NSString *title_cate;
@property (nonatomic, copy) NSString *subTitle_cate;
@property (nonatomic, retain) YKSectionHeaderView *headerView_cate;
@property (nonatomic, retain) NSArray *subArray;

@end
