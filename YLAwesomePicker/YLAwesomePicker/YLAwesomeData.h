//
//  YLAwesomeData.h
//  YLAwesomePicker
//
//  Created by TK-001289 on 2017/6/15.
//  Copyright © 2017年 TK-001289. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLAwesomeData : NSObject 
@property(nonatomic,assign)NSInteger objId;
@property(nonatomic,copy)NSString *name;

- (instancetype)initWithId:(NSInteger)oId name:(NSString *)name;

@end
//the data object the picker can pick
