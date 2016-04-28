//
//  NDLoopImageView.m
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import "NDLoopImageView.h"
#import "AdvertisViewController.h"

@interface NDLoopImageView () <UIScrollViewDelegate>
{
    UIScrollView* _bannerScrollView;
    UIPageControl* _pageControl;
    NSTimer* _timer;
    
}
@end

@implementation NDLoopImageView

//添加新视图时调用（在一个子视图将要被添加到另一个视图的时候发送此消息）
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    [self steup];
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(autoChangeBanner) userInfo:nil repeats:YES];
    
    [super willMoveToSuperview:newSuperview];
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images
{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.userInteractionEnabled = YES;
        self.images = images;
        self.bannerCount = (int)self.images.count;
//        [self steup];
    }
    return self;
}

- (void)setImages:(NSArray *)images {
    _images = images;
    _bannerCount = (int)_images.count;
}

#pragma mark - 初始化轮播视图
- (void)steup {
    if (self.frame.size.width == 0 || self.frame.size.height == 0) {
        DDLogWarn(@"未设置frame， 或者frame设置错误");
    }
    if (!self.images) {
        self.bannerCount = 2;
        self.images = @[@"ad",@"ad1"];
    }
    _bannerScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _bannerScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _bannerScrollView.delegate = self;
    _bannerScrollView.pagingEnabled = YES;
    _bannerScrollView.showsHorizontalScrollIndicator = NO;
    _bannerScrollView.contentSize = CGSizeMake(self.bounds.size.width*(_bannerCount+2), self.bounds.size.height);
    _bannerScrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    for (int i=-1; i<_bannerCount+1; i++) {
        CGFloat imgvWidth = CGRectGetWidth(_bannerScrollView.frame);
        CGFloat imgvHeight = CGRectGetHeight(_bannerScrollView.frame);
        UIImageView* imgv = [[UIImageView alloc] initWithFrame:CGRectMake(imgvWidth*(i+1), 0, imgvWidth, imgvHeight)];
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [imgv addGestureRecognizer:tapGest];
        [_bannerScrollView addSubview:imgv];
        
        imgv.userInteractionEnabled = YES;
        imgv.contentMode = UIViewContentModeScaleAspectFill;
        imgv.clipsToBounds = YES;
        int temp = i==-1?_bannerCount-1:i==_bannerCount?0:i;
//        DDLogVerbose(@"%d-%@",i,_images[temp]);
        imgv.tag = temp;
        _advertisModel = _images[temp];
//        imgv.image = [UIImage imageNamed:_images[temp]];
        [imgv setImageWithURL:[NSURL URLWithString:_advertisModel.imagepath]];
        imgv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    [self addSubview:_bannerScrollView];
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_bannerScrollView.frame)-20, self.bounds.size.width, 19)];
    _pageControl.numberOfPages = _bannerCount;
    _pageControl.currentPage = 0;
    _pageControl.userInteractionEnabled = NO;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = kUIColorFromRGB(MAIN_COLOR);
    _pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_pageControl];
}

- (void)tapAction:(UITapGestureRecognizer *)sender
{
    _advertisModel = [_images objectAtIndex:sender.view.tag];
    AdvertisViewController *advertisCtrl = [[AdvertisViewController alloc] init];
    advertisCtrl.advertisUrl = _advertisModel.url;
    [self.viewController.navigationController pushViewController:advertisCtrl animated:YES];
}

#pragma mark - Action
-(void) autoChangeBanner{
    [_bannerScrollView setContentOffset:CGPointMake(_bannerScrollView.contentOffset.x+self.bounds.size.width, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (![scrollView isKindOfClass:UITableView.class]) {
        [_timer invalidate];
        _timer = nil;
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(autoChangeBanner) userInfo:nil repeats:YES];
        float offsetX = scrollView.contentOffset.x == 0?_bannerCount*self.bounds.size.width:scrollView.contentOffset.x == (_bannerCount+1)*self.bounds.size.width?self.bounds.size.width:scrollView.contentOffset.x;
        [scrollView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
        _pageControl.currentPage = offsetX/self.bounds.size.width-1;
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (![scrollView isKindOfClass:UITableView.class]) {
        float offsetX = scrollView.contentOffset.x == 0?_bannerCount*self.bounds.size.width:scrollView.contentOffset.x == (_bannerCount+1)*self.bounds.size.width?self.bounds.size.width:scrollView.contentOffset.x;
        [scrollView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
        _pageControl.currentPage = offsetX/self.bounds.size.width-1;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (![scrollView isKindOfClass:UITableView.class]) {
        if (scrollView.contentOffset.x <= 0) {
            [scrollView setContentOffset:CGPointMake(_bannerCount*self.bounds.size.width, 0) animated:NO];
            _pageControl.currentPage = _bannerCount;
        }else if (scrollView.contentOffset.x >= (_bannerCount+1)*self.bounds.size.width){
            [scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
            _pageControl.currentPage = 0;
        }else if((int)scrollView.contentOffset.x % (int)self.bounds.size.width == 0){
            _pageControl.currentPage = scrollView.contentOffset.x/self.bounds.size.width-1;
        }
    }
}


@end
