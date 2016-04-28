//
//  RoomModel.h
//  NearDistance
//
//  Created by 李世超 on 15/10/27.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoomModel : NSObject

@property (nonatomic,copy) NSString *roomID;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *parentID;

+(instancetype)RoomModelWithDict:(NSDictionary *)dict;
@end
