//
//  YLTestData.h
//  YLAwesomePicker
//
//  Created by TK-001289 on 2017/6/16.
//  Copyright © 2017年 TK-001289. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLTestData : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSArray *data;

- (instancetype)initWithTitle:(NSString *)title;

@end
//test object
