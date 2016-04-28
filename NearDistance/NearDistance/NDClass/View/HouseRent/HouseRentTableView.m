//
//  HouseMessTableView.m
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "HouseRentTableView.h"

@implementation HouseRentTableView

//子类可以覆盖父类中得这些方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"houseRentCell";
    _houseRentCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (_houseRentCell == nil) {
        _houseRentCell = [[[NSBundle mainBundle] loadNibNamed:@"HouseRentCell" owner:self options:nil] lastObject];
        _houseRentCell.backgroundColor = [UIColor whiteColor];
        //        _yearCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    _houseMessCell.date = [self.data objectAtIndex:indexPath.row];
    return _houseRentCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
