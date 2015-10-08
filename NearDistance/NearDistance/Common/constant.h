//
//  constant.h
//  NearDistance
//
//  Created by wawa on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#ifndef constant_h
#define constant_h

#ifdef DEBUG

#define NSLog(...) NSLog(__VA_ARGS__)

#else

#define NSLog(...)

#endif

#define kUIScreenWidth [UIScreen mainScreen].bounds.size.width
#define kUIScreenHeight [UIScreen mainScreen].bounds.size.height

#endif /* constant_h */
