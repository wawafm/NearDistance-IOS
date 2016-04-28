//
//  TodayOfferViewController.m
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "TodayOfferViewController.h"

@interface TodayOfferViewController ()<NSXMLParserDelegate>

@end

@implementation TodayOfferViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *offer = [USERDEFAULT objectForKey:@"offer_detail"];
    if ([offer isEqualToString:@"offerDetail"]) {
        self.offerTableView.height = ScreenHeight-NAVIGATIONHEIGHT;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [USERDEFAULT removeObjectForKey:@"offer_detail"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setNavigationTitle:@"今日优惠"];
    [self _initMJRefresh:self.offerTableView];
    [self _hederFooterMJRefresh];
    [self httpXmlData];
}

#pragma mark -请求美团数据
- (void)httpXmlData
{
    [CommonUtil NavigationLoading:self.view];
    [DealModel getDealModel:10 success:^(AFHTTPRequestOperation* operation, NSObject* result){
        NSXMLParser *xmlParser = (NSXMLParser *)result;
        xmlParser.delegate = self;
        [xmlParser setShouldProcessNamespaces:YES];
        [xmlParser parse];
    } failure:^(NSError* error){
        [self dismissRefresh];
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
    }];
}

#pragma mark - NSXMLParser Delegate -
#pragma mark - 文档开始读取
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.meiTuanArray = [NSMutableArray array];
    self.currentDictionary = [NSMutableDictionary dictionary];
    _meiTuanModelArray = [NSMutableArray array];
    _meiTuanShopModelArray = [NSMutableArray array];
}

#pragma mark - 解析标签开始
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict  {
    self.previousElementName = self.elementName;
    if (qName) {
        self.elementName = qName;
    }
    self.xmlValue = [NSMutableString string];
    if (self.xmlValue != nil) {
        if ([qName isEqualToString:@"data"]) {
            self.currentDictionary = [NSMutableDictionary dictionary];
        }
        [self.currentDictionary setObject:self.xmlValue forKey:qName];
    }
    if ([qName isEqualToString:@"shop_city"]) {
        [self.meiTuanArray addObject:self.currentDictionary];
    }
}

#pragma mark - 解析文本节点
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (!self.elementName){
        return;
    }
    [self.xmlValue appendFormat:@"%@", string];
}

#pragma mark - 解析结束标记
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    self.elementName = nil;
}
#pragma mark - 文档结束时触发
-(void) parserDidEndDocument:(NSXMLParser *)parser{
//    NSLog(@"meiTuanArray:%@",_meiTuanArray);
    for (NSDictionary *dealDict in _meiTuanArray) {
        _dealModel = [[DealModel alloc] initWithDictionary:dealDict];
        [_meiTuanModelArray addObject:_dealModel];
        
        _shopModel = [[ShopModel alloc] initWithDictionary:dealDict];
        [_meiTuanShopModelArray addObject:_shopModel];
    }
    self.offerTableView.data = _meiTuanModelArray;
    self.offerTableView.shopArray = _meiTuanShopModelArray;
    [self.offerTableView reloadData];
    [self dismissRefresh];
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

#pragma mark - 下拉刷新
- (void)_hederFooterMJRefresh
{
    __unsafe_unretained TodayOfferViewController *todayOffer = self;
    _header.beginRefreshingBlock =  ^(MJRefreshBaseView *refreshView) {
        [todayOffer httpXmlData];
    };
//    [_header beginRefreshing];
}

#pragma mark - MJRefresh reloadDeals
- (void)reloadDeals
{
    [_header endRefreshing];
    [[KIProgressViewManager manager] hideProgressView];
}

#pragma mark - 刷新消失
- (void)dismissRefresh
{
    [self performSelector:@selector(reloadDeals) withObject:nil afterDelay:0.5];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
