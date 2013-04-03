//
//  YKHeaderDetailListView.m
//  testapp1
//
//  Created by  YK on 13-4-3.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import "YKHeaderDetailListView.h"
#import "YKCategoryClasses.h"

@interface YKHeaderDetailListView()<UITableViewDataSource,UITableViewDelegate,YKSectionHeaderViewDelegate>
@property (nonatomic, retain) UITableView *interTable;
/*!@var openSectionIndex 当前打开的Section*/
@property (nonatomic, assign) NSInteger openSectionIndex;
/*!@var sectionInfoArray 分类信息数组*/
@property (nonatomic, assign) NSArray* sectionInfoArray;
@end
@implementation YKHeaderDetailListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self reloadData];
        
    }
    return self;
}
-(void) reloadData{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    int numRow=[self.datasource numOfTop];
    self.interTable = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStylePlain] autorelease];
    _interTable.dataSource = self;
    _interTable.delegate = self;
    [self addSubview:_interTable];
    
    for(int i =0 ; i<numRow;++i){
        //create view
        CGRect rect = CGRectMake(0, i*40, 320, 40);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = rect;
        [button addTarget:self.delegate action:@selector(HeaderDetailList:didTapItemAtRow:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:rect];
        titleLabel.text=[self.datasource titleAtTopRow:i];
        [self addSubview:titleLabel];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.datasource numOfTop];
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *idfi = @"YKTableViewCellForGategory";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idfi];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idfi];
    }
    cell.textLabel.text = [self.datasource titleAtTopRow:indexPath.section];
    cell.detailTextLabel.text = [self.datasource subTitleAtTopRow:indexPath.section];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[[YKSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 40) title:[self.datasource titleAtTopRow:section] subTitle:[self.datasource subTitleAtTopRow:section] imageUrl:nil section:section delegate:self] autorelease];
}


- (void)delegateAction:(id)s{

}
#pragma mark Section header delegate
- (int)get_OpenSectionIndex{
    return _openSectionIndex;
}
-(void)sectionHeaderView:(YKSectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)sectionOpened {
	
    
	YKDataMode *sectionInfo = [self.sectionInfoArray objectAtIndex:sectionOpened];
	if ((![sectionInfo isKindOfClass:[YKDataMode class]])||sectionInfo.subArray==nil||sectionInfo.subArray.count<1) {
        [self.delegate performSelector:@selector(didSelectSection:) withObject:[NSNumber numberWithInt:sectionOpened]];
        return;
    }
	sectionInfo.open_cate = YES;
    NSInteger countOfRowsToInsert = (NSInteger)ceilf([sectionInfo.subArray count]/2);
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < countOfRowsToInsert; i++) {
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:sectionOpened]];
    }
    CLog(@"indexPathsToInsert:%d",countOfRowsToInsert);
    
    /*
     Create an array containing the index paths of the rows to delete: These correspond to the rows for each quotation in the previously-open section, if there was one.
     */
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    
    NSInteger previousOpenSectionIndex = self.openSectionIndex;
    if (previousOpenSectionIndex != NSNotFound) {
		
		YKDataMode *previousOpenSection = [self.sectionInfoArray objectAtIndex:previousOpenSectionIndex];
        previousOpenSection.open_cate = NO;
        [previousOpenSection.headerView_cate toggleOpenWithUserAction:NO];
        NSInteger countOfRowsToDelete = (NSInteger)ceilf([previousOpenSection.subArray count]/2);
        CLog(@"countOfRowsToDelete:%d",countOfRowsToDelete);
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:previousOpenSectionIndex]];
        }
    }
    
    // Style the animation so that there's a smooth flow in either direction.
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (previousOpenSectionIndex == NSNotFound || sectionOpened < previousOpenSectionIndex) {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }
    else {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }
    
    // Apply the updates.
    [self.interTable beginUpdates];
    [self.interTable insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [self.interTable deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [indexPathsToDelete release];
    [indexPathsToInsert release];
    [self.interTable endUpdates];
    
    
    self.openSectionIndex = sectionOpened;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"_openSectionIndex" object:nil];
    if ([self.interTable numberOfRowsInSection:_openSectionIndex]>0) {
        [self.interTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_openSectionIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}


-(void)sectionHeaderView:(YKSectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)sectionClosed {
    
    /*
     Create an array of the index paths of the rows in the section that was closed, then delete those rows from the table view.
     */
	YKDataMode *sectionInfo = [self.sectionInfoArray objectAtIndex:sectionClosed];
    if ((![sectionInfo isKindOfClass:[YKDataMode class]])||sectionInfo.subArray==nil||sectionInfo.subArray.count<1) {
        [self.delegate performSelector:@selector(didSelectSection:) withObject:[NSNumber numberWithInt:sectionClosed]];
        return;
    }
    sectionInfo.open_cate = NO;
    NSInteger countOfRowsToDelete = [self.interTable numberOfRowsInSection:sectionClosed];
    
    if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:sectionClosed]];
        }
        [self.interTable deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
        [indexPathsToDelete release];
    }
    self.openSectionIndex = NSNotFound;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"_openSectionIndex" object:nil];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
