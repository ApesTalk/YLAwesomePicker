
//
//  YLAwesomeDataDelegate.h
//  YLAwesomePicker
//
//  Created by TK-001289 on 2017/6/15.
//  Copyright © 2017年 TK-001289. All rights reserved.
//

#ifndef YLAwesomeDataDelegate_h
#define YLAwesomeDataDelegate_h

@class YLAwesomeData;

@protocol YLAwesomeDataDelegate <NSObject>
@property(nonatomic,copy,readonly)NSDictionary *dataSource;///< contains data like: @{@0:@[data0,data1...],@1:@[data0,data1,...]}

/**
 the total number of components
 */
- (NSInteger)numberOfComponents;

/**
 the default selected data in the component, default nil. Used when need remember the last select state

 @param component the target component
 @return selected data
 */
- (YLAwesomeData *)defaultSelectDataInComponent:(NSInteger)component;

/**
 the default data in the component, when first appear show the default data

 @param component the target component
 @return data array
 */
- (NSArray *)dataInComponent:(NSInteger)component;

/**
 when selected the row in the component, get data again with this method if need refresh

 @param nComponent the component which need refresh data
 @param sComponent the current selected component
 @param row the current selected row
 @return data array
 */
- (NSArray *)dataInComponent:(NSInteger)nComponent selectedComponent:(NSInteger)sComponent row:(NSInteger)row;

@end

#endif /* YLAwesomeDataDelegate_h */
