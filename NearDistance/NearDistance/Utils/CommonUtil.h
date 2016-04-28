//
//  CommonUtil.h
//  BmobIMDemo
//
//  Created by Bmob on 14-6-25.
//  Copyright (c) 2014年 bmob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InteractListModel.h"
#import "CommentModel.h"
#import "InsetsLabel.h"

typedef void (^buttonBlock)(UIButton *button);

@interface CommonUtil : NSObject
{

    NSMutableAttributedString    *attributeString;
    NSAttributedString           *attributedString;
    
    UILabel *tipLabel;
    UIImageView *tipImg;
}

+ (id)shareInstance;

#pragma mark
+(NSString*)turnToEmojiTextWithString:(NSString *)string;
#pragma mark - 时间戳转换时间
+(NSString *)timeIntervalTurnDate:(NSString *)string;
+(NSString *)MonthIntervalTurnDate:(NSString *)string;
#pragma mark - 获取时间
+(NSString *)getLocalTime;

+(NSString*)TimeformatFromSeconds:(int)seconds;

+(NSString*)TotalTimeformatFromSeconds:(int)seconds;

+(NSString*)changeTime:(NSDate*)onedate toDateString:(NSString*)str;
+(void)date;
+(NSString*)dateChangeFormatAt:(NSString *)createdAt;

+(void)registerNotice:(NSString *)keyString object:(NSObject*)object;

- (NSAttributedString *)labelContent:(NSString *)content;

- (NSAttributedString *)labelInteractContent:(NSString *)content;

+ (NSString *)generateUuidString;

- (NSMutableAttributedString *)attributeString:(NSString *)content;

//判断是否有网络
+(BOOL)connectedToNetwork;

-(BOOL)isChineseCharacterAndLettersAndNumbersAndUnderScore:(NSString *)string;

- (void)distance;


//正则判断手机号是否合法
- (BOOL)regexPhone:(NSString *)phoneNum;

+(void)NotiTip:(NSString *)tip color:(UIColor *)color;

+(id)StringTurnJSON:(NSString *)jsonStr;

- (AppDelegate *)myDelegate;

+(UIViewController *)popCtrl:(UIViewController *)rootCtrl count:(int)count;

+(void)userDefaultModel:(id)model modelKey:(NSString *)key;

-(CGFloat)tableViewHeight:(InteractListModel *)interactModel;

+(void)NavigationLoading:(UIView *)view;

- (void)unInteractContent:(UIView *)view point:(CGFloat)point title:(NSString *)title isShow:(BOOL)show;

@end
