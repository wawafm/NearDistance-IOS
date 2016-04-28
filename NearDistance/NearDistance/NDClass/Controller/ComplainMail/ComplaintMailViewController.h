//
//  AdviceViewController.h
//  music
//
//  Created by 李世超 on 15/5/28.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"
#import "PlaceholderTextView.h"

@interface ComplaintMailViewController : NDBaseViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet PlaceholderTextView *textView;
@property (nonatomic,retain)NSString *suggestUrl;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@end
