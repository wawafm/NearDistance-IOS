//
//  CommonViews.m
//  NearDistance
//
//  Created by 李世超 on 15/10/28.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "CommonViews.h"

static CommonUtil *singleton;

@implementation CommonViews

+ (id)shareInstance
{
    if (singleton == nil) {
        singleton = [[[self class] alloc] init];
    }
    return singleton;
}

#pragma mark - 初始化动画
-(TYDotIndicatorView *)darckCircleDot:(CGFloat)pointY view:(UIView *)view
{
    darckCircleDot = [[TYDotIndicatorView alloc] initWithFrame:CGRectMake((ScreenWidth-100)/2, pointY, 100, 20) dotStyle:TYDotIndicatorViewStyleCircle dotColor:kUIColorFromRGB(MAIN_COLOR) dotSize:CGSizeMake(6, 6)];
    darckCircleDot.backgroundColor = [UIColor clearColor];
    [darckCircleDot stopAnimating];
    darckCircleDot.hidden = YES;
    darckCircleDot.layer.cornerRadius = 4.0f;
    [view addSubview:darckCircleDot];
    return darckCircleDot;
}

#pragma mark - 停止动画
- (void)stopHideAnimating
{
    darckCircleDot.hidden = YES;
    [darckCircleDot stopAnimating];
}

#pragma mark - 开始动画
- (void)startShowAnimating
{
    darckCircleDot.hidden = NO;
    [darckCircleDot startAnimating];
}

#pragma mark - 保存图片至沙盒
- (NSData *) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    //设置image的尺寸
    CGSize imagesize = currentImage.size;
    //对图片大小进行压缩--
    currentImage = [self imageWithImage:currentImage scaledToSize:imagesize];
    imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
    return imageData;
}

//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    //    newSize.height=image.size.height*(newSize.width/image.size.width);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (HYActivityView *)activityView:(UIView *)view title:(NSString *)title
{
    activityView = [[HYActivityView alloc]initWithTitle:title referView:view];
    activityView.numberOfButtonPerLine = 2;
    
    return activityView;
}

- (UIImagePickerController *)photoCarmer
{
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.allowsEditing = YES;
    return imagePickerController;
}

- (HyLoglnButton *)buttonView:(UIView *)view frame:(CGRect)frame
{
    HyLoglnButton *log = [[HyLoglnButton alloc] initWithFrame:frame];
    [log setBackgroundColor:kUIColorFromRGB(MAIN_COLOR)];
    [view addSubview:log];
    
    log.titleLabel.font = FONG_14;
    [log setTitle:@"登录" forState:UIControlStateNormal];
    return log;
}

- (BOOL)textField:(UITextField *)textField string:(NSString *)string view:(UIView *)view range:(NSRange)range
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUM] invertedSet];
    //限制输入6位数字
    if ([string isEqualToString:@"\n"]){
        return YES;
    }
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    UITextField *phoneText = (UITextField *)[view viewWithTag:10];
    if (phoneText == textField) {
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUM] invertedSet];
        if ([aString length] > 11) {
            return NO;
        }
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    
    UITextField *codeText = (UITextField *)[view viewWithTag:11];
    if (codeText == textField) {
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    
    UITextField *pwdText = (UITextField *)[view viewWithTag:12];
    if (pwdText == textField) {
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    
    return YES;
}


- (void)isAutoLayout:(UIView *)loginView regView:(UIView *)regView codeView:(UIButton *)codeView
{
    if (IPhone5S||iPhone5) {
        loginView.layer.cornerRadius = 17;
        regView.layer.cornerRadius = 17;
        codeView.titleLabel.font = FONG_8;
        codeView.layer.cornerRadius = 8;
        if (iPhone4) {
            loginView.layer.cornerRadius = 14;
            regView.layer.cornerRadius = 14;
            codeView.layer.cornerRadius = 7;
            codeView.titleLabel.font = FONG_8;
        }
    }
}


@end
