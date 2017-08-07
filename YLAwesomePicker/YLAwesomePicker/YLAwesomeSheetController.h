//
//  YLResumeActionSheetController.h
//  YLLanJiQuan
//
//  Created by TK-001289 on 2017/6/15.
//  Copyright © 2017年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLAwesomeDataDelegate.h"
@class YLAwesomeData;

typedef void(^YLAwesomeSheetSelectCallBack)(NSArray *selectedData);
typedef void(^YLAwesomeSelectDateCallBack)(NSDate *date);

@interface YLAwesomeSheetController : UIViewController
@property(nonatomic,strong)id<YLAwesomeDataDelegate> dataConfiguration;
@property(nonatomic,copy)YLAwesomeSheetSelectCallBack callBack;
@property(nonatomic,copy)YLAwesomeSelectDateCallBack dateCallBack;
@property(nonatomic,strong)UIDatePicker *datePicker;


/**
 指定标题、配置和回调创建对象

 @param title 标题
 @param config 配置对象
 @param callBack 回调
 @return 对象
 */
- (instancetype)initWithTitle:(NSString *)title config:(id<YLAwesomeDataDelegate>)config callBack:(YLAwesomeSheetSelectCallBack)callBack;


/**
 日期选择

 @param title 标题
 @param callBack 毁掉
 @return 对象
 */
- (instancetype)initDatePickerWithTitle:(NSString *)title callBack:(YLAwesomeSelectDateCallBack)callBack;

/**
 will present picker from the bottom of controller.view
 */
- (void)showInController:(UIViewController *)controller;

@end

