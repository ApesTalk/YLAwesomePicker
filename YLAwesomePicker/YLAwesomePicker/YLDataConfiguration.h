//
//  YLDataConfiguration.h
//  YLAwesomePicker
//
//  Created by TK-001289 on 2017/6/15.
//  Copyright © 2017年 TK-001289. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLAwesomeDataDelegate.h"

typedef NS_ENUM(NSInteger,YLDataConfigType) {
    YLDataConfigTypeUnKnow = 0,///< unknow the type
    YLDataConfigTypeGender = 1000,///< select gender
    YLDataConfigTypeAcademic,///< select academic
    YLDataConfigTypeWorkYear,///< select work years
    YLDataConfigTypeStartTime,///< select start time
    YLDataConfigTypeEndTime,///< select end time
    YLDataConfigTypeAddress,////< select province-city-region
};

@interface YLDataConfiguration : NSObject <YLAwesomeDataDelegate>
@property(nonatomic,copy)NSArray *selectedData;


/**
 You can use the default type, it will auto init the data.

 @param type YLDataConfigType
 @param selectedData The last selected data
 @return instance
 */
- (instancetype)initWithType:(YLDataConfigType)type selectedData:(NSArray *)selectedData;


/**
 You can use this method to custom the select data.

 @param dataDic The select data like: @{@0:@[data0,data1...]}
 @param selectedData The last selected data
 @return instance
 */
- (instancetype)initWithData:(NSDictionary *)dataDic selectedData:(NSArray *)selectedData;


@end
//the data configuration center
