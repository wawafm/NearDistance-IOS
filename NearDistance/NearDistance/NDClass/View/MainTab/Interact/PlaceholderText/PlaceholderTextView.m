//
//  PlaceholderTextView.m
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import "PlaceholderTextView.h"

@interface PlaceholderTextView()<UITextViewDelegate>
{
    UILabel *PlaceholderLabel;
}

@end
@implementation PlaceholderTextView

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
    }
    return self;
}


- (void)awakeFromNib {
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChange:) name:UITextViewTextDidChangeNotification object:self];
//
    float left=7,top=1,hegiht=30;
//
    self.placeholderColor = kUIColorFromRGB(GRAY_COLOR);
    PlaceholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(left, top
                                                               , CGRectGetWidth(self.frame)-2*left, hegiht)];
    PlaceholderLabel.font=self.placeholderFont?self.placeholderFont:self.font;
    PlaceholderLabel.textColor=self.placeholderColor;
    [self addSubview:PlaceholderLabel];
    PlaceholderLabel.text=self.placeholder;

}
//光标高度
- (CGRect)caretRectForPosition:(UITextPosition *)position {
    CGRect originalRect = [super caretRectForPosition:position];
    originalRect.size.height = 18.;
    return originalRect;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)setPlaceholder:(NSString *)placeholder{
    if (placeholder.length == 0 || [placeholder isEqualToString:@""]) {
        PlaceholderLabel.hidden=YES;
    }
    else
        PlaceholderLabel.text=placeholder;
    _placeholder=placeholder;

    
}

-(void)DidChange:(NSNotification*)noti{
    
    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        PlaceholderLabel.hidden=YES;
    }
    
    if (self.text.length > 0) {
        PlaceholderLabel.hidden=YES;
    }
    else{
        PlaceholderLabel.hidden=NO;
    }
    
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [PlaceholderLabel removeFromSuperview];

}

@end
