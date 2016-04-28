//
//  InteractTableView.h
//  NearDistance
//
//  Created by 李世超 on 15/10/10.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "NDBaseTableView.h"
#import "InteractCell.h"
#import "InteractListModel.h"
#import "CommentModel.h"

@protocol InteractTableDelegate <NSObject>

//- (void)dotStartAnimating;

//- (void)dotStopAnimating;

@optional

-(void)replyInteract:(int)btnTag content:(NSString *)commentModel replyY:(CGFloat)replyY;

-(void)scrollIndex;
@end

@interface InteractTableView : NDBaseTableView

@property (nonatomic,retain) CommentModel *commentModel;
@property (nonatomic,retain) InteractListModel *interactModel;
@property (nonatomic,retain) InteractCell *interactCell;
@property (nonatomic,retain) NSString *replyContent;
@property (nonatomic ,assign) id<InteractTableDelegate>interactDelegate;
@end
