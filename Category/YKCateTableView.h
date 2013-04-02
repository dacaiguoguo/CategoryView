//
//  YKCateTableView.h
//  Category
//
//  Created by  yanguo.sun on 13-4-2.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKCategoryClasses.h"
@interface YKCateTableView : UITableView<YKSectionHeaderViewDelegate>
/*!@var openSectionIndex 当前打开的Section*/
@property (nonatomic, assign) NSInteger openSectionIndex;
/*!@var sectionInfoArray 分类信息数组*/
@property (nonatomic, assign) NSArray* sectionInfoArray;
- (id)initWithFrame:(CGRect)frame andData:(NSArray *)_array;
@end
