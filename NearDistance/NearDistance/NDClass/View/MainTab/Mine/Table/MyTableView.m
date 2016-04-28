//
//  MyTableView.m
//  NearDistance
//
//  Created by 李世超 on 15/10/14.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "MyTableView.h"

@implementation MyTableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"myTableCell";
    _myTableCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (_myTableCell == nil) {
        _myTableCell = [[[NSBundle mainBundle] loadNibNamed:@"MyTableViewCell" owner:self options:nil] lastObject];
        _myTableCell.selectionStyle = UITableViewCellSelectionStyleBlue;
        _myTableCell.backgroundColor = [UIColor whiteColor];
    }
    NSData *hunterData = MEMBER;
    _memberModel = [NSKeyedUnarchiver unarchiveObjectWithData:hunterData];
    NSInteger isBind = [_memberModel.address integerValue];
    if (isBind == 0) {
    }else{
        [_myTableCell someIndexPath:indexPath];
    }
    _myTableCell.myText = [self.data objectAtIndex:indexPath.row];
    return _myTableCell;
}

#pragma mark - commentTableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DDLogVerbose(@"indexPath:%ld",indexPath.row);
    [self.myTabelDelegate clickIndexPath:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
