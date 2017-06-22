//
//  YLDataConfiguration.m
//  YLAwesomePicker
//
//  Created by TK-001289 on 2017/6/15.
//  Copyright © 2017年 TK-001289. All rights reserved.
//

#import "YLDataConfiguration.h"
#import "YLAwesomeData.h"

@interface YLDataConfiguration ()
@property(nonatomic,copy,readwrite)NSDictionary *dataSource;///< ex: @{@0:@[data0,data1...]}
@property(nonatomic,assign)YLDataConfigType type;
@property(nonatomic,copy)NSArray *allMonths;///< 12~1
@property(nonatomic,copy)NSArray *currentMonths;///< currentMonth ~ 1
@end

@implementation YLDataConfiguration
- (instancetype)initWithType:(YLDataConfigType)type selectedData:(NSArray *)selectedData
{
    if(self = [super init]){
        self.type = type;
        [self getDefaultDataWithType:type];
        self.selectedData = selectedData;
    }
    return self;
}

- (instancetype)initWithData:(NSDictionary *)dataDic selectedData:(NSArray *)selectedData
{
    if(self = [super init]){
        self.dataSource = dataDic;
        self.selectedData = selectedData;
    }
    return self;
}

- (void)getDefaultDataWithType:(YLDataConfigType)type
{
    switch (type) {
        case YLDataConfigTypeGender:{
            YLAwesomeData *data0 = [[YLAwesomeData alloc]initWithId:0 name:@"男"];
            YLAwesomeData *data1 = [[YLAwesomeData alloc]initWithId:1 name:@"女"];
            self.dataSource = @{@0:@[data0,data1]};
        }
            break;
        case YLDataConfigTypeAcademic:{
            NSArray *names = @[@"小学",@"初中",@"高中",@"大专",@"本科",@"硕士",@"博士",@"博士后"];
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:names.count];
            for(NSInteger i = 0; i < names.count; i++){
                YLAwesomeData *data = [[YLAwesomeData alloc]initWithId:i name:names[i]];
                [array addObject:data];
            }
            self.dataSource = @{@0:array};
        }
            break;
        case YLDataConfigTypeWorkYear:{
            NSArray *names = @[@"应届毕业生",@"1~3年",@"3~5年",@"5~10年",@"10年以上"];
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:names.count];
            for(NSInteger i = 0; i < names.count; i++){
                YLAwesomeData *data = [[YLAwesomeData alloc]initWithId:i name:names[i]];
                [array addObject:data];
            }
            self.dataSource = @{@0:array};
        }
            break;
        case YLDataConfigTypeStartTime:{
            NSDateComponents *dateComponents = [self currentDateComponents];
            NSInteger year = dateComponents.year;
            NSInteger month = dateComponents.month;
            
            NSMutableArray *years = [NSMutableArray array];
            for(NSInteger i = year; i >= 1990; i--){
                YLAwesomeData *data = [[YLAwesomeData alloc]initWithId:i name:[NSString stringWithFormat:@"%li",i]];
                [years addObject:data];
            }
            NSMutableArray *months = [NSMutableArray arrayWithCapacity:12];
            NSMutableArray *currentMonths = [NSMutableArray arrayWithCapacity:month];
            for(NSInteger j = 12; j > 0; j--){
                YLAwesomeData *data = [[YLAwesomeData alloc]initWithId:j name:[NSString stringWithFormat:@"%li",j]];
                [months addObject:data];
                if(j <= month){
                    [currentMonths addObject:data];
                }
            }
            self.allMonths = months;
            self.currentMonths = currentMonths;
            self.dataSource = @{@0:years,@1:months};
        }
            break;
        case YLDataConfigTypeEndTime:{
            NSDateComponents *dateComponents = [self currentDateComponents];
            NSInteger year = dateComponents.year;
            NSInteger month = dateComponents.month;
            
            NSMutableArray *years = [NSMutableArray array];
            [years addObject:[[YLAwesomeData alloc]initWithId:0 name:@"至今"]];
            for(NSInteger i = year; i >= 1990; i--){
                YLAwesomeData *data = [[YLAwesomeData alloc]initWithId:i name:[NSString stringWithFormat:@"%li",i]];
                [years addObject:data];
            }
            NSMutableArray *months = [NSMutableArray arrayWithCapacity:12];
            NSMutableArray *currentMonths = [NSMutableArray arrayWithCapacity:month];
            for(NSInteger j = 12; j > 0; j--){
                YLAwesomeData *data = [[YLAwesomeData alloc]initWithId:j name:[NSString stringWithFormat:@"%li",j]];
                [months addObject:data];
                if(j <= month){
                    [currentMonths addObject:data];
                }
            }
            self.allMonths = months;
            self.currentMonths = currentMonths;
            self.dataSource = @{@0:years,@1:months};
        }
            break;
        case YLDataConfigTypeAddress:{
            NSString *provincePath = [[NSBundle mainBundle]pathForResource:@"province" ofType:@"json"];
            NSData *provinceData = [NSData dataWithContentsOfFile:provincePath];
            NSArray *provinceArray = [NSJSONSerialization JSONObjectWithData:provinceData options:0 error:nil];
            NSMutableArray *provinces = [NSMutableArray arrayWithCapacity:provinceArray.count];
            for(NSInteger i = 0; i < provinceArray.count; i++){
                NSDictionary *tmpDic = provinceArray[i];
                YLAwesomeData *data = [[YLAwesomeData alloc]initWithId:[tmpDic[@"id"]integerValue] name:tmpDic[@"name"]];
                [provinces addObject:data];
            }
            
            NSArray *citys = [NSArray array];
            if(provinces.count > 0){
                YLAwesomeData *firstProvince = provinces[0];
                citys = [self citysInProvince:firstProvince.objId];
            }
            
            NSArray *areas = [NSArray array];
            if(citys.count > 0){
                YLAwesomeData *firstCity = citys[0];
                areas = [self areasInCity:firstCity.objId];
            }
            
            self.dataSource = @{@0:provinces,@1:citys,@2:areas};
        }
            break;
        case YLDataConfigTypeUnKnow:
        default:
            break;
    }
}

- (NSDateComponents *)currentDateComponents
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:now];
    return dateComponents;
}

- (NSArray *)citysInProvince:(NSInteger)pId
{
    NSString *cityPath = [[NSBundle mainBundle]pathForResource:@"city" ofType:@"json"];
    NSData *cityData = [NSData dataWithContentsOfFile:cityPath];
    NSDictionary *cityDictionary = [NSJSONSerialization JSONObjectWithData:cityData options:0 error:nil];
    NSArray *firstCityArray = [cityDictionary objectForKey:[NSString stringWithFormat:@"%li",pId]];
    NSMutableArray *citys = [NSMutableArray arrayWithCapacity:firstCityArray.count];
    for(NSInteger i = 0; i < firstCityArray.count; i++){
        NSDictionary *tmpDic = firstCityArray[i];
        YLAwesomeData *data = [[YLAwesomeData alloc]initWithId:[tmpDic[@"id"]integerValue] name:tmpDic[@"name"]];
        [citys addObject:data];
    }
    return citys;
}

- (NSArray *)areasInCity:(NSInteger)cId
{
    NSString *areaPath = [[NSBundle mainBundle]pathForResource:@"area" ofType:@"json"];
    NSData *areaData = [NSData dataWithContentsOfFile:areaPath];
    NSDictionary *areaDictionary = [NSJSONSerialization JSONObjectWithData:areaData options:0 error:nil];
    NSArray *areaArray = [areaDictionary objectForKey:[NSString stringWithFormat:@"%li",cId]];
    NSMutableArray *areas = [NSMutableArray arrayWithCapacity:areaArray.count];
    for(NSInteger i = 0; i < areaArray.count; i++){
        NSDictionary *tmpDic = areaArray[i];
        YLAwesomeData *data = [[YLAwesomeData alloc]initWithId:[tmpDic[@"id"]integerValue] name:tmpDic[@"name"]];
        [areas addObject:data];
    }
    return areas;
}

#pragma mark---YLAwesomeDataDelegate
- (NSInteger)numberOfComponents
{
    return _dataSource.allKeys.count;
}

- (YLAwesomeData *)defaultSelectDataInComponent:(NSInteger)component
{
    if(_selectedData.count > component){
        return _selectedData[component];
    }
    return nil;
}

- (NSArray *)dataInComponent:(NSInteger)component
{
    if([_dataSource.allKeys containsObject:@(component)]){
        return _dataSource[@(component)];
    }
    return @[];
}

- (void)updateDataSourceWithIndex:(NSInteger)index data:(NSArray *)data
{
    NSMutableDictionary *tmpDic = [NSMutableDictionary dictionaryWithDictionary:self.dataSource];
    tmpDic[@(index)] = data;
    self.dataSource = tmpDic;
}

- (NSArray *)dataInComponent:(NSInteger)nComponent selectedComponent:(NSInteger)sComponent row:(NSInteger)row
{
    if(_type == YLDataConfigTypeStartTime){
        if(sComponent == 0){
            if(row == 0){
                [self updateDataSourceWithIndex:1 data:self.currentMonths];
                return self.currentMonths;
            }else{
                [self updateDataSourceWithIndex:1 data:self.allMonths];
                return self.allMonths;
            }
        }
    }else if (_type == YLDataConfigTypeEndTime){
        if(sComponent == 0){
            if(row == 0){
                [self updateDataSourceWithIndex:1 data:@[]];
                return @[];
            }else if(row == 1){
                [self updateDataSourceWithIndex:1 data:self.currentMonths];
                return self.currentMonths;
            }else{
                [self updateDataSourceWithIndex:1 data:self.allMonths];
                return self.allMonths;
            }
        }
    }else if(_type == YLDataConfigTypeAddress){
        if(sComponent == 0){//select province,then refresh citys and areas
            NSArray *provinces = self.dataSource[@0];
            YLAwesomeData *currentProvince = provinces[row];
            NSArray *citys = [self citysInProvince:currentProvince.objId];
            NSArray *areas = [NSArray array];
            if(citys.count > 0){
                YLAwesomeData *firstCity = citys[0];
                areas = [self areasInCity:firstCity.objId];
            }
            if(nComponent == 1){
                [self updateDataSourceWithIndex:1 data:citys];
                return citys;
            }else if (nComponent == 2){
                [self updateDataSourceWithIndex:2 data:areas];
                return areas;
            }
        }else if (sComponent == 1){//select city,then refresh areas
            NSArray *citys = self.dataSource[@1];
            YLAwesomeData *currentCity = citys[row];
            NSArray *areas = [self areasInCity:currentCity.objId];
            [self updateDataSourceWithIndex:2 data:areas];
            return areas;
        }
    }else if (nComponent < _dataSource.allKeys.count){
        NSArray *data = _dataSource[@(nComponent)];
        [self updateDataSourceWithIndex:nComponent data:data];
        return data;
    }
    return @[];
}

@end
