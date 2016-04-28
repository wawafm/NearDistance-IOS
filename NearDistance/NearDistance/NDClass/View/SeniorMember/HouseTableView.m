//
//  SeniorTableView.m
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "HouseTableView.h"
#import "HouseDetailViewController.h"

@implementation HouseTableView

#pragma mark tableView datasource
//子类可以覆盖父类中得这些方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"houseCell";
    _houseCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (_houseCell == nil) {
        _houseCell = [[[NSBundle mainBundle] loadNibNamed:@"HouseCell" owner:self options:nil] lastObject];
        _houseCell.backgroundColor = [UIColor whiteColor];
        _houseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _villageModel = [self.data objectAtIndex: indexPath.row];
    _houseCell.villageModel = _villageModel;
    return _houseCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _villageModel = [self.data objectAtIndex:indexPath.row];
    HouseDetailViewController *addHouse = [[HouseDetailViewController alloc] init];
    addHouse.houseID = self.houseID;
    addHouse.villageID = _villageModel.villageID;
    addHouse.roomArray = _villageModel.roomArray;
    [self.viewController.navigationController pushViewController:addHouse animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
