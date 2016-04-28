//
//  HomeCell.h
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealModel.h"
#import "ShopModel.h"

@interface HomeCell : UITableViewCell
{
    NSAttributedString *attributedString;
}
@property (nonatomic,retain) DealModel *dealModel;
@property (nonatomic,retain) ShopModel *shopModel;
@property (weak, nonatomic) IBOutlet UIImageView *homeOfferImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@end
