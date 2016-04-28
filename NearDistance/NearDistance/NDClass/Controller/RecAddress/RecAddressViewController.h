//
//  RecAddressViewController.h
//  NearDistance
//
//  Created by 李世超 on 15/10/14.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"
#import "AddressTableView.h"
#import "AddressModel.h"

@interface RecAddressViewController : NDBaseViewController<AddressDelegate>
{
    MJRefreshHeaderView *_header;
}
@property (nonatomic,copy) NSString *isAddAddress;
@property (nonatomic,retain)NSMutableArray *addressArray;
@property (nonatomic,retain) AddressModel *addressModel;
@property (weak, nonatomic) IBOutlet AddressTableView *addressTableView;
@end
