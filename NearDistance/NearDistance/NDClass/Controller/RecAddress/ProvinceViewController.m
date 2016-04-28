//
//  ProvinceViewController.m
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "ProvinceViewController.h"

@interface ProvinceViewController ()
{
    NSMutableArray *provinces;
}
@end

@implementation ProvinceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setNavigationTitle:@"省份列表"];
    [self getCityData];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 获取城市数据
-(void)getCityData
{
    //加载数据
    provinces = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
    
    self.provinceTable.data = provinces;
    [self.provinceTable reloadData];
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
