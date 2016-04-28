//
//  OfferTableView.m
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "OfferTableView.h"

@implementation OfferTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
    }
    return self;
}

#pragma mark tableView datasource

//子类可以覆盖父类中得这些方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identifier = @"offerCell";
    _offerCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (_offerCell == nil) {
        _offerCell = [[[NSBundle mainBundle] loadNibNamed:@"OfferCell" owner:self options:nil] lastObject];
        _offerCell.backgroundColor = [UIColor whiteColor];
    }
    self.dealModel = [self.data objectAtIndex:indexPath.row];
    _offerCell.dealModel = self.dealModel;
    _offerCell.shopModel = [self.shopArray objectAtIndex:indexPath.row];
    return _offerCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.dealModel = [self.data objectAtIndex:indexPath.row];
    OfferDetailViewController *offerDetail = [[OfferDetailViewController alloc] init];
    offerDetail.popTag = @"pop";
    offerDetail.dealUrl = self.dealModel.deal_wap_url;
    [self.viewController.navigationController pushViewController:offerDetail animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HOME_OFFER_HEIGHT;
}
@end
