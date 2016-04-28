//
//  SeniorTableView.m
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "SeniorTableView.h"
#import "HouseViewController.h"

@implementation SeniorTableView

#pragma mark tableView datasource
//子类可以覆盖父类中得这些方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"seniorCell";
    _seniorCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (_seniorCell == nil) {
        _seniorCell = [[[NSBundle mainBundle] loadNibNamed:@"SeniorCell" owner:self options:nil] lastObject];
        _seniorCell.backgroundColor = [UIColor whiteColor];
        _seniorCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _areaModel = [self.data objectAtIndex:indexPath.row];
    _seniorCell.areaModel = _areaModel;
    return _seniorCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _areaModel = [self.data objectAtIndex:indexPath.row];
    HouseViewController *addHouse = [[HouseViewController alloc] init];
    addHouse.houseID = _areaModel.areaID;
    addHouse.villageArray = _areaModel.villageArray;
    [self.viewController.navigationController pushViewController:addHouse animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
