//
//  CreateAddressViewController.h
//  NearDistance
//
//  Created by 李世超 on 15/10/14.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"
#import "AddressModel.h"

@interface CreateAddressViewController : NDBaseViewController<UITextFieldDelegate>

//@property (nonatomic,copy) NSString *tip;
//@property (nonatomic,copy) UIColor  *tipColor;
@property (nonatomic,copy) NSString *addressTitle;
@property (nonatomic,retain) AddressModel *addressModel;
@property (nonatomic,strong) NSString *nameText;
@property (nonatomic,strong) NSString *phoneText;
@property (nonatomic,strong) NSString *cityText;
@property (nonatomic,strong) NSString *addressText;
@property (nonatomic,strong) NSString *zipCodeText;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;

@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;

- (IBAction)cityTapAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@end
