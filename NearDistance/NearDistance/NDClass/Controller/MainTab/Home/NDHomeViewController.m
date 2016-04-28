//
//  NDHomeViewController.m
//  NearDistance
//
//  Created by wawa on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDHomeViewController.h"
#import "NDLoopImageView.h"
#import "TodayOfferViewController.h"
#import <PgyUpdate/PgyUpdateManager.h>

@interface NDHomeViewController ()<NSXMLParserDelegate>
{
    NDLoopImageView *loopView;
}
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) NSArray *titles;
@end

@implementation NDHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _advertisArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setNavigationLeft:@"邻距"];
    
    [self _initMJRefresh:self.homeTableView];
    [self _hederFooterMJRefresh];
    [self unImgView];
    [self httpAdvertisImg];
    [self httpXmlData];
    [self checkUpdate];
}

#pragma mark - 图片未加载状态
- (void)unImgView
{
    UIView *unView= [[UIView alloc] initWithFrame:CGRectMake(0, HOME_LOOP_SPACE, ScreenWidth, HOME_LOOP_SIZE)];
    _homeTableView.tableHeaderView = unView;
    [[CommonViews shareInstance] darckCircleDot:100 view:unView];
}

#pragma mark - 检查更新
- (void)checkUpdate
{
    [[PgyUpdateManager sharedPgyManager] checkUpdate];
}

#pragma mark - 初始化轮播视图
- (void)_initLoopImagView:(NSArray *)images
{
    if (loopView==nil) {
        loopView = [[NDLoopImageView alloc] initWithFrame:CGRectMake(0, HOME_LOOP_SPACE, ScreenWidth, HOME_LOOP_SIZE) images:images];
    }
    _homeTableView.tableHeaderView = loopView;
}

#pragma mark - 广告图
- (void)httpAdvertisImg
{
    [[CommonViews shareInstance] startShowAnimating];
    [AdvertisModel getAdvertisModel:0 success:^(AFHTTPRequestOperation* operation, NSObject* result){
        app.resObject = (NSDictionary *)result;
        id resObject = [ app.resObject objectForKey:@"list"];
        if ([AF_CODE isEqualToString:@"1"]) {
            for (NSDictionary *dict in resObject) {
                _advertisModel = [[AdvertisModel alloc] initWithDictionary:dict];
                [_advertisArray addObject:_advertisModel];
            }
            [self _initLoopImagView:_advertisArray];
        }else{
            [CommonUtil NotiTip:AF_MSG color:WARNNING_COLOR];
        }
        [self dismissRefresh];
    } failure:^(NSError* error){
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
        [self dismissRefresh];
    }];
}

#pragma mark -请求最新一条美团数据
- (void)httpXmlData
{
    [CommonUtil NavigationLoading:self.view];
    [DealModel getDealModel:1 success:^(AFHTTPRequestOperation* operation, NSObject* result){
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
        [self.currentDictionary setObject:self.xmlValue forKey:qName];
    }
    if ([qName isEqualToString:@"response"]) {
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
    for (NSDictionary *dealDict in _meiTuanArray) {
        _dealModel = [[DealModel alloc] initWithDictionary:dealDict];
        [_meiTuanModelArray addObject:_dealModel];
        _shopModel = [[ShopModel alloc] initWithDictionary:dealDict];
        [_meiTuanShopModelArray addObject:_shopModel];
    }
    self.homeTableView.data = _meiTuanModelArray;
    self.homeTableView.shopArray = _meiTuanShopModelArray;
    [self.homeTableView reloadData];
    [self dismissRefresh];
}

#pragma mark - 初始化刷新视图
- (void)_initMJRefresh:(UIScrollView *)srollView
{
    if (_header==nil) {
        _header = [MJRefreshHeaderView header];
        _header.backgroundColor = [UIColor clearColor];
        _header.scrollView = srollView;
    }
    
    if (_footer==nil) {
        _footer = [MJRefreshFooterView footer];
        _footer.refreshTag = @"homePage";
        _footer.backgroundColor = [UIColor clearColor];
        _footer.scrollView = srollView;
    }
}

#pragma mark - 下拉刷新
- (void)_hederFooterMJRefresh
{
    __unsafe_unretained NDHomeViewController *homeCtrl = self;
    _header.beginRefreshingBlock =  ^(MJRefreshBaseView *refreshView) {
        [homeCtrl httpAdvertisImg];
        [homeCtrl httpXmlData];
    };
    _footer.beginRefreshingBlock =  ^(MJRefreshBaseView *refreshView) {
        [homeCtrl performSelector:@selector(pushTodayOffer) withObject:nil afterDelay:0.5];
    };
}

- (void)pushTodayOffer
{
    [_footer endRefreshing];
    TodayOfferViewController *todayOffer = [[TodayOfferViewController alloc] init];
    [self.navigationController pushViewController:todayOffer animated:YES];
}

#pragma mark - MJRefresh reloadDeals
- (void)reloadDeals
{
    [_header endRefreshing];
    [_footer endRefreshing];
    [[KIProgressViewManager manager] hideProgressView];
    [[CommonViews shareInstance] startShowAnimating];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self reloadDeals];
}

#pragma mark - 刷新消失
- (void)dismissRefresh
{
    [self performSelector:@selector(reloadDeals) withObject:nil afterDelay:0.5];
}

#pragma mark - memoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
