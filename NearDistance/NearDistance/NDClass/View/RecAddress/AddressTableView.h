//
//  AddressTableView.h
//  NearDistance
//
//  Created by 李世超 on 15/10/20.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseTableView.h"
#import "AddressCell.h"
#import "AddressModel.h"

@protocol AddressDelegate <NSObject>

-(void)deleteAddress:(NSString *)addressID;

@end
@interface AddressTableView : NDBaseTableView

@property (nonatomic,retain) AddressModel *addressModel;
@property (nonatomic,retain) AddressCell *addressCell;

@property (nonatomic ,assign) id<AddressDelegate>addressDelegate;
@end
