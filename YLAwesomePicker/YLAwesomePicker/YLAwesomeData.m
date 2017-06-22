//
//  YLAwesomeData.m
//  YLAwesomePicker
//
//  Created by TK-001289 on 2017/6/15.
//  Copyright © 2017年 TK-001289. All rights reserved.
//

#import "YLAwesomeData.h"

@implementation YLAwesomeData
- (instancetype)initWithId:(NSInteger)oId name:(NSString *)name
{
    if(self = [super init]){
        self.objId = oId;
        self.name = name;
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    if(![object isKindOfClass:[self class]]){
        return NO;
    }
    YLAwesomeData *otherData = (YLAwesomeData *)object;
    return self.objId == otherData.objId && [self.name isEqualToString:otherData.name];
}

- (NSString *)description
{
    return self.name;
}

@end
