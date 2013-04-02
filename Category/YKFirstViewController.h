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
@interface YKFirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView<SectionHeaderViewDelegate> *categoryTableView;

@end
