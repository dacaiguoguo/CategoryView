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
/*
    使用方法
    这是一个控制器
    要子类化它并实现一定要实现的方法，比如返回数据源
 
 */
@protocol YKCategoryDatasource <NSObject>
/*获得section对应的子数据的方法*/
- (NSArray *)subArrayForSection:(NSInteger)index;
/*获得数据源方法*/
- (NSArray *)sectionInfoSource;



@end

@interface YKCategoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) UITableView<YKSectionHeaderViewDelegate> *categoryTableView;
/*!@var sectionInfoArray 分类信息数组*/
@property (nonatomic, strong) NSMutableArray* sectionInfoArray;


@end
