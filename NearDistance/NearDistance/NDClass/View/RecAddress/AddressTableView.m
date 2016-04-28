//
//  AddressTableView.m
//  NearDistance
//
//  Created by 李世超 on 15/10/20.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "AddressTableView.h"
#import "CreateAddressViewController.h"

@implementation AddressTableView

#pragma mark tableView datasource
//子类可以覆盖父类中得这些方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"addressCell";
    _addressCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (_addressCell == nil) {
        _addressCell = [[[NSBundle mainBundle] loadNibNamed:@"AddressCell" owner:self options:nil] lastObject];
        _addressCell.backgroundColor = [UIColor whiteColor];
        //        _yearCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _addressCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    _addressCell.addressModel = [self.data objectAtIndex:indexPath.row];
    return _addressCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _addressModel = [self.data objectAtIndex:indexPath.row];
    
    CreateAddressViewController *createCtrl = [[CreateAddressViewController alloc] init];
    createCtrl.addressModel = _addressModel;
    [self.viewController.navigationController pushViewController:createCtrl animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:
(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    _addressModel = [self.data objectAtIndex:indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.data removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
        if ([_addressDelegate respondsToSelector:@selector(deleteAddress:)]) {
            [_addressDelegate deleteAddress:_addressModel.addressID];
        }
    }
}

#pragma mark - height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
@end
