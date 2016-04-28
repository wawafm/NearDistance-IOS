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
#define app         [[CommonUtil shareInstance] myDelegate]

#define MID         [USERDEFAULT objectForKey:@"M_ID"]
#define MEMBER      [USERDEFAULT objectForKey:@"member_session"]

#define AF_CODE     [app.resObject objectForKey:@"code"]
#define AF_MSG      [app.resObject objectForKey:@"msg"]

#define USERDEFAULT [NSUserDefaults standardUserDefaults]
//iPhone4
#define iPhone4 [UIScreen mainScreen].bounds.size.height<=480.0f
//iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPhone5S [UIScreen mainScreen].bounds.size.height<=568.0f
//iphone6
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)
//iphone6plus
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define NSNOTIFICATION [NSNotificationCenter defaultCenter]

//网络请求
#define AF_NAMESPACE                    @"http://scyd.wmin.cc"
#define AF_WEBURL                       @"http://scyd.wmin.cc"

//广告图
#define AF_AD_URL                       @"%@/ad/getAds"

//小区消息
#define AF_HOUSEMESS_URL                @"%@/news/getNews?pageindex=%i&pagesize=%i"

//报修图片上传
#define AF_REPAIRUPLOAD_URL             @"%@/repair/uploadPicture"

//报修
#define AF_REPAIR_URL                   @"%@/repair/createRepair?content=%@&memberid=%@&imagepath=%@"

//获取会员报修列表
#define AF_GETMEMBERREPAIR_URL           @"%@/repair/getRepairs?pageindex=xx&pagesize=xx&memberid=xx"

//获取报修内容
#define AF_GETALLREPAIR_URL              @"%@/repair/getRepairInfo?id=xx"

//房屋租赁
#define AF_RENT_URL                      @"http://m.fang.com/zf/huizhou/"

//今日特惠
#define AF_TODAY_URL    @"http://api.union.meituan.com/data/api?city=惠州&category=美食&limit=%i&district_name=惠城区&key=7715fcf5920382e453d94b8635332eb2965&keyword=全部&sort=1"

//投诉信箱
#define AF_COMPLAIN_URL                 @"%@/lodge/createLodge?content=%@&memberid=%@"


//商圈
#define AF_DISTRICT_URL @"http://m.dianping.com/huizhou"

//短信发送接口
#define AF_SMSSEND_URL                  @"%@/sms/sendSMS?mobile=%@"

//注册接口
#define AF_REGISTER_URL                 @"%@/member/createMember?mobile=%@&password=%@&code=%@"
//重置用户密码
#define AF_RESETPWD_URL                 @"%@/member/resetPassword?mobile=%@&password=%@&code=%@"

//用户登录
#define AF_LOGINUSER_URL                @"%@/member/memberLogin?mobile=%@&password=%@"

//昵称
#define AF_NICKNAME_URL                 @"%@/member/setNickName?memberid=%@&nickname=%@"

//头像上传图片
#define AF_MEMBERUPLOAD_URL             @"%@/member/uploadHeader"

#define AF_UPDATEFACE_URL               @"%@/member/saveHeaderPath?memberid=%@&headerphoto=%@"

//获取区域细信息
#define AF_GETAREAS_URL                 @"%@/area/getAreas"

//创建绑定信息
#define AF_CREATEBIND_URL               @"%@/binding/createBinding?memberid=%@&mobile=%@&property=%@&building=%@&room=%@"

//添加收货地址
#define AF_ADDRESS_URL                  @"%@/address/createAddress?name=%@&mobile=%@&city=%@&address=%@&postcode=%@&memberid=%@"

//修改收货地址
#define AF_UPDATEADDRESSS_URL           @"%@/address/updateAddress?name=%@&mobile=%@&city=%@&address=%@&postcode=%@&memberid=%@&id=%@"

//获取收货地址
#define AF_GETADDRESS_URL               @"%@/address/getAddresss?memberid=%@"

//删除收货地址
#define AF_DELETEADDRESS_URL            @"%@/address/deleteAddress?id=%@"

//关于邻距
#define AF_ABOUT_URL                    @"%@/help"

//发布话题上传图片
#define AF_UPLOAD_URL                   @"%@/article/uploadPicture"

//发布话题
#define AF_PUBLIC_URL                   @"%@/article/createArticle?content=%@&imagepath=%@&memberid=%@"

//获取文章列表
#define AF_GETTOPIC_URL                 @"%@/article/getArticles?pagesize=5&pageindex=%i&memberid=%@"

//获取全部文章列表
#define AF_ALLGETTOPIC_URL              @"%@/article/getArticles?pagesize=10&pageindex=%i"

//创建评论
#define AF_CREATECOMMENT_URL            @"%@/comment/createComment?content=%@&to=%@&from=%@&articleid=%@&restoreid=%i"

//获取评论列表
#define AF_GETCOMMENT_URL               @"%@/comment/getComments?articleid=%@&pagesize=10000000&pageindex=1"


//添加区域信息：/area/createArea?parentid=xx&name=xxx

//修改区域信息：/area/updateArea?parentid=4&name=2202&id=6

//区域信息列表：/area/getAreas?parentid=0
//
//创建绑定信息：/binding/createBinding?memberid=xx&mobile=xx&property=xx&building=xx&room=xx

//修改绑定信息：/binding/createBinding?memberid=xx&mobile=xx&property=xx&building=xx&room=xx&id=xx

//创建绑定信息：/binding/getBindingInfo?mobile=xx

#endif /* constant_h */
