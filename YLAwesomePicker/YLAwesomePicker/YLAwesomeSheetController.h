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

@interface YLAwesomeSheetController : UIViewController
@property(nonatomic,strong)id<YLAwesomeDataDelegate> dataConfiguration;
@property(nonatomic,copy)YLAwesomeSheetSelectCallBack callBack;

- (instancetype)initWithTitle:(NSString *)title config:(id<YLAwesomeDataDelegate>)config callBack:(YLAwesomeSheetSelectCallBack)callBack;

/**
 will present picker from the bottom of controller.view
 */
- (void)showInController:(UIViewController *)controller;

@end

