//
//  YearTableView.m
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "ProvinceTableView.h"
#import "CityListViewController.h"
#import "CreateAddressViewController.h"

@implementation ProvinceTableView

#pragma mark tableView datasource
//子类可以覆盖父类中得这些方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"provinceCell";
    _provinceCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (_provinceCell == nil) {
        _provinceCell = [[[NSBundle mainBundle] loadNibNamed:@"ProvinceCell" owner:self options:nil] lastObject];
        _provinceCell.backgroundColor = [UIColor whiteColor];
//        _yearCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _provinceCell.provice = [[self.data objectAtIndex:indexPath.row] objectForKey:@"state"];
    return _provinceCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *province = [[self.data objectAtIndex:indexPath.row] objectForKey:@"state"];
    self.cityArray = [[self.data objectAtIndex:indexPath.row] objectForKey:@"cities"];
    if (self.cityArray.count!=0) {
        CityListViewController *cityList = [[CityListViewController alloc] init];
        cityList.province = province;
        cityList.citiesArray = self.cityArray;
        [self.viewController.navigationController pushViewController:cityList animated:YES];
    }else{
        CreateAddressViewController *createCtrl = (CreateAddressViewController *)[CommonUtil popCtrl:self.viewController count:2];;
        
        createCtrl.cityText = province;
        [self.viewController.navigationController popViewControllerAnimated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
