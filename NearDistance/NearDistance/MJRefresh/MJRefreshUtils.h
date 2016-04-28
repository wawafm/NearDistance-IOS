//
//  MJRefreshUtils.h
//  Wawa
//
//  Created by 李世超 on 15/1/2.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJRefreshUtils : NSObject
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}

+ (id)shareInstance;

- (void)initMJRefresh:(UIScrollView *)srollView;

- (MJRefreshHeaderView *)MJRefreshHeader;
- (MJRefreshFooterView *)MJRefreshFooter;

@end
