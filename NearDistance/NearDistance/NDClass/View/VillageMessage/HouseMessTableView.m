//
//  HouseMessTableView.m
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "HouseMessTableView.h"

@implementation HouseMessTableView

//子类可以覆盖父类中得这些方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"houseMessCell";
    _houseMessCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (_houseMessCell == nil) {
        _houseMessCell = [[[NSBundle mainBundle] loadNibNamed:@"HouseMessCell" owner:self options:nil] lastObject];
        _houseMessCell.backgroundColor = [UIColor whiteColor];
    }
    _houseMessCell.newsModel = [self.data objectAtIndex:indexPath.row];
    return _houseMessCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _newsModel = [self.data objectAtIndex:indexPath.row];
    VillageNewsDetailViewController *villageNewsCtrl = [[VillageNewsDetailViewController alloc] init];
    villageNewsCtrl.content = _newsModel.content;
    [self.viewController.navigationController pushViewController:villageNewsCtrl animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

@end
