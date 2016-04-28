//
//  OfferTableView.h
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseTableView.h"
#import "DealModel.h"
#import "ShopModel.h"
#import "OfferCell.h"
#import "OfferDetailViewController.h"

@interface OfferTableView : NDBaseTableView

@property (nonatomic,retain) NSMutableArray *shopArray;
@property (nonatomic,retain) OfferCell      *offerCell;
@property (nonatomic,retain) DealModel      *dealModel;
@property (nonatomic,retain) ShopModel      *shopModel;
@end
