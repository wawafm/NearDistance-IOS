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
        
        [btn setTitle:arr[index] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:142/255.0 green:197/255.0 blue:44/255.0 alpha:1.0] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 20, 0)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(30, 0, 0, 30)];
        
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
    NSLog(@"点击了tabbar");
    self.selectBtn.selected = NO;
    self.selectBtn = btn;
    self.selectBtn.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(clickButtonWithIndex:)]) {
        [self.delegate clickButtonWithIndex:btn.tag];
    }
    
}

- (void)layoutSubviews{
    //135  72
    CGFloat btnW = [UIScreen mainScreen].bounds.size.width / 4;
//    CGFloat btnW = 135;
    CGFloat btnH = 49;
//    CGFloat jianGe = ([UIScreen mainScreen].bounds.size.width - btnW * 4)/ 5;
    for (NSInteger i = 0 ; i < 4; i++) {
        NDButton *btn = self.subviews[i];
        btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        
    }
}

@end



