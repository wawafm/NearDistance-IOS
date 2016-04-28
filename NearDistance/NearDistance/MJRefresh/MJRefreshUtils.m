//
//  MJRefreshUtils.m
//  Wawa
//
//  Created by 李世超 on 15/1/2.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import "MJRefreshUtils.h"

static MJRefreshUtils *singleton;

@implementation MJRefreshUtils

+ (id)shareInstance
{
    if (singleton == nil) {
        singleton = [[[self class] alloc] init];
    }
    return singleton;
}

- (void)initMJRefresh:(UIScrollView *)srollView
{
    // 3.3行集成下拉刷新控件
    _header = [MJRefreshHeaderView header];
    _header.backgroundColor = [UIColor clearColor];
    _header.scrollView = srollView;
    
    // 4.3行集成上拉加载更多控件
    _footer = [MJRefreshFooterView footer];
    _footer.backgroundColor = [UIColor clearColor];
    _footer.scrollView = srollView;
}

- (MJRefreshHeaderView *)MJRefreshHeader
{
    if(!_header)
    {
         _header = [MJRefreshHeaderView header];
    }
    return _header;
}
- (MJRefreshFooterView *)MJRefreshFooter
{
    if(!_footer)
    {
        _footer = [MJRefreshFooterView footer];
    }
    return _footer;
}

@end
