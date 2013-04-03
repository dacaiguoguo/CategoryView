//
//  YKHeaderDetailListView.m
//  Category
//
//  Created by  yanguo.sun on 13-4-3.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import "YKHeaderDetailListView.h"
#import "YKCategoryClasses.h"

@interface YKHeaderDetailListView()<UITableViewDataSource,UITableViewDelegate,YKSectionHeaderViewDelegate>
@property (nonatomic, retain) UITableView *interTable;
/*!@var openSectionIndex 当前打开的Section*/
@property (nonatomic, assign) NSInteger openSectionIndex;
/*!@var sectionInfoArray 分类信息数组*/
@property (nonatomic, retain) NSMutableDictionary* sectionInfoDic;

@property (assign) CGRect orgFrame;
@end
@implementation YKHeaderDetailListView
- (void)dealloc{
    [super dealloc];
    _datasource = nil;
    _delegate = nil;
    [_sectionInfoDic release];
    [_interTable release];
}
- (id)initWithFrame:(CGRect)frame
{
    _orgFrame = frame;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.sectionInfoDic = [NSMutableDictionary dictionary];
        [self reloadData];
    }
    return self;
}

- (UITableView*)interTable{
    if (!_interTable) {
           _interTable = [[UITableView alloc] initWithFrame:_orgFrame style:UITableViewStylePlain] ;
        _interTable.dataSource = self;
        _interTable.delegate = self;
        [self addSubview:_interTable];
        [_interTable release];
    }
    return _interTable;
}
-(void) reloadData{
    _openSectionIndex = NSNotFound;
    [self.interTable reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.datasource numOfTop];
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YKDataMoudleList *sectionInfo = [self changeSubFromDatasourceItemsAtRow:section];
    assert(sectionInfo);
    NSInteger numStoriesInSection  = 0;
    numStoriesInSection = [[sectionInfo subArray] count];
    //            return [sectionInfo open] ? (NSInteger)ceilf(numStoriesInSection/2) : 0;
    numStoriesInSection = [sectionInfo open] ? numStoriesInSection : 0;
    NSLog(@"numStoriesInSection::%d",numStoriesInSection);
    return numStoriesInSection;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate HeaderDetailList:self didTapItemAtRow:indexPath.row];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *idfi = @"YKTableViewCellForGategory";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idfi];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idfi] autorelease];
    }
    YKDataMoudleList *list = [self changeSubFromDatasourceItemsAtRow:indexPath.section];
    assert(list);
    assert([list isKindOfClass:[YKDataMoudleList class] ]);

    cell.textLabel.text = [list.subArray objectAtIndex:indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  YKDataMoudleList *mod =   [self changeSubFromDatasourceItemsAtRow:section];
    if (!mod.headerView_cate) {
        mod.headerView_cate = [[[YKSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 70) title:[self.datasource titleAtTopRow:section] subTitle:[self.datasource subTitleAtTopRow:section] imageUrl:nil section:section delegate:self] autorelease];
    }
    assert(mod.headerView_cate);
    return mod.headerView_cate;
}


- (void)delegateAction:(id)s{

}
#pragma mark Section header delegate
- (int)get_OpenSectionIndex{
    return _openSectionIndex;
}
- (YKDataMoudleList  *)changeSubFromDatasourceItemsAtRow:(int)row{
    
  YKDataMoudleList *dataMoudle  =   [self.sectionInfoDic objectForKey:[NSString stringWithFormat:@"%d",row]];


    if (!dataMoudle) {
        NSArray *ret = [self.datasource itemsAtRow:row];
        YKDataMoudleList *dataMoudle = [[YKDataMoudleList alloc] init];
        dataMoudle.subArray = ret;
        dataMoudle.open = NO;
        assert(dataMoudle);
        [self.sectionInfoDic setObject:dataMoudle forKey:[NSString stringWithFormat:@"%d",row]];
        [dataMoudle release];
    }
    
    return  [self.sectionInfoDic objectForKey:[NSString stringWithFormat:@"%d",row]];
}
-(void)sectionHeaderView:(YKSectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)sectionOpened {
	
    YKDataMoudleList *subdata = [self changeSubFromDatasourceItemsAtRow:sectionOpened];
    assert(subdata);
    assert([subdata isKindOfClass:[YKDataMoudleList class] ]);
//	if ((![sectionInfo isKindOfClass:[YKDataMode class]])||sectionInfo.subArray==nil||sectionInfo.subArray.count<1) {
//        [self.delegate HeaderDetailList:self didTapItemAtRow:sectionOpened];
//        return;
//    }
	subdata.open = YES;
    NSInteger countOfRowsToInsert = (NSInteger)ceilf([subdata.subArray count]);
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
		
		YKDataMoudleList *previousOpenSection = [self changeSubFromDatasourceItemsAtRow:previousOpenSectionIndex];
        previousOpenSection.open = NO;
        [previousOpenSection.headerView_cate toggleOpenWithUserAction:NO];
        NSInteger countOfRowsToDelete = (NSInteger)ceilf([previousOpenSection.subArray count]);
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
    [self.interTable endUpdates];
    [indexPathsToDelete release];
    [indexPathsToInsert release];
    
    
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
	YKDataMoudleList *sectionInfo = [self changeSubFromDatasourceItemsAtRow:sectionClosed];
//    if ((![sectionInfo isKindOfClass:[YKDataMode class]])||sectionInfo.subArray==nil||sectionInfo.subArray.count<1) {
//        [self.delegate HeaderDetailList:self didTapItemAtRow:sectionClosed];
//        return;
//    }
    sectionInfo.open = NO;
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
