//
//  YKDataMode.h
//  Category
//
//  Created by  YK on 13-4-2.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

@class SectionHeaderView;

@interface YKDataMode : NSObject
@property (assign) BOOL open_cate;
@property (nonatomic, copy) NSString *title_cate;
@property (nonatomic, copy) NSString *subTitle_cate;
@property (nonatomic, retain) SectionHeaderView *headerView_cate;
@property (nonatomic, retain) NSArray *subArray;

@end
