//
//  SeniorTableView.m
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "HouseDetailTableView.h"

@implementation HouseDetailTableView

#pragma mark tableView datasource
//子类可以覆盖父类中得这些方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"houseDetailCell";
    _houseCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (_houseCell == nil) {
        _houseCell = [[[NSBundle mainBundle] loadNibNamed:@"HouseDetailCell" owner:self options:nil] lastObject];
        _houseCell.backgroundColor = [UIColor whiteColor];
        _houseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _roomModel = [self.data objectAtIndex:indexPath.row];
    _houseCell.roomModel = _roomModel;
    return _houseCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _roomModel = [self.data objectAtIndex:indexPath.row];
    if ([_roomDelegate respondsToSelector:@selector(roomID:)]) {
        [_roomDelegate roomID:_roomModel.roomID];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
