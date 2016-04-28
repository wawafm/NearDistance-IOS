//
//  HouseViewController.m
//  NearDistance
//
//  Created by 李世超 on 15/10/19.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "HouseViewController.h"

@interface HouseViewController ()

@end

@implementation HouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [super setNavigationTitle:@"选择小区"];
//    NSMutableArray *array;
//    if ([self.houseTag isEqualToString:@"df"]) {
//        array= [NSMutableArray arrayWithObjects:@"1栋",@"2栋",@"3栋", nil];
//    }else{
//        array= [NSMutableArray arrayWithObjects:@"2栋",@"3栋",@"4栋",@"5栋",@"6栋", nil];
//    }
    self.houseTable.houseID = self.houseID;
    self.houseTable.data = self.villageArray;
    [self.houseTable reloadData];
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
