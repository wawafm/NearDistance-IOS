//
//  HomeTableView.m
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "HomeTableView.h"
#import "OfferDetailViewController.h"

@implementation HomeTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
    }
    return self;
}

#pragma mark tableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
//子类可以覆盖父类中得这些方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else{
        return self.data.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
         UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self _initGridView:cell];
        return cell;
    }else{
        static NSString *identifier = @"homeCell";
        _homeCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (_homeCell == nil) {
            _homeCell = [[[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:self options:nil] lastObject];
            _homeCell.backgroundColor = [UIColor whiteColor];
            _homeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        self.dealModel = [self.data objectAtIndex:indexPath.row];
        _homeCell.dealModel = self.dealModel;
        _homeCell.shopModel = [self.shopArray objectAtIndex:indexPath.row];
        return _homeCell;
    }
}

#pragma mark - 初始化功能网格
- (void)_initGridView:(UITableViewCell *)cell
{
    NSArray *images = HOME_FUN_IMG;
    NSArray *titles = HOME_FUN_TITLE;
    self.funView = [[FunctionView alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, HOME_FUN_HEIGHT) images:images titles:titles];
    
    [cell addSubview:self.funView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.dealModel = [self.data objectAtIndex:indexPath.row];
    OfferDetailViewController *offerDetail = [[OfferDetailViewController alloc] init];
    offerDetail.dealUrl = self.dealModel.deal_wap_url;
    [self.viewController.navigationController pushViewController:offerDetail animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return HOME_FUN_HEIGHT;
    }else{
        return HOME_OFFER_HEIGHT;
    }
}

@end
