//
//  NDMyViewController.m
//  NearDistance
//
//  Created by wawa on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDMyViewController.h"
#import "NickViewController.h"
#import "RecAddressViewController.h"
#import "CustomDialogView.h"
#import "SeniorMemberViewController.h"
#import "AboutViewController.h"
#import "NDLoginViewController.h"
#import "NDBaseNavigationController.h"

@interface NDMyViewController ()

@end

@implementation NDMyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"MyHeaderView" owner:self options:nil] lastObject];
    }
    return self;
}

#pragma mark - 视图即将出现
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    if ([_isNick isEqualToString:@"update"]) {
        [_headerView nickAssigment];
    }
    NSData *hunterData = MEMBER;
    _memberModel = [NSKeyedUnarchiver unarchiveObjectWithData:hunterData];
    
    if ([_isBind isEqualToString:@"bind"]) {
        [self.myTableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableDataSource];
    [self topHeaderView];
}

#pragma mark -设置tableView数据源
 - (void)tableDataSource
{
    _myTableView.myTabelDelegate = self;
    _myTableView.headerView = _headerView;
    _myTableView.tableHeaderView = _headerView;
    [self _initTitleArrys];
}

#pragma mark - 顶部headerView
- (void)topHeaderView
{
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight)];
    backgroundView.backgroundColor = kUIColorFromRGB(MAIN_COLOR);
    [self.myTableView addSubview:backgroundView];
}

#pragma mark - 标题data
- (void)_initTitleArrys
{
    NSMutableArray *titlesArray = [NSMutableArray arrayWithObjects:@"更新头像",@"修改昵称",@"高级会员(绑定房号使用高级功能)",@"收货地址",@"关于邻距",@"退出登录",nil];
    _myTableView.data = titlesArray;
}

#pragma mark - myTableDelegate
- (void)clickIndexPath:(NSInteger)index
{
    if (index==0) {
        [self selectCarmerPhoto];
    }else if (index==1){
        NickViewController *nickCtrl = [[NickViewController alloc] init];
        [self.navigationController pushViewController:nickCtrl animated:YES];
    }else if (index==2){
        SeniorMemberViewController *seniorMemeber = [[SeniorMemberViewController alloc] init];
        [self.navigationController pushViewController:seniorMemeber animated:YES];
    }else if (index==3){
        RecAddressViewController *receAddress = [[RecAddressViewController alloc] init];
        [self.navigationController pushViewController:receAddress animated:YES];
    }else if (index==4){
        AboutViewController *aboutCtrl = [[AboutViewController alloc] init];
        [self.navigationController pushViewController:aboutCtrl animated:YES];
    }else if (index==5){
        CustomDialogView *dialog = [[CustomDialogView alloc]initWithTitle:@"提示" message:@"确定退出登录吗？" buttonTitles:@"确定",@"取消", nil];
        [dialog showWithCompletion:^(NSInteger selectIndex) {
            NSLog(@"action selected %ld",selectIndex);
            if (selectIndex==0) {
                [self logoutLogin];
            }
        }];
    }
}

#pragma mark - 选择头像
- (void)selectCarmerPhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self alertPhtotoView];
    }else{
        CustomDialogView *dialog = [[CustomDialogView alloc]initWithTitle:@"提示" message:@"暂不支持摄像头拍照" buttonTitles:@"取消", nil];
        [dialog showWithCompletion:^(NSInteger selectIndex) {
        }];
    }
}

#pragma mark - 选择相册/拍摄
- (void)alertPhtotoView
{
    __unsafe_unretained NDMyViewController *editFace = self;
    self.activityView = [[CommonViews shareInstance] activityView:self.view title:@"设置头像"];
    ButtonView *bv = [[ButtonView alloc] initWithText:@"拍摄" image:[UIImage imageNamed:PERSON_CARMER] handler:^(ButtonView *buttonView){
        editFace.sourceType = UIImagePickerControllerSourceTypeCamera;
        [editFace selectPhotoCarmer];
    }];
    [self.activityView addButtonView:bv];
    
    bv = [[ButtonView alloc] initWithText:@"相册" image:[UIImage imageNamed:PERSON_PHOTO] handler:^(ButtonView *buttonView){
        editFace.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [editFace selectPhotoCarmer];
    }];
    [self.activityView addButtonView:bv];
    [self.activityView show];
}

#pragma mark - 弹出图片选择器
- (void)selectPhotoCarmer
{
    imagePickerController = [[CommonViews shareInstance] photoCarmer];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = _sourceType;
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        NSString *imageName = [CommonUtil generateUuidString];
        NSString *fileName = [NSString stringWithFormat:@"%@%@",imageName,@".jpg"];
        imageData = [[CommonViews shareInstance] saveImage:image withName:fileName];
        [self httpUploadImg:imageName fileName:fileName imgData:imageData];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - 图片上传
- (void)httpUploadImg:(NSString *)imgName fileName:(NSString *)fileName imgData:(NSData *)imgData
{
    app.httpUrl = [NSString stringWithFormat:AF_MEMBERUPLOAD_URL,AF_WEBURL];
    [[[HttpAFNetworing shareInstance] httpMgr] POST:app.httpUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imgData
                                    name:imgName
                                fileName:fileName
                                mimeType:@"image/jpg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        app.resObject = (NSDictionary *)responseObject;
        if ([AF_CODE isEqualToString:@"1"]) {
            [self httpResponseImg:responseObject];
        }else{
            [CommonUtil NotiTip:AF_MSG color:WARNNING_COLOR];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
    }];
}

#pragma mark - 更新头像数据
- (void)httpResponseImg:(id)resObject
{
    _faceImgUrl = [resObject objectForKey:@"path"];
    [_headerView.faceImg setImageWithURL:[NSURL URLWithString:_faceImgUrl] placeholderImage:[UIImage imageNamed:MY_FACE_IMG]];
    [self httpUpdateFaceImg:MID faceImg:_faceImgUrl];
    _memberModel.headerphoto = _faceImgUrl;
    [CommonUtil userDefaultModel:_memberModel modelKey:@"member_session"];
}

#pragma mark - 修改头像
- (void)httpUpdateFaceImg:(NSString *)userID faceImg:(NSString *)faceImg
{
    app.httpUrl = [NSString stringWithFormat:AF_UPDATEFACE_URL,AF_WEBURL,userID,faceImg];
    app.httpUrl = [app.httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[[HttpAFNetworing shareInstance] httpMgr] GET:app.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        app.resObject = (NSDictionary *)responseObject;
        if ([AF_CODE isEqualToString:@"1"]) {
            [CommonUtil NotiTip:AF_MSG color:TIP_COLOR];
        }else{
            [CommonUtil NotiTip:AF_MSG color:WARNNING_COLOR];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"=====failure %@",error);
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
    }];
}

#pragma mark - 退出登录
- (void)logoutLogin
{
    [USERDEFAULT removeObjectForKey:@"member_session"];
    [USERDEFAULT removeObjectForKey:@"M_ID"];
    NDLoginViewController *loginCtrl = [[NDLoginViewController alloc] init];
    NDBaseNavigationController *baseNav = [[NDBaseNavigationController alloc] initWithRootViewController:loginCtrl];
    [self.navigationController presentViewController:baseNav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
