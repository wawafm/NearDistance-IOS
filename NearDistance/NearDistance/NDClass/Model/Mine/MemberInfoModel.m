//
//  MemberInfoModel.m
//  NearDistance
//
//  Created by 李世超 on 15/10/22.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "MemberInfoModel.h"

@implementation MemberInfoModel

+(instancetype)memberInfo:(NSDictionary *)dict
{
    MemberInfoModel *memberInfo = [[self alloc] init];
    
    memberInfo.mid  = dict[@"id"];
    memberInfo.mobile = dict[@"mobile"];
    memberInfo.password   = dict[@"password"];
    memberInfo.address  = dict[@"address"];
    memberInfo.nickname  = dict[@"nickname"];
    memberInfo.headerphoto  = dict[@"headerphoto"];
    memberInfo.memberid  = dict[@"memberid"];
    memberInfo.address  = dict[@"address"];
    
    return memberInfo;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.mid forKey:@"id"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.headerphoto forKey:@"headerphoto"];
    [aCoder encodeObject:self.memberid forKey:@"memberid"];
    [aCoder encodeObject:self.address forKey:@"address"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.mid = [aDecoder decodeObjectForKey:@"mid"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.headerphoto = [aDecoder decodeObjectForKey:@"headerphoto"];
        self.memberid = [aDecoder decodeObjectForKey:@"memberid"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
    }
    return self;
}

@end
