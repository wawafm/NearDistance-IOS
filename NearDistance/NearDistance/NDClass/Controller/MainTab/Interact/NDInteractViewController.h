//
//  NDInteractViewController.h
//  NearDistance
//
//  Created by wawa on 15/10/8.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseViewController.h"
#import "InteractTableView.h"
#import "YcKeyBoardView.h"
#import "InteractListModel.h"
#import "CommentModel.h"

@interface NDInteractViewController : NDBaseViewController<InteractTableDelegate,YcKeyBoardViewDelegate>
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    int                 replyTag;
}
@property (nonatomic,retain) NSString *isPublic;
@property (nonatomic,retain) NSMutableArray *commentArray;
@property (nonatomic,retain) CommentModel *commentModel;
@property (nonatomic,retain) NSString *refreshTop;
@property (nonatomic,retain) NSMutableArray *interactArray;
@property (nonatomic,retain) InteractListModel *interactModel;
@property (nonatomic,assign) CGFloat replyY;
@property (nonatomic,retain)NSString *replyID;
@property (nonatomic,strong) YcKeyBoardView *key;
//右边按钮
@property (nonatomic, strong) UIButton *rightButton;
@property (weak, nonatomic) IBOutlet InteractTableView *interactTableView;

@property (nonatomic,assign) CGFloat keyBoardHeight;
@property (nonatomic,assign) CGRect originalKey;
@property (nonatomic,assign) CGRect originalText;
@end
