//
//  FunctionView.m
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "FunctionView.h"
#import "TodayOfferViewController.h"
#import "HouseMessageViewController.h"
#import "HouseRentViewController.h"
#import "ComplaintMailViewController.h"
#import "RepairHelpViewController.h"

@implementation FunctionView

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images titles:(NSArray *)titles
{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.userInteractionEnabled = YES;
        self.images = images;
        self.titles = titles;
        [self steup];
    }
    return self;
}

#pragma mark - 初始化grid视图
- (void)steup
{
    for (int i=0; i<self.images.count; i++) {
        NSInteger index = i % 3;
        NSInteger page = i / 3;
        _funButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _funButton.frame = CGRectMake(index*(HOME_BUTTON_HEIGHT + WIDHT_SPACE) + HOME_BUTTONX_SPACE, page  * (HOME_BUTTON_HEIGHT + HEIGHT_SPACE)+HOME_BUTTONY_SPACE, HOME_BUTTON_WIDHT, HOME_BUTTON_HEIGHT);
        [self homeButtonLayout:index view:_funButton];
        _funButton.tag = i;
        _funButton.showsTouchWhenHighlighted = YES;
        [_funButton setBackgroundImage:[UIImage imageNamed:[_images objectAtIndex:_funButton.tag]] forState:UIControlStateNormal];
        [_funButton addTarget:self action:@selector(funAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_funButton];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(index*(HOME_BUTTON_WIDHT + WIDHT_SPACE) + STATUSWIDHT, page  * (HOME_BUTTON_HEIGHT + HEIGHT_SPACE)+HOME_BUTTONX_SPACE*2, 150, 30)];
        [self homeTitleLayout:index view:_titleLabel];
        _titleLabel.font = FONG_12;
        _titleLabel.text = self.titles[i];
        _titleLabel.textColor = kUIColorFromRGB(MAIN_COLOR);
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];
    }
    
    _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(STATUSHEIGHT, _titleLabel.bottom+LEFT_BIG_MARGIN, ScreenWidth-STATUSHEIGHT*2, .5)];
    _lineLabel.backgroundColor = kUIColorFromRGB(MAIN_COLOR);
    [self addSubview:_lineLabel];
    
    _colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(STATUSHEIGHT, _lineLabel.bottom, 8, 25)];
    _colorLabel.backgroundColor = kUIColorFromRGB(MAIN_COLOR);
    [self addSubview:_colorLabel];
    
    _todayTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_colorLabel.right+5, _lineLabel.bottom+3, 100, STATUSHEIGHT)];
    _todayTitleLabel.textColor = kUIColorFromRGB(MAIN_COLOR);
    _todayTitleLabel.text = @"今日团购";
    _todayTitleLabel.font = FONG_14;
    [self addSubview:_todayTitleLabel];
}

- (void)homeTitleLayout:(NSInteger)index view:(UIView *)view
{
    if (iPhone6) {
        view.left = index*(HOME_BUTTON_HEIGHT + WIDHT6_SPACE)+STATUSWIDHT;
    }
    if (iPhone6plus) {
        view.left = index*(HOME_BUTTON_HEIGHT + WIDHT6P_SPACE)+STATUSWIDHT;
    }
    if (iPhone5||IPhone5S) {
        view.left = index*(HOME_BUTTON_HEIGHT + WIDHT_SPACE)+STATUSWIDHT;
    }
}

- (void)homeButtonLayout:(NSInteger)index view:(UIView *)view
{
    if (iPhone6) {
        view.left = index*(HOME_BUTTON_HEIGHT + WIDHT6_SPACE)+HOME_BUTTONX_SPACE;
    }
    if (iPhone6plus) {
        view.left = index*(HOME_BUTTON_HEIGHT + WIDHT6P_SPACE)+HOME_BUTTONX_SPACE;
    }
    if (iPhone5||IPhone5S) {
        view.left = index*(HOME_BUTTON_HEIGHT + WIDHT_SPACE)+HOME_BUTTONX_SPACE;
    }
}

#pragma mark - 今日优惠
- (void)funAction:(UIButton *)sender
{
    if (sender.tag==0) {
        if ([self.dismissTag isEqualToString:@"dismiss"]) {
            sender.selected = !sender.selected;
        }
        if (sender.selected) {
            [UIView animateWithDuration:0.3f animations:^{
                [_yearTable setFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight-NAVIGATIONHEIGHT-TABBAR_HEIGHTG)];
                _yearTable = nil;
            }];
        }else{
            if (_yearTable==nil) {
                _yearTable = [[YearTableView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight-NAVIGATIONHEIGHT-TABBAR_HEIGHTG) style:UITableViewStylePlain];
                _yearTable.userInteractionEnabled = YES;
                _yearTable.yearDelegate = self;
            }
            
            _yearTable.backgroundColor = kUIColorFromRGB(BGGRAY);
            _yearTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            _yearTable.alpha = 0.9;
            NSMutableArray *year = [NSMutableArray arrayWithObjects:@"2015",nil];
            _yearTable.data = year;
            [self.viewController.view addSubview:_yearTable];
            [_yearTable reloadData];
            [UIView animateWithDuration:0.3f animations:^{
                [_yearTable setFrame:CGRectMake(100, 0, ScreenWidth, ScreenHeight-NAVIGATIONHEIGHT-TABBAR_HEIGHTG)];
            }];
        }
        self.dismissTag = nil;
        sender.selected = !sender.selected;
    }else if (sender.tag==1){
        HouseMessageViewController *houseMessage = [[HouseMessageViewController alloc] init];
        [self.viewController.navigationController pushViewController:houseMessage animated:YES];
    }else if (sender.tag==2){
        RepairHelpViewController *repairHelp = [[RepairHelpViewController alloc] init];
        [self.viewController.navigationController pushViewController:repairHelp animated:YES];
    }else if (sender.tag==3){
        HouseRentViewController *houseRent = [[HouseRentViewController alloc] init];
        [self.viewController.navigationController pushViewController:houseRent animated:YES];
    }else if (sender.tag==4) {
        TodayOfferViewController *todayOffer = [[TodayOfferViewController alloc] init];
        [self.viewController.navigationController pushViewController:todayOffer animated:YES];
    }else if (sender.tag==5) {
        ComplaintMailViewController *adviceCtrl = [[ComplaintMailViewController alloc] initWithNibName:@"ComplaintMailViewController" bundle:nil];
        [self.viewController.navigationController pushViewController:adviceCtrl animated:YES];
    }
}

#pragma mark -year delegate
- (void)dismissYearView
{
    [UIView animateWithDuration:0.3f animations:^{
        [_yearTable setFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight-NAVIGATIONHEIGHT-TABBAR_HEIGHTG)];
        self.dismissTag = @"dismiss";
        _yearTable = nil;
    }];
}

@end
