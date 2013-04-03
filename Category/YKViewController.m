//
//  YKViewController.m
//  Category
//
//  Created by  YK on 13-4-3.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import "YKViewController.h"

@interface YKViewController ()

@end

@implementation YKViewController

- (int)numOfTop{
    return 5;
}
- (NSString *)titleAtTopRow:(int)row{
    return [NSString stringWithFormat:@"title:%@",self.dataSource[row]];
}
- (NSString *)subTitleAtTopRow:(int)row{
    return [NSString stringWithFormat:@"subTitle:%@",self.dataSource[row]];
;
}
- (NSArray*)itemsAtRow:(int)row{
    return @[@"1",@"2",@"3",@"4"];
}
- (void)HeaderDetailList:(YKHeaderDetailListView *)_headerList didTapItemAtRow:(int)_row{
    NSLog(@"didTapItemAtRow:%d",_row);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource = @[@"1",@"2",@"3",@"4",@"5"];
    YKHeaderDetailListView *header = [[YKHeaderDetailListView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-49-46)];
    header.datasource = self;
    header.delegate = self;
    [self.view addSubview:header];
    [header reloadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
