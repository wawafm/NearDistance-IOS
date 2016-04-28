//
//  MyTableViewCell.h
//  NearDistance
//
//  Created by 李世超 on 15/10/14.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger, Test1){
//    CellType0,
//    CellType1,
//} CellType;

@interface MyTableViewCell : UITableViewCell

//@property (nonatomic, assign) CellType type;
@property (nonatomic,retain) NSString *myText;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;

- (void)someIndexPath:(NSIndexPath *)indexPath;
@property (weak, nonatomic) IBOutlet UILabel *bindLabel;

@end
