//
//  YKFirstViewController.h
//  Category
//
//  Created by  YK on 13-4-2.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKFirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
