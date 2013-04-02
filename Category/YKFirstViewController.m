//
//  YKFirstViewController.m
//  Category
//
//  Created by  YK on 13-4-2.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import "YKFirstViewController.h"
#import "YKDataMode.h"
@interface YKFirstViewController ()

@end

@implementation YKFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
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
    YKDataMode *data = [[YKDataMode alloc] init];
    CFShow(data);
    [data release];
	// Do any additional setup after loading the view, typically from a nib.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
