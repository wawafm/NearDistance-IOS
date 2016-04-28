//
//  HYActivityView.m
//  Test
//
//  Created by Test on 13-11-6.
//  Copyright (c) 2013年 李世超. All rights reserved.
//

#import "HYActivityView.h"

#define BUTTON_VIEW_SIDE 80.f

#pragma mark - ButtonView

@interface ButtonView ()

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) ButtonViewHandler handler;

@end

@implementation ButtonView

- (id)initWithText:(NSString *)text image:(UIImage *)image handler:(ButtonViewHandler)handler
{
    self = [super init];
    if (self) {
        self.text = text;
        self.image = image;
        if (handler) {
            self.handler = handler;
            
        }
        
        [self setup];
        
    }
    return self;
    
}

- (void)setup
{
    self.textLabel = [[UILabel alloc]init];
    self.textLabel.text = self.text;
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.font = FONG_13;
    self.textLabel.textColor = kUIColorFromRGB(GRAY_COLOR);
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    
    self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.imageButton setImage:self.image forState:UIControlStateNormal];
    [self.imageButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //favmusic
    [self addSubview:self.textLabel];
    [self addSubview:self.imageButton];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *constraint = nil;
    NSDictionary *views = @{@"textLabel": self.textLabel, @"imageButton": self.imageButton};
    NSArray *constraints = nil;
    
    //view的宽高为70
    constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:BUTTON_VIEW_SIDE];
    [self addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:BUTTON_VIEW_SIDE];
    [self addConstraint:constraint];
    
    //label紧贴view的左右
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[textLabel]|" options:0 metrics:nil views:views];
    [self addConstraints:constraints];
    
    //imageView距离view左右各10, imageView的宽为50
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[imageButton(50)]-15-|" options:0 metrics:nil views:views];
    [self addConstraints:constraints];
    
    //竖直方向imageView和textLabel在一条直线上, 并且挨着, imageView的高为50
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageButton(40)][textLabel]-15-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views];
    [self addConstraints:constraints];
    
}

- (void)buttonClicked:(UIButton *)button
{
    if (self.handler) {
        self.handler(self);
        
    }
    
    if (self.activityView) {
        [self.activityView hide];
    }
}

@end

#define ICON_VIEW_HEIGHT_SPACE 8

#pragma mark - HYActivityView

@interface HYActivityView ()

@property (nonatomic, copy) NSString *title;

//将要显示在该视图上
@property (nonatomic, retain) UIView *referView;

//内容窗口
@property (nonatomic, strong) UIView *contentView;

//透明的关闭按钮
@property (nonatomic, strong) UIButton *closeButton;

//按钮加载的view
@property (nonatomic, strong) UIView *iconView;

//button数组
@property (nonatomic, strong) NSMutableArray *buttonArray;

//行数
@property (nonatomic, assign) int lines;

//目前正在生效的numberOfButtonPerLine
@property (nonatomic, assign) int workingNumberOfButtonPerLine;

//按钮间的间隔大小
@property (nonatomic, assign) CGFloat buttonSpace;

//消失的时候移除
@property (nonatomic, strong) NSLayoutConstraint *contentViewAndViewConstraint;

//iconView高度的constraint
@property (nonatomic, strong) NSLayoutConstraint *iconViewHeightConstraint;

//buttonView的constraints
@property (nonatomic, strong) NSMutableArray *buttonConstraintsArray;

@end

@implementation HYActivityView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    _referView = nil;
}

- (id)initWithTitle:(NSString *)title referView:(UIView *)referView
{
    self = [super init];
    if (self) {
        self.title = title;
        
        if (referView) {
            self.referView = referView;
        }
        [self setup];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
        
    }
    return self;
    
}

- (void)calculateButtonSpaceWithNumberOfButtonPerLine:(int)number
{
    self.buttonSpace = (self.referView.bounds.size.width - BUTTON_VIEW_SIDE * number) / (number + 1);
    
    if (self.buttonSpace < 0) {
        [self calculateButtonSpaceWithNumberOfButtonPerLine:4];
    } else {
        self.workingNumberOfButtonPerLine = number;
    }
}

- (void)setup
{
    self.buttonArray = [NSMutableArray array];
    self.buttonConstraintsArray = [NSMutableArray array];
    self.lines = 0;
    self.numberOfButtonPerLine = 4;
    self.useGesturer = YES;
    
    self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.9f];
    
    self.contentView = [[UIView alloc]init];
    self.bgColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0f];
    [self addSubview:self.contentView];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, 0.5)];
//    label.backgroundColor = kUIColorFromRGB(LIGHTGRAY);
//    [self.contentView addSubview:label];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeButton];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = FONG_15;
    self.titleLabel.textColor = kUIColorFromRGB(GRAY_COLOR);
    self.titleLabel.text = self.title;
    [self.contentView addSubview:self.titleLabel];
    
    _lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 148, ScreenWidth, 0.5)];
    _lineLabel.backgroundColor = kUIColorFromRGB(LIGHTGRAY_COLOR);
    [self.contentView addSubview:_lineLabel];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.backgroundColor = [UIColor whiteColor];
    self.cancelButton.showsTouchWhenHighlighted = YES;
//    [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"global_navigation_6"] forState:UIControlStateNormal];
    [self.cancelButton setTitle:@"取 消" forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = FONG_15;
    [self.cancelButton setTitleColor:kUIColorFromRGB(BLACK_COLOR) forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.cancelButton];
    
    self.iconView = [[UIView alloc]init];
    [self.contentView addSubview:self.iconView];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self setNeedsUpdateConstraints];
    
    //添加下滑关闭手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeHandler:)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipe];
    
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    NSArray *constraints = nil;
    NSLayoutConstraint *constraint = nil;
    NSDictionary *views = @{@"contentView": self.contentView, @"closeButton": self.closeButton, @"titleLabel": self.titleLabel, @"cancelButton": self.cancelButton, @"iconView": self.iconView, @"view": self, @"referView": self.referView};
    
    //view跟referView的宽高相等
    constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.referView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    [self.referView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.referView attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    [self.referView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.referView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    [self.referView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.referView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [self.referView addConstraint:constraint];
    
    //closeButton跟view的左右挨着
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[closeButton]|" options:0 metrics:nil views:views];
    [self addConstraints:constraints];
    
    //contentView跟view的左右挨着
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|" options:0 metrics:nil views:views];
    [self addConstraints:constraints];
    
    //垂直方向closeButton挨着contentView
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[closeButton(==view@999)][contentView]" options:0 metrics:nil views:views];
    [self addConstraints:constraints];
    
    //titleLabel跟contentView左右挨着
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]|" options:0 metrics:nil views:views];
    [self.contentView addConstraints:constraints];
    
    //cancelButton跟contentView左右挨着
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[cancelButton]|" options:0 metrics:nil views:views];
    [self.contentView addConstraints:constraints];
    
    //iconView跟contentView左右挨着
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[iconView]|" options:0 metrics:nil views:views];
    [self.contentView addConstraints:constraints];
    
    //iconView的高度
    if (self.iconViewHeightConstraint) {
        [self.iconView removeConstraint:self.iconViewHeightConstraint];
        
    }
    //加了64
    self.iconViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.lines * BUTTON_VIEW_SIDE + (self.lines + 1) * ICON_VIEW_HEIGHT_SPACE-12];
    [self.iconView addConstraint:self.iconViewHeightConstraint];
    
    //垂直方向titleLabel挨着iconView挨着cancelButton
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-7-[titleLabel(==30)]-[iconView]-[cancelButton(==44)]-0-|" options:0 metrics:nil views:views];
    [self.contentView addConstraints:constraints];
    
    _lineLabel.top = 136;
}

- (void)prepareForShow
{
    //计算行数
    int count = (int)[self.buttonArray count];
    self.lines = count / self.workingNumberOfButtonPerLine;
    if (count % self.workingNumberOfButtonPerLine != 0) {
        self.lines++;
        
    }
    
    for (int i = 0; i < [self.buttonArray count]; i++) {
        ButtonView *buttonView = [self.buttonArray objectAtIndex:i];
        [self.iconView addSubview:buttonView];
        
        int y = i / self.workingNumberOfButtonPerLine;
        int x = i % self.workingNumberOfButtonPerLine;
        
        //排列buttonView的位置
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:buttonView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeTop multiplier:1 constant:(y + 1) * ICON_VIEW_HEIGHT_SPACE + y * BUTTON_VIEW_SIDE];
        [self.iconView addConstraint:constraint];
        [self.buttonConstraintsArray addObject:constraint];

        constraint = [NSLayoutConstraint constraintWithItem:buttonView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.iconView attribute:NSLayoutAttributeLeading multiplier:1 constant:(x + 1) * self.buttonSpace + x * BUTTON_VIEW_SIDE];
        [self.iconView addConstraint:constraint];
        [self.buttonConstraintsArray addObject:constraint];

    }
    
    [self layoutIfNeeded];
    
}

- (void)show
{
    
    if (self.isShowing) {
        return;
        
    }
    
    [self.referView addSubview:self];
    [self setNeedsUpdateConstraints];
    self.alpha = 0;
    
    [self prepareForShow];
    
    self.contentViewAndViewConstraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self addConstraint:self.contentViewAndViewConstraint];
    
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 1;
        [self layoutIfNeeded];
        self.show = YES;
        
    }];
    [CommonUtil registerNotice:@"hide_tabbar" object:@"hideTabbar"];
}

- (void)hide
{
    if (!self.isShowing) {
        return;
    }
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 0;
        [self removeConstraint:self.contentViewAndViewConstraint];
        self.contentViewAndViewConstraint = nil;
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        self.show = NO;
        [self removeFromSuperview];
        
    }];
    [CommonUtil registerNotice:@"hide_tabbar" object:@"showTabbar"];
}

- (void)deviceRotate:(NSNotification *)notification
{
    [self.iconView removeConstraints:self.buttonConstraintsArray];
    [self.buttonConstraintsArray removeAllObjects];
    
    [self calculateButtonSpaceWithNumberOfButtonPerLine:self.numberOfButtonPerLine];
    [self prepareForShow];
    
    [self.iconView removeConstraint:self.iconViewHeightConstraint];
    //加64
    self.iconViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.iconView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.lines * BUTTON_VIEW_SIDE + (self.lines + 1) * ICON_VIEW_HEIGHT_SPACE-12];
    [self.iconView addConstraint:self.iconViewHeightConstraint];
    
}

- (void)setNumberOfButtonPerLine:(int)numberOfButtonPerLine
{
    _numberOfButtonPerLine = numberOfButtonPerLine;
    [self calculateButtonSpaceWithNumberOfButtonPerLine:numberOfButtonPerLine];
    
}

- (void)setBgColor:(UIColor *)bgColor
{
    _bgColor = bgColor;
    self.contentView.backgroundColor = bgColor;
    
}

- (void)addButtonView:(ButtonView *)buttonView
{
    [self.buttonArray addObject:buttonView];
    buttonView.activityView = self;
    
}

- (void)closeButtonClicked:(UIButton *)button
{
    [self hide];
    
}

- (void)swipeHandler:(UISwipeGestureRecognizer *)swipe
{
    if (self.useGesturer) {
        [self hide];
        
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
