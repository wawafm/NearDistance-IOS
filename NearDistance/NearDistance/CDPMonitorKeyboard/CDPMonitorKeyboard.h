//
//  CDPMonitorKeyboard.h
//  keyboard
//
//  Created by 柴东鹏 on 15/4/26.
//  Copyright (c) 2015年 CDP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



enum{
    CDPMonitorKeyboardDefaultMode=0,//一般模式(输入视图在主视图，即在self.view上)
    CDPMonitorKeyboardTableViewMode,//tableView模式(输入视图在tableView上且tableView父视图为主视图，即self.view)
    CDPMonitorKeyboardScrollViewMode,//scrollView模式(输入视图在scrollView上且scrollView父视图为主视图，即self.view)
};
typedef NSInteger CDPMonitorKeyboardMode;//模式





@protocol CDPMonitorKeyboardDelegate <NSObject>

//系统键盘出现时
-(void)didWhenKeyboardWillShow:(NSNotification *)notification;

//系统键盘消失时
-(void)didWhenKeyboardWillHide:(NSNotification *)notification;

@end




@interface CDPMonitorKeyboard : NSObject


@property (nonatomic,weak) id <CDPMonitorKeyboardDelegate> delegate;


//获取其单例
+(CDPMonitorKeyboard *)defaultMonitorKeyboard;

//自动监听调用方法(仅需调用一次，若果需要改变参数再调用)
//一般模式时superView传输入视图所在的主视图即可
//tableView模式时superView传输入视图所在的tableView
//scrollView模式时superView传输入视图所在的scrollView
//valueOfTheHigher为输入视图需要高出键盘的高度
//mode为当前需要的模式(目前共有三种)
//navigationControllerTopHeight为主视图的navigationBar高度+状态栏高度，如没有使用navigationController传0

-(void)sendValueWithSuperView:(UIView *)superView higherThanKeyboard:(NSInteger)valueOfHigher andMode:(CDPMonitorKeyboardMode)mode navigationControllerTopHeight:(NSInteger)topHeight;






@end
