//
//  CostQueryTableView.m
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "CostQueryTableView.h"

@implementation CostQueryTableView

#pragma mark tableView datasource
//子类可以覆盖父类中得这些方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"costQueryCell";
    _costQuery = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (_costQuery == nil) {
        _costQuery = [[[NSBundle mainBundle] loadNibNamed:@"CostQueryCell" owner:self options:nil] lastObject];
        _costQuery.backgroundColor = [UIColor whiteColor];
        //        _yearCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    _costModel = [self.data objectAtIndex:indexPath.row];
    _costQuery.costModel = _costModel;
    return _costQuery;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400;
}


@end
