//
//  PublishTopicViewController.m
//  NearDistance
//
//  Created by 李世超 on 15/10/9.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "RepairHelpViewController.h"
#import "BlockButton.h"
#import "CustomDialogView.h"

@interface RepairHelpViewController ()

@end

NSString *TMP_UPLOAD_IMG_PATH2 = @"";

@implementation RepairHelpViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [super setNavigationTitle:@"报修求助"];
    _scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
    [self assigmentXib];
    [self _initShareButton];
}

- (void)_initShareButton
{
    BlockButton *sendButton = [[BlockButton alloc] initWithFrame:CGRectMake(0, 0, 45, 30) title:@"发布"];
    [sendButton setBlock:^(BlockButton *button){
        if (_publishTextView.text.length==0) {
            [CommonUtil NotiTip:@"写点什么吧" color:TIP_COLOR];
        }else{
            if (_repairImgUrl==nil) {
                _repairImgUrl = @"";
            }
            [self httpRepairHelp:_publishTextView.text imgPath:_repairImgUrl memberID:MID];
        }
    }];
    UIBarButtonItem *sendBar = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    self.navigationItem.rightBarButtonItem = sendBar;
}

- (void)backAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - xib
- (void)assigmentXib
{
    _publishTextView.placeholder = @"写下你的报修求助内容...";
    _publishTextView.placeholderFont = FONG_13;
}
#pragma mark - 拍照
- (void)selectCarmerImage
{
    [_publishTextView resignFirstResponder];
    
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
    __unsafe_unretained RepairHelpViewController *repairCtrl = self;
    self.activityView = [[CommonViews shareInstance] activityView:self.view title:@"上传图片"];
    ButtonView *bv = [[ButtonView alloc] initWithText:@"拍摄" image:[UIImage imageNamed:PERSON_CARMER] handler:^(ButtonView *buttonView){
        repairCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
        [repairCtrl selectPhotoCarmer];
    }];
    [self.activityView addButtonView:bv];
    
    bv = [[ButtonView alloc] initWithText:@"相册" image:[UIImage imageNamed:PERSON_PHOTO] handler:^(ButtonView *buttonView){
        repairCtrl.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [repairCtrl selectPhotoCarmer];
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
    
    _selectImg.image = image;
    _selectImg.userInteractionEnabled = YES;
    _deleteButton.hidden = NO;
    UITapGestureRecognizer *imgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageAction:)];
    [_selectImg addGestureRecognizer:imgTap];
    
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
    app.httpUrl = [NSString stringWithFormat:AF_UPLOAD_URL,AF_WEBURL];
    [[[HttpAFNetworing shareInstance] httpMgr] POST:app.httpUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imgData
                                    name:imgName
                                fileName:fileName
                                mimeType:@"image/jpg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
        app.resObject = (NSDictionary *)responseObject;
        if ([AF_CODE isEqualToString:@"1"]) {
            _repairImgUrl = [app.resObject objectForKey:@"path"];
            [CommonUtil NotiTip:AF_MSG color:SUCCESS_COLOR];
        }else{
            [CommonUtil NotiTip:AF_MSG color:WARNNING_COLOR];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
    }];
}

#pragma mark - 报修求助
- (void)httpRepairHelp:(NSString *)content imgPath:(NSString *)imgPath memberID:(NSString *)memberID;
{
    [CommonUtil NavigationLoading:self.view];
    app.httpUrl = [NSString stringWithFormat:AF_REPAIR_URL,AF_WEBURL,content,memberID,imgPath];
    app.httpUrl = [app.httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"app.httpUrl:%@",app.httpUrl);
    [[[HttpAFNetworing shareInstance] httpMgr] GET:app.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        app.resObject = (NSDictionary *)responseObject;
        if ([AF_CODE isEqualToString:@"1"]) {
            [CommonUtil NotiTip:AF_MSG color:SUCCESS_COLOR];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [CommonUtil NotiTip:AF_MSG color:WARNNING_COLOR];
        }
        [[KIProgressViewManager manager] hideProgressView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"=====failure %@",error);
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
        [[KIProgressViewManager manager] hideProgressView];
    }];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [_publishTextView resignFirstResponder];
}

#pragma mark - UITextView delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSString *new = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger res = 140-[new length];
    _numberLabel.text = [NSString stringWithFormat:@"%d字",(int)res];
    if(res >= 0){
        return YES;
    }else{
        if (res<0) {
            _numberLabel.text = [NSString stringWithFormat:@"0字"];
            _publishTextView.text = [new substringToIndex:140];
            return NO;
        }
        return NO;
    }
}

- (IBAction)selectImgAction:(id)sender {
    [self selectCarmerImage];
}

- (IBAction)deleteAction:(id)sender {
    _selectImg.userInteractionEnabled = NO;
    _repairImgUrl = nil;
    _selectImg.image = [UIImage imageNamed:@""];
    _deleteButton.hidden = YES;
}

#pragma mark - actions
- (void)imageAction:(UITapGestureRecognizer *)sender {
    [[SJAvatarBrowser shareInstance] showImage:(UIImageView*)sender.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
