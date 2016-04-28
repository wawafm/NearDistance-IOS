//
//  YearTableView.m
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "AreaTableView.h"
#import "CreateAddressViewController.h"

@implementation AreaTableView

#pragma mark tableView datasource
//子类可以覆盖父类中得这些方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"areaCell";
    _areaCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (_areaCell == nil) {
        _areaCell = [[[NSBundle mainBundle] loadNibNamed:@"AreaCell" owner:self options:nil] lastObject];
        _areaCell.backgroundColor = [UIColor whiteColor];
//        _yearCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _areaCell.city = [self.data objectAtIndex:indexPath.row];
    return _areaCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *area = [self.data objectAtIndex:indexPath.row];
    NSString *provinceArea = [NSString stringWithFormat:@"%@ %@",self.provinceCity,area];
    
    CreateAddressViewController *createCtrl = (CreateAddressViewController *)[CommonUtil popCtrl:self.viewController count:4];
    createCtrl.cityText = provinceArea;
    [self.viewController.navigationController popToViewController:createCtrl animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
