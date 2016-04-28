//
//  CostQueryViewController.m
//  NearDistance
//
//  Created by 李世超 on 15/10/14.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "CostQueryViewController.h"
#import "CostQueryModel.h"

@interface CostQueryViewController ()

@end

@implementation CostQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setNavigationTitle:@"费用查询"];
    self.costTableView.costModel = _costModel;
    [self.costTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
