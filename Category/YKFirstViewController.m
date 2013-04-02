//
//  YKFirstViewController.m
//  Category
//
//  Created by  yanguo.sun on 13-4-2.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import "YKFirstViewController.h"
#import "YKXIBHelper.h"

@interface YKFirstViewController ()
/*!@var sectionInfoArray 分类信息数组*/
@property (nonatomic, strong) NSMutableArray* sectionInfoArray;

@end

@implementation YKFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        self.sectionInfoArray = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
        for (int i=0; i<10; i++) {
            YKDataMode *data = [[YKDataMode alloc] init];
            //        CFShow(data);
            data.title_cate = @"男装";
            data.subTitle_cate = @"vt";
            data.subArray = @[@"1",@"2",@"3",@"4"];
            [self.sectionInfoArray addObject:data];
            [data release];
        }
        self.categoryTableView = [[[YKCateTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-49-46) andData:self.sectionInfoArray] autorelease];
        _categoryTableView.dataSource = self;
        _categoryTableView.delegate = self;
        [self.view addSubview:_categoryTableView];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];



	// Do any additional setup after loading the view, typically from a nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	YKDataMode *sectionInfo = [self.sectionInfoArray objectAtIndex:section];
	NSInteger numStoriesInSection = [[sectionInfo subArray] count];
    
    return [sectionInfo open_cate] ? (NSInteger)ceilf(numStoriesInSection/2) : 0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *idfi = @"YKTableViewCellForGategory";
    YKTableViewCellForGategory *cell = [tableView dequeueReusableCellWithIdentifier:idfi];
    if (!cell) {
        cell=[YKXIBHelper loadObjectFromXIBName:@"YKTableViewCellForGategory" type:[YKTableViewCellForGategory class]];
    }
    YKDataMode* category=(YKDataMode*)[self.sectionInfoArray objectAtIndex:indexPath.section];
    int row = indexPath.row;
    NSString * obj =[category.subArray objectAtIndex:row*2];
    [cell.leftLabel setText:obj];
//    cell.leftGategory.aCategory = obj;
    [cell.leftGategory addTarget:self action:@selector(goProList:) forControlEvents:UIControlEventTouchUpInside];
    if (row*2+1==category.subArray.count) {
        cell.rightGategory.hidden = YES;
    }else{
        cell.rightGategory.hidden = NO;
        obj =[category.subArray objectAtIndex:row*2+1];
        [cell.rightLabel setText:obj];
//        cell.rightGategory.aCategory = obj;
        [cell.rightGategory addTarget:self action:@selector(goProList:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;

    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}
- (void)goProList:(YKButtonForGategory*)button{
    CLog(@"%s",__func__);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return self.sectionInfoArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = nil;
    YKDataMode *dataMode = [self.sectionInfoArray objectAtIndex:section];
    view = dataMode.headerView_cate;
    if (!view) {
        dataMode.headerView_cate = [[YKSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 40) title:dataMode.title_cate subTitle:dataMode.subTitle_cate imageUrl:nil section:section delegate:self.categoryTableView];
        dataMode.headerView_cate.delegate = _categoryTableView;
        view = dataMode.headerView_cate;
    }
    return view;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [super dealloc];
}
@end
