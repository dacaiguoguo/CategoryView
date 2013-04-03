//
//  YKFirstViewController.m
//  Category
//
//  Created by  yanguo.sun on 13-4-2.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import "YKCategoryViewController.h"
#import "YKProductListViewController.h"
#import "YKXIBHelper.h"

@interface YKCategoryViewController ()


@end

@implementation YKCategoryViewController
- (NSMutableArray*)getSectionInfoArray{
//    [self doesNotRecognizeSelector:_cmd];
    return nil;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];

    }
    return self;
}

/*当分类没有子分类时调用：去商品列表的方法 */
- (void)didSelectSection:(NSNumber *)_section{

}

							
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sectionInfoArray = [self getSectionInfoArray];
    self.categoryTableView = [[[YKCateTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-49-46) andData:self.sectionInfoArray] autorelease];
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
   static NSString *idfi = @"YKTableViewCellForGategory";
    YKTableViewCellForGategory *cell = [tableView dequeueReusableCellWithIdentifier:idfi];
    if (!cell) {
        cell=[YKXIBHelper loadObjectFromXIBName:@"YKTableViewCellForGategory" type:[YKTableViewCellForGategory class]];
    }
    YKDataMode* category=(YKDataMode*)[self.sectionInfoArray objectAtIndex:indexPath.section];
    int row = indexPath.row;
    NSString * obj =[category.subArray objectAtIndex:row*2];
//    assert([obj isKindOfClass:[NSString class]]);
    [cell.leftLabel setText:obj.description];
    if ([obj isKindOfClass:[YKDataMode class]]) {
        cell.leftGategory.aCategory = (YKDataMode*)obj;
        
    }    [cell.leftGategory addTarget:self action:@selector(goProList:) forControlEvents:UIControlEventTouchUpInside];
    if (row*2+1==category.subArray.count) {
        cell.rightGategory.hidden = YES;
    }else{
        cell.rightGategory.hidden = NO;
        obj =[category.subArray objectAtIndex:row*2+1];
//        assert([obj isKindOfClass:[NSString class]]);
        [cell.rightLabel setText:obj.description];
        if ([obj isKindOfClass:[YKDataMode class]]) {
            cell.rightGategory.aCategory = (YKDataMode*)obj;

        }
        [cell.rightGategory addTarget:self action:@selector(goProList:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;

}
- (void)goProList:(YKButtonForGategory*)button{
    CLog(@"%s",__func__);
    
    if (button.aCategory.subArray==nil||button.aCategory.subArray.count<1) {
        [self didSelectSection:nil];
        return;
    }
    YKCategoryViewController *to = [[YKCategoryViewController alloc] initWithNibName:@"YKCategoryViewController" bundle:nil];
    [to.sectionInfoArray removeAllObjects];
    for (int i=0; i<10; i++) {
        YKDataMode *data = [[YKDataMode alloc] init];
        //        CFShow(data);
        data.title_cate = [NSString stringWithFormat:@"%@:%d",@"男装",i];
        data.subTitle_cate = [NSString stringWithFormat:@"%@:%d",@"vt",i];;
        data.subArray =nil;
        [to.sectionInfoArray addObject:data];
        [data release];
    }
    [self.navigationController pushViewController:to animated:YES];
    [to release];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return self.sectionInfoArray.count;
}

- (NSArray *)numberOfSubArrayAtSection:(int )_index{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
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
