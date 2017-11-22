//
//  ViewController.m
//  AppStoreStyle
//
//  Created by mac on 2017/11/21.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"
#import "MyCell.h"
#import "UIView+Extension.h"
//颜色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
#define rows 3  //一个tableview几行数据
#define rowheight 88  //行高
#define Twidth (self.view.width - 40)  //tableview宽度
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic ,strong) UIScrollView *scrollView;

@property (nonatomic ,strong) NSArray *dataArray;

@property (nonatomic ,strong) NSMutableArray *tableviewsArr;

@property (nonatomic,assign) CGFloat offsetx;

@property (nonatomic,assign) int TableCount;

@end

@implementation ViewController

-(NSMutableArray *)tableviewsArr {
    if (!_tableviewsArr) {
        _tableviewsArr = [NSMutableArray array];
    }
    return _tableviewsArr;
}

static NSString * identifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.width , rowheight * 3)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    [self loadData];

    
}

/**
 请求数据
 */
- (void)loadData {
//    sleep(3);//模拟请求数据消耗时间
    self.dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13"];
    int count = self.dataArray.count % rows == 0 ? self.dataArray.count / rows : self.dataArray.count / rows + 1;
    self.TableCount = count;
    self.scrollView.contentSize = CGSizeMake(self.view.width *count, rowheight * rows);
    
    for (int i = 0; i < count; i++) {
        //tableiew偏移
        UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(20 + Twidth * i, 0, Twidth, rowheight * rows)];
        //scrollView偏移
//        UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake( Twidth * i, 0, Twidth, rowheight * rows)];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.scrollEnabled = NO;
        tableview.tag = 1000 + i;
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableview registerClass:[MyCell class] forCellReuseIdentifier:identifier];
        [self.scrollView addSubview:tableview];
        [self.tableviewsArr addObject:tableview];
    }

//    self.scrollView.contentOffset = CGPointMake(-20, 0);
//    self.offsetx = -20;
}

#pragma tableview delegate / datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArray.count % rows == 0) {
        return rows;
    } else {
        int tag = (int)(tableView.tag - 1000);
        if (tag == self.TableCount - 1) {
            return self.dataArray.count - rows * (self.TableCount - 1);
        } else {
            return rows;
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    int tag = (int)(tableView.tag - 1000);
    cell.showLb.text = self.dataArray[tag * rows + indexPath.row];
    return cell;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return rowheight;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = (int)(self.scrollView.contentOffset.x / Twidth) ;
    //tableiew偏移
    for (int i = 0; i < self.tableviewsArr.count; i++) {
        UITableView *tableview = self.tableviewsArr[i];
        int x = 2*page + 1;
        if (page == 0) {
            x = 1;
        }
        [UIView animateWithDuration:0.2 animations:^{
            tableview.x = 20 * (x)+ Twidth * i;
        }];
        
    }
    //scrollView偏移  不好控制
    //    int i = pow(2, page) + 1;
    //    if (page == 0) {
    //        i = 1;
    //    }
    //    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x - 20 * i , 0);
    //    self.offsetx = self.scrollView.contentOffset.x - 20 * i;
}

-(void)scrollViewWillBeginDecelerating: (UIScrollView *)scrollView {
    
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    
}








@end
