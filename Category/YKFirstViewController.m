//
//  YKFirstViewController.m
//  Category
//
//  Created by  YK on 13-4-2.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import "YKFirstViewController.h"


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
            data.subArray = @[@"1",@"2",@"3",@"4"];
            [self.sectionInfoArray addObject:data];
            [data release];
        }
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.categoryTableView = [[[YKCateTableView alloc] initWithFrame:self.view.bounds andData:self.sectionInfoArray] autorelease];
    _categoryTableView.dataSource = self;
    _categoryTableView.delegate = self;
    [self.view addSubview:_categoryTableView];


	// Do any additional setup after loading the view, typically from a nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	YKDataMode *sectionInfo = [self.sectionInfoArray objectAtIndex:section];
	NSInteger numStoriesInSection = [[sectionInfo subArray] count];
    
    return [sectionInfo open_cate] ? (NSInteger)ceilf(numStoriesInSection/2) : 0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *idfi = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idfi];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idfi] autorelease];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return self.sectionInfoArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = nil;
    YKDataMode *dataMode = [self.sectionInfoArray objectAtIndex:section];
    view = dataMode.headerView_cate;
    if (!view) {
        dataMode.headerView_cate = [[SectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 40) title:@"titi" subTitle:@"newnenw" imageUrl:nil section:section delegate:self.categoryTableView];
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
