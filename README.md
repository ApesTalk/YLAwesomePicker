# YLAwesomePicker

最少只需三行代码的一个自定义数据拾取器，可以记录并展示上次选中的数据。

A custom data picker that requires only three lines of code to record and display the last selected data.

## 介绍

在我们的项目开发过程中难免会遇到要使用UIPickerView实现拾取性别、年龄、工作经验、学历、时间、爱好、省市区地址等等数据，有时候甚至要结合
UIActionSheet(or UIAlertController)使用。而且，有时候项目中可能会有很多页面需要这种功能。这种情况下，我们以前的做法是在每个需要的页面：
1.创建UIPickerView和UIActionSheet(or UIAlertController)并设置代理;
2.实现一系列的代理方法，在代理方法中实现一切必须的数据逻辑；
3.记录UIPickerView选中的数据，在确认选择之后处理其选择的数据并展示。

这么做太糟糕了，耗时而且麻烦。于是，YLAwesomePicker产生了，YLAwesomePicker实现了我们常常需要的性别、年龄、工作经验、学历、开始时间、截止时间
和省市区地址选择的功能，如果你的项目中刚好需要这样的数据，那恭喜你，你可以省下很多处理逻辑的时间了。如果你的项目中需要其他数据，你可以模仿demo中
的“自定义其他类型”的实现方式，简单配置一下数据就好了。


## 如何使用

1.如果你需要的是性别、年龄、工作经验、学历、开始时间、截止时间和省市区地址数据，那么你可以使用已有的枚举类型：

```
YLDataConfiguration *config = [[YLDataConfiguration alloc]initWithType:YLDataConfigTypeGender selectedData:selectedData];
YLAwesomeSheetController *sheet = [[YLAwesomeSheetController alloc]initWithTitle:testData.title
                                                                          config:config
                                                                        callBack:^(NSArray *selectedData) {
     testData.data = selectedData;
     [tableView reloadData];
}];
[sheet showInController:self];
```

2.如果你需要自定义类型的数据，你只需要像这样配置一个YLDataConfiguration对象，然后传入即可：

```
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
                           
YLDataConfiguration *config = [[YLDataConfiguration alloc]initWithData:data selectedData:selectedData];
YLAwesomeSheetController *sheet = [[YLAwesomeSheetController alloc]initWithTitle:testData.title 
                                                                          config:config 
                                                                        callBack:^(NSArray *selectedData) {
    testData.data = selectedData;
    [tableView reloadData];
}];
[sheet showInController:self];                           
```

对，数据选择就应该这么简单！


## 效果图

![]()

