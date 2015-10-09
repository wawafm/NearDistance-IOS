//
//  NDButtonView.m
//  NearDistance
//
//  Created by wawa on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDButtonView.h"
#import "NDButton.h"

@interface NDButtonView ()

//选中的图片
@property (nonatomic,strong) NDButton *selectBtn;


@end

@implementation NDButtonView

+ (instancetype)buttonView{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [ super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    NSArray *arr = @[@"首页",@"互动",@"商圈",@"我的"];
    //创建按钮
    for (NSInteger index = 0; index < 4; index++) {
        
        NDButton *btn = [NDButton buttonWithType:UIButtonTypeCustom];
        
        NSString *strN = [NSString stringWithFormat:@"tubiao%zd-nojiaodian",index +1];
        NSString *strY = [NSString stringWithFormat:@"tubiao%zd-jiaodian",index +1];
        
        [btn setImage:[UIImage imageNamed:strY] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:strN] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn setTitle:arr[index] forState:UIControlStateNormal];
        [btn setTitleColor:kUIColorFromRGB(MAIN_COLOR) forState:UIControlStateSelected];
        [btn setTitleColor:kUIColorFromRGB(GRAY_COLOR) forState:UIControlStateNormal];
        
        [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 30, 20, 0)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(30, 0, 0, 24)];
        
        //监听点击
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        //标记
        btn.tag = index;
    
        [self addSubview:btn];
        //默认选中第一个
        if (index == 0) {
            self.selectBtn = btn;
            self.selectBtn.selected = YES;
        }
    }
}


- (void)clickBtn:(NDButton *)btn{
    DDLogWarn(@"点击了tabbar");
    self.selectBtn.selected = NO;
    self.selectBtn = btn;
    self.selectBtn.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(clickButtonWithIndex:)]) {
        [self.delegate clickButtonWithIndex:btn.tag];
    }
    
}

- (void)layoutSubviews{

    for (NSInteger i = 0 ; i < 4; i++) {
        NDButton *btn = self.subviews[i];
        btn.frame = CGRectMake(i * TABBAR_BUTTON_WIDTH, 0, TABBAR_BUTTON_WIDTH, TABBAR_HEIGHT);
    }
}

@end



