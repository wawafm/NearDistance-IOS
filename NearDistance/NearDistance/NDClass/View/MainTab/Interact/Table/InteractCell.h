//
//  InteractCell.h
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReplyCommentTableView.h"
#import "InteractListModel.h"
#import "CommentModel.h"
#import "InsetsLabel.h"

@interface InteractCell : UITableViewCell
{
    NSAttributedString *attributedString;
}
@property (nonatomic,retain) CommentModel *commentModel;
@property (nonatomic,retain) NSMutableArray *commentArray;
@property (nonatomic,retain) InteractListModel *interactModel;
@property (weak, nonatomic) IBOutlet UIImageView *faceImg;

@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet InsetsLabel *remarkLabel;

@property (weak, nonatomic) IBOutlet UIImageView *topicImg;

@property (weak, nonatomic) IBOutlet UIView *timeBgView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;


@property (weak, nonatomic) IBOutlet ReplyCommentTableView *replyTableView;
@property (strong, nonatomic) UILabel *lineLabel;

@property (nonatomic,retain) NSString *replyContent;

- (void)_replyRelodData;

- (void)someIndexPath:(NSIndexPath *)indexPath;
@end
