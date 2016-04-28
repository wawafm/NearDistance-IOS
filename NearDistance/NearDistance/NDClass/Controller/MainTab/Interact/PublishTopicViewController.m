//
//  PublishTopicViewController.m
//  NearDistance
//
//  Created by 李世超 on 15/10/9.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "PublishTopicViewController.h"
#import "BlockButton.h"
#import "CustomDialogView.h"
#import "NDInteractViewController.h"

@interface PublishTopicViewController ()

@end

@implementation PublishTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setNavigationTitle:@"发布新话题"];
    
    [self assigmentXib];
    [self _initPublicTopicButton];
}

#pragma mark - navigationBar custom
- (void)_initPublicTopicButton
{
    topView = [[UIView alloc] initWithFrame:CGRectZero];
    topView.frame = CGRectMake(0, 0, ScreenWidth, NAVIGATIONHEIGHT);
    topView.backgroundColor = [UIColor whiteColor];
    
    BlockButton *backButton = [[BlockButton alloc] initWithFrame:CGRectMake(15, 30, 45, 25) title:@"public"];
    [backButton setBlock:^(BlockButton *button){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [topView addSubview:backButton];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-65)/2, 30, 65, 25)];
    titleLabel.text = @"发布话题";
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = FONG_16;
    titleLabel.textColor = kUIColorFromRGB(BLACK_COLOR);
    [topView addSubview:titleLabel];
    
    //发布按钮
    BlockButton *sendButton = [[BlockButton alloc] initWithFrame:CGRectMake(ScreenWidth-57, 30, 45, 30) title:@"发布"];
    [sendButton setBlock:^(BlockButton *button){
        if (_publishTextView.text.length==0) {
            [CommonUtil NotiTip:@"写点什么吧" color:TIP_COLOR];
        }else{
            if (_publicImgUrl==nil) {
                _publicImgUrl = @"";
            }
            [self httpPublicTopic:_publishTextView.text imgPath:_publicImgUrl memberID:MID];
        }
    }];
    [topView addSubview:sendButton];
    [self.view addSubview:topView];
}

#pragma mark - xib
- (void)assigmentXib
{
    _scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
    _publishTextView.placeholder = @"写你所想...";
    _publishTextView.placeholderFont = FONG_13;
}

#pragma mark - 选择图片
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
    __unsafe_unretained PublishTopicViewController *topic = self;
    self.activityView = [[CommonViews shareInstance] activityView:self.view title:@"上传图片"];
    ButtonView *bv = [[ButtonView alloc] initWithText:@"拍摄" image:[UIImage imageNamed:PERSON_CARMER] handler:^(ButtonView *buttonView){
        topic.sourceType = UIImagePickerControllerSourceTypeCamera;
        [topic selectPhotoCarmer];
    }];
    [self.activityView addButtonView:bv];
    
    bv = [[ButtonView alloc] initWithText:@"相册" image:[UIImage imageNamed:PERSON_PHOTO] handler:^(ButtonView *buttonView){
        topic.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [topic selectPhotoCarmer];
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
        app.resObject = (NSDictionary *)responseObject;
        if ([AF_CODE isEqualToString:@"1"]) {
            _publicImgUrl = [responseObject objectForKey:@"path"];
            [CommonUtil NotiTip:AF_MSG color:SUCCESS_COLOR];
        }else{
            [CommonUtil NotiTip:AF_MSG color:WARNNING_COLOR];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - 发布话题
- (void)httpPublicTopic:(NSString *)content imgPath:(NSString *)imgPath memberID:(NSString *)memberID;
{
    app.httpUrl = [NSString stringWithFormat:AF_PUBLIC_URL,AF_WEBURL,content,imgPath,memberID];
    app.httpUrl = [app.httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[[HttpAFNetworing shareInstance] httpMgr] GET:app.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        app.resObject = (NSDictionary *)responseObject;
        if ([AF_CODE isEqualToString:@"1"]) {
            [CommonUtil NotiTip:AF_MSG color:SUCCESS_COLOR];
            [self.topicDelegate isPublicSuccess];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [CommonUtil NotiTip:AF_MSG color:WARNNING_COLOR];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"=====failure %@",error);
        [CommonUtil NotiTip:RequestTimeOut color:TIP_COLOR];
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
    _publicImgUrl = nil;
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
