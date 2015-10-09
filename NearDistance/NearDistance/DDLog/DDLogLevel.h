//
//  DDLogLevel.h
//  NearDistance
//
//  Created by 李世超 on 15/9/24.
//  Copyright © 2015年 li shichao. All rights reserved.
//

#ifndef DDLogLevel_h
#define DDLogLevel_h

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;

#else
static const DDLogLevel ddLogLevel = DDLogLevelOff;
#endif

#endif /* Common_h */
