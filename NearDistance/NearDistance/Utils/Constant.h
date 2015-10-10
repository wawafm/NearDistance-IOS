//
//  Constant.h
//  NearDistance
//
//  Created by wawa on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#ifdef DEBUG

#define NSLog(...) NSLog(__VA_ARGS__)

#else

#define NSLog(...)

#endif

//全局变量属性
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//图片
#define NAVIGATIONBAR_BACK_IMG    @"global_back"
#define NAVIGATIONBAR_BG7_IMG     @"global_navigation_7"
#define NAVIGATIONBAR_BG6_IMG     @"global_navigation_6"
#define NAVIGATIONBAR_LOGO_IMG    @"shouye-logo"
#define NAVIGATIONBAR_PUBLISH_IMG @"xinhuati"
#define MJREFRESH_IMG             @"refresh"

//颜色
#define kUIColorFromRGB(rgbValue)                                              \
  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0         \
                  green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0            \
                   blue:((float)(rgbValue & 0xFF)) / 255.0                     \
                  alpha:1.0]

#define kUIColorFromAlphaRGB(rgbValue)                                         \
  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0         \
                  green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0            \
                   blue:((float)(rgbValue & 0xFF)) / 255.0                     \
                  alpha:0.8]

//色值
//主色调
#define MAIN_COLOR      0x99cc33
//三种颜色  3  6  9
#define GRAY_COLOR      0x666666

//网络请求
#define AF_DISTRICT_URL @"http://m.dianping.com/huizhou"

#endif /* constant_h */
