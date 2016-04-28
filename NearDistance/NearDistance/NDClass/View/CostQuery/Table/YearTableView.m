//
//  YearTableView.m
//  NearDistance
//
//  Created by 李世超 on 15/10/16.
//  Copyright © 2015年 李世超. All rights reserved.
//

#import "YearTableView.h"
#import "CostQueryViewController.h"

@implementation YearTableView

#pragma mark tableView datasource
//子类可以覆盖父类中得这些方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"yearCell";
    _yearCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (_yearCell == nil) {
        _yearCell = [[[NSBundle mainBundle] loadNibNamed:@"YearCell" owner:self options:nil] lastObject];
        _yearCell.backgroundColor = [UIColor whiteColor];
//        _yearCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _yearCell.date = [self.data objectAtIndex:indexPath.row];
    return _yearCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!self.isMonth) {
        NSMutableArray *month = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
        self.data = month;
        [self reloadData];
        self.isMonth = YES;
    }else{
       _costModel = [[self costMutableArray] objectAtIndex:indexPath.row];
        
        CostQueryViewController *costQuery = [[CostQueryViewController alloc] init];
        costQuery.costModel = _costModel;
        [self.viewController.navigationController pushViewController:costQuery animated:YES];
        if([self.yearDelegate respondsToSelector:@selector(dismissYearView)]) {
            [self.yearDelegate dismissYearView];
        }
    }
}

- (NSMutableArray *)costMutableArray;
{
    _costArray = [NSMutableArray array];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"张**",@"owner",@"印象麦地-A栋-302",@"houseNum",@"2015.1",@"date",@"35.30",@"waterRate",@"420.72",@"electricBill",@"62.20",@"gasCharge",@"92.00",@"propertyCharges",@"260.00",@"parkingRate",@"0.00",@"generCharge",@"0.00",@"lateFee",@"870.22",@"totalRate", nil];
    NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"张**",@"owner",@"印象麦地-A栋-302",@"houseNum",@"2015.2",@"date",@"32.00",@"waterRate",@"439.45",@"electricBill",@"57.35",@"gasCharge",@"172.00",@"propertyCharges",@"260.00",@"parkingRate",@"0.00",@"generCharge",@"0.00",@"lateFee",@"960.80",@"totalRate", nil];
    NSDictionary *dict3 = [NSDictionary dictionaryWithObjectsAndKeys:@"张**",@"owner",@"印象麦地-A栋-302",@"houseNum",@"2015.3",@"date",@"39.30",@"waterRate",@"370.50",@"electricBill",@"51.46",@"gasCharge",@"172.00",@"propertyCharges",@"260.00",@"parkingRate",@"0.00",@"generCharge",@"0.00",@"lateFee",@"893.26",@"totalRate",nil];
    NSDictionary *dict4 = [NSDictionary dictionaryWithObjectsAndKeys:@"张**",@"owner",@"印象麦地-A栋-302",@"houseNum",@"2015.4",@"date",@"45.57",@"waterRate",@"392.40",@"electricBill",@"43.25",@"gasCharge",@"172.00",@"propertyCharges",@"260.00",@"parkingRate",@"0.00",@"generCharge",@"0.00",@"lateFee",@"913.22",@"totalRate", nil];
    NSDictionary *dict5 = [NSDictionary dictionaryWithObjectsAndKeys:@"张**",@"owner",@"印象麦地-A栋-302",@"houseNum",@"2015.5",@"date",@"42.65",@"waterRate",@"418.60",@"electricBill",@"48.90",@"gasCharge",@"172.00",@"propertyCharges",@"260.00",@"parkingRate",@"0.00",@"generCharge",@"0.00",@"lateFee", @"942.15",@"totalRate",nil];
    NSDictionary *dict6 = [NSDictionary dictionaryWithObjectsAndKeys:@"张**",@"owner",@"印象麦地-A栋-302",@"houseNum",@"2015.6",@"date",@"39.25",@"waterRate",@"467.05",@"electricBill",@"55.60",@"gasCharge",@"172.00",@"propertyCharges",@"260.00",@"parkingRate",@"0.00",@"generCharge",@"0.00",@"lateFee",@"993.90",@"totalRate", nil];
    NSDictionary *dict7 = [NSDictionary dictionaryWithObjectsAndKeys:@"张**",@"owner",@"印象麦地-A栋-302",@"houseNum",@"2015.7",@"date",@"52.60",@"waterRate",@"565.40",@"electricBill",@"42.86",@"gasCharge",@"172.00",@"propertyCharges",@"260.00",@"parkingRate",@"0.00",@"generCharge",@"0.00",@"lateFee",@"1092.86",@"totalRate", nil];
    NSDictionary *dict8 = [NSDictionary dictionaryWithObjectsAndKeys:@"张**",@"owner",@"印象麦地-A栋-302",@"houseNum",@"2015.8",@"date",@"55.79",@"waterRate",@"632.50",@"electricBill",@"54.52",@"gasCharge",@"172.00",@"propertyCharges",@"260.00",@"parkingRate",@"0.00",@"generCharge",@"0.00",@"lateFee",@"1174.81",@"totalRate", nil];
    NSDictionary *dict9 = [NSDictionary dictionaryWithObjectsAndKeys:@"张**",@"owner",@"印象麦地-A栋-302",@"houseNum",@"2015.9",@"date",@"58.80",@"waterRate",@"660.86",@"electricBill",@"67.90",@"gasCharge",@"172.00",@"propertyCharges",@"260.00",@"parkingRate",@"0.00",@"generCharge",@"0.00",@"lateFee",@"1219.56",@"totalRate", nil];
    NSDictionary *dict10 = [NSDictionary dictionaryWithObjectsAndKeys:@"张**",@"owner",@"印象麦地-A栋-302",@"houseNum",@"2015.10",@"date",@"56.35",@"waterRate",@"617.83",@"electricBill",@"64.23",@"gasCharge",@"172.00",@"propertyCharges",@"260.00",@"parkingRate",@"0.00",@"generCharge",@"0.00",@"lateFee",@"1170.41",@"totalRate", nil];
    [_costArray addObject:dict];
    [_costArray addObject:dict2];
    [_costArray addObject:dict3];
    [_costArray addObject:dict4];
    [_costArray addObject:dict5];
    [_costArray addObject:dict6];
    [_costArray addObject:dict7];
    [_costArray addObject:dict8];
    [_costArray addObject:dict9];
    [_costArray addObject:dict10];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in _costArray) {
        CostQueryModel *costModel = [[CostQueryModel alloc] initWithDictionary:dict];
        [array addObject:costModel];
    }
    return array;
}

#pragma mark - height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end
