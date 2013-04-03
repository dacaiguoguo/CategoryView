//
//  YKHeaderDetailListView.m
//  testapp1
//
//  Created by  YK on 13-4-3.
//  Copyright (c) 2013年 YEK. All rights reserved.
//

#import "YKHeaderDetailListView.h"
@interface YKHeaderDetailListView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *interTable;

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


- (void)delegateAction:(id)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
