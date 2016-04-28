//
//  AreaViewController.m
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "AreaViewController.h"

@interface AreaViewController ()

@end

@implementation AreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setNavigationTitle:@"选择地区"];
    self.areaTableView.provinceCity = self.area;
    self.areaTableView.data = self.areaArray;
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
