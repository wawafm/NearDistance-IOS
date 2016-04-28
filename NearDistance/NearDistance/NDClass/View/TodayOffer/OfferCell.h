//
//  OfferCell.h
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealModel.h"
#import "ShopModel.h"
#import "InsetsLabel.h"

@interface OfferCell : UITableViewCell
{
    NSAttributedString *attributedString;
}
@property (nonatomic,retain) DealModel *dealModel;
@property (nonatomic,retain) ShopModel *shopModel;
@property (weak, nonatomic) IBOutlet UIImageView *offerImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet InsetsLabel *detailLabel;
@property (weak, nonatomic) IBOutlet InsetsLabel *priceLabel;
@property (weak, nonatomic) IBOutlet InsetsLabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldLineLabel;
@property (weak, nonatomic) IBOutlet UILabel *salesNumLabel;
@end
