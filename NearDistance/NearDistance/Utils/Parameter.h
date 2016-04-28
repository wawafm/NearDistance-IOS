//
//  Parameter.h
//  music
//
//  Created by 李世超 on 15/1/24.
//  Copyright (c) 2015年 李世超. All rights reserved.
//

#ifndef music_Parameter_h
#define music_Parameter_h

//数字
#define NUM @"0123456789."
#define NUMPhone @"0123456789"
//字母
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

//字体大小
#define BOLDFONG_16         [UIFont boldSystemFontOfSize:16.0f]
#define BOLDFONG_15         [UIFont boldSystemFontOfSize:15.0f]
#define BOLDFONG_14         [UIFont boldSystemFontOfSize:14.0f]
#define BOLDFONG_13         [UIFont boldSystemFontOfSize:13.0f]
#define BOLDFONG_12         [UIFont boldSystemFontOfSize:12.0f]

#define FONG_16             [UIFont systemFontOfSize:16.0f]
#define FONG_18             [UIFont systemFontOfSize:18.0f]
#define FONG_15             [UIFont systemFontOfSize:15.0f]
#define FONG_14             [UIFont systemFontOfSize:14.0f]
#define FONG_13             [UIFont systemFontOfSize:13.0f]
#define FONG_12             [UIFont systemFontOfSize:12.0f]
#define FONG_11             [UIFont systemFontOfSize:11.0f]
#define FONG_10             [UIFont systemFontOfSize:10.0f]
#define FONG_9             [UIFont systemFontOfSize:9.0f]
#define FONG_8             [UIFont systemFontOfSize:8.0f]


#define STATEBAR_HEIGHT      20           //状态栏的高度
#define TABBAR_HEIGHTG       50           //自定义UITabBar的高度
#define TABBAR_HEIGHT        49           //自定义UITabBar的高度

#define TABBAR_BUTTON_WIDTH  ScreenWidth/4
#define TABBAR_BUTTON_HEIGHT 49

//常用参数配置

#define NAVIGATIONHEIGHT   64
#define TARBARHEIGHT       49
#define STATUSHEIGHT       20
#define IP5TARBBARHEIGHT   44
#define STATUSWIDHT        45
#define SEGMENTHEIGHT      35
#define TARBARLINEHEIGHT   48

//首页参数
#define HOME_LOOP_SIZE     184//首页轮播图高度
#define HOME_LOOP_SPACE    50
#define HOME_BUTTON_HEIGHT 56
#define HOME_BUTTON_WIDHT  56
#define HOME_BUTTONX_SPACE 40
#define HOME_BUTTONY_SPACE 25

#define WIDHT_SPACE        ScreenWidth/6-15 // 2个按钮之间的横间距
#define WIDHT6_SPACE       ScreenWidth/6
#define WIDHT6P_SPACE       ScreenWidth/6+12

// 2个按钮之间的横间距
#define HEIGHT_SPACE       40 // 竖间距
#define HOME_FUN_HEIGHT    240
#define HOME_OFFER_HEIGHT  130


#define LEFT_MARGIN      5
#define RIGHT_MARGIN     5

#define LEFT_BIG_MARGIN  10
#define LEFT_FACE_MARGIN 15
#define RIGHT_BIG_MARGIN 10

#define BOTTOM_MARGIN    10
#define VIEW_HEIGHT3     30
#define VIEW_HEIGHT2     20
//每页显示多少条
#define AF_PAGE_NUMBER   10

//0.分享 1.收藏 2.既分享又收藏
#define ISSHARE          0
#define ISFAV            1
#define FAVSHARE         2


//个人中心背景图高度
#define USER_BG_HEIGHT 234

//用户头像
#define USERCORNER     40/2
#define USERHEIGHT     40

#define REPLYCORNER    30/2
#define REPLYHEIGHT    30

//颜色
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kUIColorFromAlphaRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:0.8]


//色值
//主色调
#define MAIN_COLOR       0x99cc33
//三种颜色  3  6  9
#define BLACK_COLOR      0x333333
#define GRAY_COLOR       0x666666
#define GRAY_SMALL_COLOR 0x999999
#define LIGHTGRAY_COLOR  0xe5e5e5
#define BGGRAY           0xF5F5F5
#define WHITE            0xFFFFFF

#define TIP_COLOR        kUIColorFromRGB(0x7F7978)
#define SUCCESS_COLOR    kUIColorFromRGB(0x99cc33)
#define WARNNING_COLOR   kUIColorFromRGB(0xfa5459)

//图片
#define LOGIN_BACK_IMG            @"login_back"
#define NAVIGATIONBAR_BACK_IMG    @"global_back"
#define NAVIGATIONBAR_BG7_IMG     @"global_navigation_7"
#define NAVIGATIONBAR_BG6_IMG     @"global_navigation_6"
#define NAVIGATIONBAR_LOGO_IMG    @"shouye-logo"
#define NAVIGATIONBAR_PUBLISH_IMG @"xinhuati"
#define MJREFRESH_IMG             @"refresh"
#define HOME_COST_IMG             @"feiyongchaxun"
#define HOME_MESSAGE_IMG          @"xiaoquxiaoxi"
#define HOME_HELP_IMG             @"baoxiuqiuzhu"
#define HOME_RENT_IMG             @"fangwuzulin"
#define HOME_DISCOUNT_IMG         @"jinriyouhui"
#define HOME_MAIL_IMG             @"tousuxinxiang"
#define PERSON_CARMER             @"set_photograph_up.png"
#define PERSON_PHOTO              @"set_image_up.png"
#define INTERACT_REPLY_IMG        @"interact_reply"
#define MY_FACE_IMG               @"default_face"
#define DEFAULT_IMG               @"zanwu.jpg"

#define HOME_TABBAR_TITLE   @[@"首页",@"互动",@"商圈",@"我的"]

#define HOME_LOOP_IMG   @[@"ad",@"ad1",@"ad2",@"ad3"]

#define HOME_FUN_IMG    @[HOME_COST_IMG,HOME_MESSAGE_IMG,HOME_HELP_IMG,HOME_RENT_IMG,HOME_DISCOUNT_IMG,HOME_MAIL_IMG]

#define HOME_FUN_TITLE  @[@"费用查询",@"小区消息",@"报修求助",@"房屋租赁",@"今日优惠",@"投诉信箱"]

//接口返回JSON 状态
#define RequestLoginTimeOut   @"网络请求超时，登陆失败"
#define RequestTimeOut        @"网络请求超时"
//app.tip = @"姓名不能为空";

#define EMPTY_NAME          @"姓名不能为空"
#define EMPTY_PHONE         @"手机号不能为空"
#define EMPTY_CITY          @"省市不能为空"
#define EMPTY_ADDRESS       @"详细地址不能为空"
#define SUCCESS_SAVE        @"保存地址成功"
#define ISMATCH_PHONE       @"手机号码格式不正确"
#define EMPTY_CODE          @"手机验证码不能为空"
#define EMPTY_PWD           @"密码不能为空"

#endif
