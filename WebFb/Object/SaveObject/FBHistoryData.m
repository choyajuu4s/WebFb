//
//  FBHistoryData.m
//  QBar
//
//  Created by 飯塚 俊英 on 2015/10/07.
//  Copyright © 2015年 ZILAPP. All rights reserved.
//

#import "FBHistoryData.h"

@implementation FBHistoryData

// 初期化用メソッド（NSData からの変換で使用）
- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super init];
    
    if (self)
    {
        // ここで aDecoder に格納しておいた値を取得します。
        iid = [aDecoder decodeObjectForKey:@"iid"];
        title = [aDecoder decodeObjectForKey:@"title"];
        url = [aDecoder decodeObjectForKey:@"url"];
        
        //TimeStamp
        @try {
            timeStamp = [aDecoder decodeObjectForKey:@"timeStamp"];
        }
        @catch (NSException *exception) {
            timeStamp = [NSDate date];
        }
        @finally {
        }
    }
    
    return self;
}

// 変換用メソッド（NSData への変換で使用）
- (void)encodeWithCoder:(NSCoder*)aCoder
{
    //IID
    [aCoder encodeObject:iid forKey:@"iid"];
    
    [aCoder encodeObject:title forKey:@"title"];
    [aCoder encodeObject:url forKey:@"url"];
    
    //TimeStamp
    @try {
        [aCoder encodeObject:timeStamp forKey:@"timeStamp"];
    }
    @catch (NSException *exception) {
        timeStamp = [NSDate date];
        [aCoder encodeObject:timeStamp forKey:@"timeStamp"];
    }
    @finally {
    }
}

@end
