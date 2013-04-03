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
- (NSArray*)subArrayForSection:(int)_section;
/*获得数据源方法*/
- (NSMutableArray*)getSectionInfoArray;
/*点击可进入商品详情的方法*/
- (void)didSelectSection:(NSNumber *)_section;
/*进入商品详情的方法*/
- (void)goProList:(YKButtonForGategory*)button;

@end

@interface YKCategoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,YKCategoryDatasource>
@property (retain, nonatomic) UITableView<YKSectionHeaderViewDelegate> *categoryTableView;
/*!@var sectionInfoArray 分类信息数组*/
@property (nonatomic, strong) NSMutableArray* sectionInfoArray;


@end
