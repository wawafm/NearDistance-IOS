//
//  TodayOfferViewController.h
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"
#import "OfferTableView.h"
#import "ShopModel.h"

@interface TodayOfferViewController : NDBaseViewController
{
    MJRefreshHeaderView *_header;
//    MJRefreshFooterView *_footer;
}
@property (nonatomic,retain)DealModel *dealModel;
@property (nonatomic,retain)ShopModel *shopModel;

@property(strong) NSMutableDictionary *currentDictionary;//current section being parsed
@property(strong) NSString *previousElementName;
@property(strong) NSString *elementName;
@property(strong) NSMutableArray *meiTuanArray;
@property(strong) NSMutableArray *meiTuanModelArray;
@property(strong) NSMutableArray *meiTuanShopModelArray;
@property (strong) NSMutableString *xmlValue;

@property (weak, nonatomic) IBOutlet OfferTableView *offerTableView;
@end
