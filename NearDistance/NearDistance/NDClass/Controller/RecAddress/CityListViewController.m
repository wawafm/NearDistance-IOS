//
//  CityListViewController.m
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "CityListViewController.h"

@interface CityListViewController ()

@end

@implementation CityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setNavigationTitle:@"选择城市"];
    
    self.cityTableView.province = _province;
    self.cityTableView.data = self.citiesArray;
    [self.cityTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
