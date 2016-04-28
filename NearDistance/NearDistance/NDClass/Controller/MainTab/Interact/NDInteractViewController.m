//
//  NDInteractViewController.m
//  NearDistance
//
//  Created by wawa on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDInteractViewController.h"
#import "PublishTopicViewController.h"
#import "BlockButton.h"

@interface NDInteractViewController ()<TopicDelegate>

@end

@implementation NDInteractViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        app.pageIndex = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super setNavigationLeft:@"邻居圈"];
    [self _initNavBarRight];
    
    _interactArray = [NSMutableArray array];
    self.interactTableView.interactDelegate = self;
    [self _initMJRefresh:self.interactTableView];
    [self _hederFooterMJRefresh];
    
    [self httpGetPublicTop:app.pageIndex memberID:MID refreshView:nil];
}

#pragma mark - 初始化右侧视图
- (void)_initNavBarRight
{
    BlockButton *publicButton = [[BlockButton alloc] initWithFrame:CGRectMake(0, 0, 100, 64) title:@"发布新话题"];
    [publicButton setBlock:^(BlockButton *button){
        PublishTopicViewController *publishTop = [[PublishTopicViewController alloc] init];
        publishTop.topicDelegate = self;
        [self.navigationController presentViewController:publishTop animated:YES completion:nil];
    }];
    UIBarButtonItem *publicItem = [[UIBarButtonItem alloc] initWithCustomView:publicButton];
    self.navigationItem.rightBarButtonItem = publicItem;
}

#pragma mark - PublishTopicViewController delegate
- (void)isPublicSuccess
{
    _refreshTop = @"downRefresh";
    [self httpGetPublicTop:app.pageIndex memberID:MID refreshView:nil];
}

#pragma mark - 获取话题
- (void)httpGetPublicTop:(int)pageIndex memberID:(NSString *)memberID refreshView:(MJRefreshBaseView *)refreshView;
{
    [CommonUtil NavigationLoading:self.view];
    [InteractListModel getInteractList:pageIndex success:^(AFHTTPRequestOperation* operation, NSObject* result){
        app.resObject = (NSDictionary *)result;
        if ([AF_CODE isEqualToString:@"1"]) {
            [self httpResponseDataObject:app.resObject];
        }else{
            [CommonUtil NotiTip:AF_MSG color:WARNNING_COLOR];
        }
        [self dismissRefresh];
    } failure:^(NSError* error){
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
        [self dismissRefresh];
    }];
}

#pragma mark - 响应数据处理
- (void)httpResponseDataObject:(id)resObject
{
    if ([_refreshTop isEqualToString:@"downRefresh"]) {
        [_interactArray removeAllObjects];
    }
    
    id listObject = [resObject objectForKey:@"list"];
    for (NSDictionary *dict in listObject) {
        _interactModel = [[InteractListModel alloc] InteractListWithDict:dict];
        [_interactArray addObject:_interactModel];
    }
    self.interactTableView.data = _interactArray;
    [self.interactTableView reloadData];
    [self InteractData];
}

#pragma mark - 页数判断
- (void)InteractData
{
    if (_interactArray.count == 0) {
        [[CommonUtil shareInstance] unInteractContent:self.view point:ScreenHeight/3 title:@"还没有发布话题" isShow:NO];
        _footer.hidden = YES;
    }else{
        _footer.hidden = NO;
        [[CommonUtil shareInstance] unInteractContent:self.view point:ScreenHeight/3 title:@"还没有发布话题." isShow:YES];
    }
}

#pragma mark - InteractTableView delegate
- (void)replyInteract:(int)btnTag content:(NSString *)commentModel replyY:(CGFloat)replyY
{
    replyTag = btnTag;
    _replyY = replyY;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    if (_key == nil) {
        _key = [[YcKeyBoardView alloc] initWithFrame:CGRectZero];
        self.key.frame = CGRectMake(0, ScreenHeight-NAVIGATIONHEIGHT-54, ScreenWidth, 54);
    }
    NSString *replayName;
    replayName = @"发表回复";
    _replyID = @"";
    
    [self.key initTextView:replayName];
    self.key.delegate= self;
    [self.key.textView becomeFirstResponder];
    self.key.textView.returnKeyType = UIReturnKeySend;
    [self.view addSubview:self.key];
}

- (void)scrollIndex
{
    [self.key.textView resignFirstResponder];
    [_key removeFromSuperview];
    _key = nil;
}

#pragma mark - 键盘弹出
-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    self.keyBoardHeight=deltaY;
    
    CGRect cellRect = [_interactTableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:replyTag+1 inSection:0]];
    
    float spaceY = (cellRect.origin.y)-deltaY;
    if (cellRect.origin.y==0) {
        CGPoint point = [_interactTableView contentOffset];
        [_interactTableView setContentOffset:CGPointMake(0,point.y) animated:YES];
    }else{
        if (replyTag!=0) {
            [_interactTableView setContentOffset:CGPointMake(0, spaceY+15) animated:YES];
        }
    }
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.key.transform = CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}

#pragma mark - 键盘隐藏
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.key.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        self.key.textView.text=@"";
        [self.key removeFromSuperview];
    }];
    [self.key.textView resignFirstResponder];
}

#pragma mark - 发送内容请求评论过接口
-(void)keyBoardViewHide:(YcKeyBoardView *)keyBoardView textView:(UITextView *)contentView
{
    if ([contentView.text isEqualToString:@""]||contentView.text==nil) {
        [CommonUtil NotiTip:@"评论内容不能为空" color:TIP_COLOR];
    }else{
        [contentView resignFirstResponder];
        _interactModel = self.interactArray[replyTag];
        [self httpReplyPublicTop:contentView.text toID:_interactModel.memberid fromID:MID articleID:_interactModel.interactID restoreID:replyTag];
    }
}

#pragma mark - 回复
- (void)httpReplyPublicTop:(NSString *)content toID:(NSString *)toID fromID:(NSString *)fromID articleID:(NSString *)articleID restoreID:(int)restoreID ;
{
    app.httpUrl = [NSString stringWithFormat:AF_CREATECOMMENT_URL,AF_WEBURL,content,toID,fromID,articleID,restoreID];
    app.httpUrl = [app.httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[[HttpAFNetworing shareInstance] httpMgr] GET:app.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        app.resObject = (NSDictionary *)responseObject;
        if ([AF_CODE isEqualToString:@"1"]) {
            //获取评论列表
            [self httpGetCommentList:articleID commentTag:replyTag];
        }else{
            [CommonUtil NotiTip:AF_MSG color:WARNNING_COLOR];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"=====failure %@",error);
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
    }];
}

#pragma makr - 评论列表请求
- (void)httpGetCommentList:(NSString *)articleID commentTag:(int)commentTag
{
    app.httpUrl = [NSString stringWithFormat:AF_GETCOMMENT_URL,AF_WEBURL,articleID];
    NSLog(@"commentList:%@",app.httpUrl);
    [[[HttpAFNetworing shareInstance] httpMgr] GET:app.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self httpCommResponseData:responseObject commentTag:commentTag];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"=====failure %@",error);
    }];
}

#pragma mark - 响应回复列表数据
- (void)httpCommResponseData:(id)resObject commentTag:(int)commentTag
{
    NSArray *commArray = [resObject objectForKey:@"list"];
    _commentArray = [NSMutableArray array];
    for (NSDictionary *dict in commArray) {
        _commentModel = [CommentModel CommentListWithDict:dict];
        [_commentArray addObject:_commentModel];
        
    }
    _interactModel.commentArray = [_commentArray mutableCopy];
    _interactTableView.interactCell.commentArray = _commentArray;
    [_interactTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:commentTag inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
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
    if (_footer==nil) {
        _footer = [MJRefreshFooterView footer];
        _footer.backgroundColor = [UIColor clearColor];
        _footer.scrollView = srollView;
    }
}

#pragma mark - 下拉刷新
- (void)_hederFooterMJRefresh
{
    __unsafe_unretained NDInteractViewController *interactCtrl = self;
    _header.beginRefreshingBlock =  ^(MJRefreshBaseView *refreshView) {

        interactCtrl.refreshTop = @"downRefresh";
        app.pageIndex = 1;
        
        [interactCtrl httpGetPublicTop:app.pageIndex memberID:MID refreshView:refreshView];
    };
//    [_header beginRefreshing];
    _footer.beginRefreshingBlock =  ^(MJRefreshBaseView *refreshView) {
        interactCtrl.refreshTop = @"upRefresh";
        app.pageIndex++;
        [interactCtrl httpGetPublicTop:app.pageIndex memberID:MID refreshView:refreshView];
    };
}

#pragma mark - MJRefresh reloadDeals
- (void)reloadDeals
{
    [_header endRefreshing];
    [_footer endRefreshing];
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
