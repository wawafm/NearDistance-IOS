//
//  BaseTableView.m
//  AutoParts
//
//  Created by 李世超 on 14-1-16.
//  Copyright (c) 2014年 李世超. All rights reserved.
//

#import "NDBaseTableView.h"

@interface NDBaseTableView() {
}

@end

@implementation NDBaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initViews];
    }
    return self;
}

-(void)awakeFromNib
{
    [self _initViews];
}

- (void)_initViews
{
    self.delegate = self;
    self.dataSource = self;
}

#pragma mark tableView datasource
//子类可以覆盖父类中得这些方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

//返回删除按钮的文本内容
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

@end
