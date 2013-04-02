//
//  YKCateTableView.m
//  Category
//
//  Created by  YK on 13-4-2.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import "YKCateTableView.h"

@implementation YKCateTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame andData:(NSArray *)_array{
    self = [super initWithFrame:frame];
    if (self) {
        self.sectionInfoArray = _array;
        _openSectionIndex = NSNotFound;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        // Initialization code
    }
    return self;
}

#pragma mark Section header delegate
- (int)get_OpenSectionIndex{
    return _openSectionIndex;
}
-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)sectionOpened {
	
    
	YKDataMode *sectionInfo = [self.sectionInfoArray objectAtIndex:sectionOpened];
	
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
    [self beginUpdates];
    [self insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [self deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self endUpdates];
    
    
    self.openSectionIndex = sectionOpened;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"_openSectionIndex" object:nil];
    if ([self numberOfRowsInSection:_openSectionIndex]>0) {
        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_openSectionIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}


-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)sectionClosed {
    
    /*
     Create an array of the index paths of the rows in the section that was closed, then delete those rows from the table view.
     */
	YKDataMode *sectionInfo = [self.sectionInfoArray objectAtIndex:sectionClosed];
	
    sectionInfo.open_cate = NO;
    NSInteger countOfRowsToDelete = [self numberOfRowsInSection:sectionClosed];
    
    if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:sectionClosed]];
        }
        [self deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
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
