//
//  ViewController.m
//  YLAwesomePicker
//
//  Created by TK-001289 on 2017/6/15.
//  Copyright © 2017年 TK-001289. All rights reserved.
//

#import "ViewController.h"
#import "YLAwesomeData.h"
#import "YLDataConfiguration.h"
#import "YLAwesomeSheetController.h"
#import "YLTestData.h"

static NSString *cellIdentifier = @"cellIdenfier";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *testDataList;
}
@property(nonatomic,strong)UITableView *table;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    testDataList = @[[[YLTestData alloc]initWithTitle:@"选择性别"],
                     [[YLTestData alloc]initWithTitle:@"请选择学历"],
                     [[YLTestData alloc]initWithTitle:@"请选择工作年限"],
                     [[YLTestData alloc]initWithTitle:@"请选择开始时间"],
                     [[YLTestData alloc]initWithTitle:@"请选择结束时间"],
                     [[YLTestData alloc]initWithTitle:@"请选择地址"],
                     [[YLTestData alloc]initWithTitle:@"自定义其他类型"]];
    _table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return testDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    }
    YLTestData *testData = testDataList[indexPath.row];
    cell.textLabel.text = testData.title;
    NSString *detail;
    if(testData.data){
        detail = [testData.data componentsJoinedByString:@"-"];
    }
    cell.detailTextLabel.text = detail;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    YLTestData *testData = testDataList[row];
    if(row < 6){
        YLDataConfigType type = YLDataConfigTypeGender + row;
        NSArray *selectedData = testData.data;
        YLDataConfiguration *config = [[YLDataConfiguration alloc]initWithType:type selectedData:selectedData];
        YLAwesomeSheetController *sheet = [[YLAwesomeSheetController alloc]initWithTitle:testData.title
                                                                                  config:config
                                                                                callBack:^(NSArray *selectedData) {
            testData.data = selectedData;
            [tableView reloadData];
        }];
        [sheet showInController:self];
    }else{
        NSArray *selectedData = testData.data;
        NSDictionary *data = [self testDic];
        YLDataConfiguration *config = [[YLDataConfiguration alloc]initWithData:data selectedData:selectedData];
        YLAwesomeSheetController *sheet = [[YLAwesomeSheetController alloc]initWithTitle:testData.title config:config callBack:^(NSArray *selectedData) {
            testData.data = selectedData;
            [tableView reloadData];
        }];
        [sheet showInController:self];
    }
    
}

- (NSDictionary *)testDic
{
    NSDictionary *data = @{@0:@[[[YLAwesomeData alloc]initWithId:0 name:@"红色"],
                               [[YLAwesomeData alloc]initWithId:1 name:@"橙色"],
                               [[YLAwesomeData alloc]initWithId:2 name:@"黄色"],
                               [[YLAwesomeData alloc]initWithId:3 name:@"绿色"],
                               [[YLAwesomeData alloc]initWithId:4 name:@"青色"],
                               [[YLAwesomeData alloc]initWithId:5 name:@"蓝色"],
                               [[YLAwesomeData alloc]initWithId:6 name:@"紫色"]],
                           @1:@[[[YLAwesomeData alloc]initWithId:0 name:@"S码"],
                                [[YLAwesomeData alloc]initWithId:2 name:@"M码"],
                                [[YLAwesomeData alloc]initWithId:3 name:@"L码"],
                                [[YLAwesomeData alloc]initWithId:4 name:@"XL码"],
                                [[YLAwesomeData alloc]initWithId:5 name:@"XXL码"],
                                [[YLAwesomeData alloc]initWithId:6 name:@"XXXL码"]]
                           };
    return data;
}

@end
