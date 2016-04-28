//
//  PublishTopicViewController.h
//  NearDistance
//
//  Created by 李世超 on 15/10/9.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"
#import "PlaceholderTextView.h"
#import "HYActivityView.h"


@protocol TopicDelegate <NSObject>

- (void)isPublicSuccess;

@end
@interface PublishTopicViewController : NDBaseViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    NSData *imageData;
    UIView *topView;
    UILabel *titleLabel;
    UIImagePickerController *imagePickerController;
}
@property (nonatomic,assign)int sourceType;
@property (nonatomic,retain) NSString *publicImgUrl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain)HYActivityView *activityView;
@property (weak, nonatomic) IBOutlet PlaceholderTextView *publishTextView;
@property (weak, nonatomic) IBOutlet UIView *editBar;
@property (weak, nonatomic) IBOutlet UIImageView *selectImg;
- (IBAction)selectImgAction:(id)sender;
- (IBAction)deleteAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (nonatomic,assign) id<TopicDelegate> topicDelegate;
@end
