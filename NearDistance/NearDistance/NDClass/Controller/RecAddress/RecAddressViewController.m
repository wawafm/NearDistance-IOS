//
//  RecAddressViewController.m
//  NearDistance
//
//  Created by 李世超 on 15/10/14.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "RecAddressViewController.h"
#import "CreateAddressViewController.h"
#import "BlockButton.h"

@interface RecAddressViewController ()

@end

@implementation RecAddressViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _addressArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    if(_isAddAddress.length!=0){
        [self httpGetAddress:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setNavigationTitle:@"收货地址"];
    self.view.backgroundColor = kUIColorFromRGB(BGGRAY);
    [self _addHeader];
    self.addressTableView.addressDelegate = self;
    [self _initRightEdit];
    [self _initMJRefresh:self.addressTableView];
    [self _hederFooterMJRefresh];
    [self httpGetAddress:nil];
}
#pragma mark -  headerView
- (void)_addHeader
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    bgView.backgroundColor = kUIColorFromRGB(BGGRAY);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 10, ScreenWidth, 40);
    button.backgroundColor = kUIColorFromRGB(WHITE);
    [button addTarget:self action:@selector(addressAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"添加" forState:UIControlStateNormal];
    button.titleLabel.font = FONG_14;
    [button setTitleColor:kUIColorFromRGB(BLACK_COLOR) forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"xinhuati"] forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 290);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 270);
    [bgView addSubview:button];

    if (IPhone5S||iPhone5) {
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 240);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 220);
    }
    self.addressTableView.tableHeaderView = bgView;
}

#pragma mark - edit 编辑收货地址
- (void)_initRightEdit
{
    BlockButton *editButton = [[BlockButton alloc] initWithFrame:CGRectMake(0, 0, 45, 30) title:@"编辑"];
    [editButton setBlock:^(BlockButton *button){
        button.selected = !button.selected;
        BOOL isEditing = self.addressTableView.isEditing;
        [self.addressTableView setEditing:!isEditing animated:YES];
    }];
    UIBarButtonItem *editBar = [[UIBarButtonItem alloc] initWithCustomView:editButton];
    self.navigationItem.rightBarButtonItem = editBar;
}

#pragma mark - 添加地址
- (void)addressAction:(id)sender {
    [USERDEFAULT removeObjectForKey:@"province_city"];
    CreateAddressViewController *createCtrl = [[CreateAddressViewController alloc] init];
    [self.navigationController pushViewController:createCtrl animated:YES];
}

#pragma mark - 获取收货地址
- (void)httpGetAddress:(MJRefreshBaseView *)refreshView
{
    [CommonUtil NavigationLoading:self.view];
    [AddressModel getAddress:MID success:^(AFHTTPRequestOperation *operation,NSObject *result){
        app.resObject = (NSDictionary *)result;
        id resObject = [app.resObject objectForKey:@"list"];
        if ([AF_CODE isEqualToString:@"1"]) {
            [self httpGetAddressData:resObject];
        }else{
            [CommonUtil NotiTip:AF_MSG color:WARNNING_COLOR];
        }
        [self dismissRefresh];
    } failure:^(NSError *error){
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
        [self dismissRefresh];
    }];
}

#pragma mark - 收货地址数据
- (void)httpGetAddressData:(id)resObject
{
    if (resObject!=nil) {
        [_addressArray removeAllObjects];
        for (NSDictionary *dict in resObject) {
            _addressModel = [[AddressModel alloc] initWithDictionary:dict];
            [_addressArray addObject:_addressModel];
        }
    }
    self.addressTableView.data = _addressArray;
    [self.addressTableView reloadData];
}

- (void)deleteAddress:(NSString *)addressID
{
    [self httpDeleteAddress:addressID];
}

#pragma mark - 删除收货地址
- (void)httpDeleteAddress:(NSString *)addressID
{
    app.httpUrl = [NSString stringWithFormat:AF_DELETEADDRESS_URL,AF_WEBURL,addressID];
    [[[HttpAFNetworing shareInstance] httpMgr] GET:app.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        app.resObject = (NSDictionary *)responseObject;
        if ([AF_CODE isEqualToString:@"1"]) {
            [CommonUtil NotiTip:AF_MSG color:SUCCESS_COLOR];
        }else{
            [CommonUtil NotiTip:AF_MSG color:WARNNING_COLOR];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"=====failure %@",error);
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
    }];
}

#pragma mark - 初始化刷新视图
- (void)_initMJRefresh:(UIScrollView *)srollView
{
    // 3.3行集成下拉刷新控件
    if (_header==nil) {
        _header = [MJRefreshHeaderView header];
        _header.backgroundColor = [UIColor clearColor];
        _header.scrollView = srollView;
    }
}

#pragma mark - 收货地址下拉刷新
- (void)_hederFooterMJRefresh
{
    __unsafe_unretained RecAddressViewController *recAddress = self;
    _header.beginRefreshingBlock =  ^(MJRefreshBaseView *refreshView) {
        [recAddress httpGetAddress:refreshView];
    };
//    [_header beginRefreshing];
}

#pragma mark - MJRefresh reloadDeals
- (void)reloadDeals
{
    [_header endRefreshing];
    [[KIProgressViewManager manager] hideProgressView];
}

- (void)dismissRefresh
{
    [self performSelector:@selector(reloadDeals) withObject:nil afterDelay:0.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
