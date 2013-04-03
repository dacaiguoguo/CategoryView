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
#pragma mark - YKCategoryDatasource
/*当分类没有子分类时调用：去商品列表的方法 */
- (void)didSelectSection:(NSNumber *)_section{
    [self doesNotRecognizeSelector:_cmd];
}
- (void)goProList:(YKButtonForGategory *)button{
    [self doesNotRecognizeSelector:_cmd];
}
- (NSArray*)subArrayForSection:(int)_section{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}
#pragma mark end YKCategoryDatasource
#pragma mark -

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.sectionInfoArray==nil) {
        self.sectionInfoArray = [self getSectionInfoArray];
    }
    self.categoryTableView = [[[YKCateTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-49-46) andData:self.sectionInfoArray] autorelease];
    _categoryTableView.dataSource = self;
    _categoryTableView.delegate = self;
    [self.view addSubview:_categoryTableView];


	// Do any additional setup after loading the view, typically from a nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	YKDataMode *sectionInfo = [self.sectionInfoArray objectAtIndex:section];
    NSInteger numStoriesInSection  = 0;
    if ([sectionInfo isKindOfClass:[YKDataMode class]]) {
        numStoriesInSection = [[sectionInfo subArray] count];
        return [sectionInfo open_cate] ? (NSInteger)ceilf(numStoriesInSection/2) : 0;

    }else{
        numStoriesInSection  = 0;
        return numStoriesInSection;
    }

}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *idfi = @"YKTableViewCellForGategory";
    YKTableViewCellForGategory *cell = [tableView dequeueReusableCellWithIdentifier:idfi];
    if (!cell) {
        cell=[YKXIBHelper loadObjectFromXIBName:@"YKTableViewCellForGategory" type:[YKTableViewCellForGategory class]];
    }
    
    NSArray *sub_array = [self subArrayForSection:indexPath.section];
    int row = indexPath.row;
    NSString * obj =[sub_array objectAtIndex:row*2];
//    assert([obj isKindOfClass:[NSString class]]);
    [cell.leftLabel setText:obj.description];
    if ([obj isKindOfClass:[YKDataMode class]]) {
        cell.leftGategory.aCategory = (YKDataMode*)obj;
        
    }    [cell.leftGategory addTarget:self action:@selector(goProList:) forControlEvents:UIControlEventTouchUpInside];
    if (row*2+1==sub_array.count) {
        cell.rightGategory.hidden = YES;
    }else{
        cell.rightGategory.hidden = NO;
        obj =[sub_array objectAtIndex:row*2+1];
//        assert([obj isKindOfClass:[NSString class]]);
        [cell.rightLabel setText:obj.description];
        if ([obj isKindOfClass:[YKDataMode class]]) {
            cell.rightGategory.aCategory = (YKDataMode*)obj;

        }
        [cell.rightGategory addTarget:self action:@selector(goProList:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;

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
    if ([dataMode isKindOfClass:[YKDataMode class]]) {
        view = dataMode.headerView_cate;
        if (!view) {
            dataMode.headerView_cate = [[YKSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 40) title:dataMode.title_cate subTitle:dataMode.subTitle_cate imageUrl:nil section:section delegate:self.categoryTableView];
            dataMode.headerView_cate.delegate = _categoryTableView;
            view = dataMode.headerView_cate;
        }
        return view;
    }else{
       return [[YKSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 40) title:dataMode.description subTitle:dataMode.description imageUrl:nil section:section delegate:self.categoryTableView];
    }

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
