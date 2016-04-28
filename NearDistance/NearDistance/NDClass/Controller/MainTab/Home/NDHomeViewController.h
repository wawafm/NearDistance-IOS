//
//  NDHomeViewController.h
//  NearDistance
//
//  Created by wawa on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"
#import "HomeTableView.h"
#import "DealModel.h"
#import "ShopModel.h"
#import "AdvertisModel.h"

@interface NDHomeViewController : NDBaseViewController
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}
@property (nonatomic,retain) NSMutableArray *advertisArray;
@property (nonatomic,retain) AdvertisModel *advertisModel;
@property (nonatomic,retain)DealModel *dealModel;
@property (nonatomic,retain)ShopModel *shopModel;

@property(strong) NSMutableDictionary *currentDictionary;//current section being parsed
@property(strong) NSString *previousElementName;
@property(strong) NSString *elementName;
@property(strong) NSMutableArray *meiTuanArray;
@property(strong) NSMutableArray *meiTuanModelArray;
@property(strong) NSMutableArray *meiTuanShopModelArray;
@property (strong) NSMutableString *xmlValue;

@property (weak, nonatomic) IBOutlet HomeTableView *homeTableView;
@end
