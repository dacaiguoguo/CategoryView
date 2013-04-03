//
//  YKHeaderDetailListView.h
//  Category
//
//  Created by  yanguo.sun on 13-4-3.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YKHeaderDetailListViewDataSource <NSObject>
-(int) numOfTop;
-(NSString*) titleAtTopRow:(int) row;
-(NSArray*) itemsAtRow:(int) row;
- (NSString *)subTitleAtTopRow:(int)row;
@end

@class YKHeaderDetailListView;
@protocol YKHeaderDetailListViewDelegate <NSObject>

- (void)HeaderDetailList:(YKHeaderDetailListView *)_headerList didTapItemAtRow:(int)_row;

@end
/*
    @class YKHeaderDetailListView
    @superClass UIView
    @description 用tableView的header 点击向下展开Cell
 */
@interface YKHeaderDetailListView : UIView
@property (assign) id<YKHeaderDetailListViewDataSource> datasource;
@property (assign) id<YKHeaderDetailListViewDelegate> delegate;
-(void) reloadData;
@end
