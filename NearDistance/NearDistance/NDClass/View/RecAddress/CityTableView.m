//
//  YearTableView.m
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "CityTableView.h"
#import "AreaViewController.h"
#import "CreateAddressViewController.h"

@implementation CityTableView

#pragma mark tableView datasource
//子类可以覆盖父类中得这些方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cityCell";
    _cityCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (_cityCell == nil) {
        _cityCell = [[[NSBundle mainBundle] loadNibNamed:@"CityCell" owner:self options:nil] lastObject];
        _cityCell.backgroundColor = [UIColor whiteColor];
//        _yearCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _cityCell.city = [[self.data objectAtIndex:indexPath.row] objectForKey:@"city"];
    return _cityCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *city = [[self.data objectAtIndex:indexPath.row] objectForKey:@"city"];
    self.cityArray = [[self.data objectAtIndex:indexPath.row] objectForKey:@"areas"];
    if (self.cityArray.count!=0) {
        AreaViewController *areaCtrl = [[AreaViewController alloc] init];
        areaCtrl.area = [NSString stringWithFormat:@"%@ %@",self.province,city];
        areaCtrl.areaArray = self.cityArray;
        [self.viewController.navigationController pushViewController:areaCtrl animated:YES];
    }else{
        NSString *provinceArea = [NSString stringWithFormat:@"%@ %@",self.province,city];
        
        CreateAddressViewController *createCtrl = (CreateAddressViewController *)[CommonUtil popCtrl:self.viewController count:3];
        
        createCtrl.cityText = provinceArea;
        [self.viewController.navigationController popToViewController:createCtrl animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
