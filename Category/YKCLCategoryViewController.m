//
//  YKCLCategoryViewController.m
//  Category
//
//  Created by  YK on 13-4-3.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import "YKCLCategoryViewController.h"
#import "YKProductListViewController.h"
@interface YKCLCategoryViewController ()

@end

@implementation YKCLCategoryViewController
- (NSMutableArray*)getSectionInfoArray{

    NSMutableArray *ret = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    for (int i=0; i<10; i++) {
        YKDataMode *data = [[YKDataMode alloc] init];
        //        CFShow(data);
        data.title_cate = @"男装";
        data.subTitle_cate = @"vtt";
        data.subArray = @[@"1",@"2",@"3",@"4"];
        [ret addObject:data];
        [data release];
    }
    return ret;
}


- (NSArray*)subArrayForSection:(int)_section{

    NSMutableArray *inter = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    for (int i=0; i<10; i++) {
        YKDataMode *data = [[YKDataMode alloc] init];
        //        CFShow(data);
        data.title_cate = @"subArray";
        data.subTitle_cate = @"vt";
        data.subArray = @[@"1",@"2",@"3",@"4"];
        [inter addObject:data];
        [data release];
    }
    return inter;
}
- (void)didSelectSection:(NSNumber *)_section{
    CLog(@"%s",__func__);
    YKProductListViewController *p = [[YKProductListViewController alloc] initWithNibName:@"YKProductDetailViewController" bundle:nil];
    [self.navigationController pushViewController:p animated:YES];
    [p release];

}

- (void)goProList:(YKButtonForGategory*)button{
    CLog(@"%s",__func__);
    
    if (button.aCategory.subArray==nil||button.aCategory.subArray.count<1) {
        [self didSelectSection:nil];
        return;
    }
    
    YKCLCategoryViewController *to = [[YKCLCategoryViewController alloc] initWithNibName:@"YKCategoryViewController" bundle:nil];
    to.sectionInfoArray = [button.aCategory.subArray mutableCopy];
    [self.navigationController pushViewController:to animated:YES];
    [to release];
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
