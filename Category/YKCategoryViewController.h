//
//  YKFirstViewController.h
//  Category
//
//  Created by  yanguo.sun on 13-4-2.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKCategoryClasses.h"
#import "YKDataMode.h"
#import "YKCateTableView.h"
@interface YKCategoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) UITableView<YKSectionHeaderViewDelegate> *categoryTableView;
@property (assign) BOOL hasSubCategory;
/*!@var sectionInfoArray 分类信息数组*/
@property (nonatomic, strong) NSMutableArray* sectionInfoArray;


@end
