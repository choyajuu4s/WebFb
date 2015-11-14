//
//  FBObject.m
//  QBar
//
//  Created by 飯塚 俊英 on 2015/10/31.
//  Copyright © 2015年 chopayer. All rights reserved.
//

#import "FBObject.h"

@implementation FBObject

- (id)init {
    self = [super init];
    
    if ( self ) {
    }
    
    return self;
}

- (void)generate {
    if ( iid && ![iid isEqualToNumber:@0] ) return;
    
    //TimeStamp
    timeStamp = [NSDate date];
    
    //iid生成
    //  最終に作られたiidの取得
    @try {
        int oldiid = [[self loadObjectWithKey:@"QRObjectIID"] intValue];
        iid = @(oldiid+1);
    }
    @catch (NSException *exception) {
        //初回時
        iid = @1;
    }
    @finally {
    }
    
    //最終iid保存
    [self saveObject:iid key:@"QRObjectIID"];
    
    LOG(@"Generate IID : %@", iid);
}

// 初期化用メソッド（NSData からの変換で使用）
- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super init];
    
    if (self)
    {
        // ここで aDecoder に格納しておいた値を取得します。
        iid = [aDecoder decodeObjectForKey:@"iid"];
        
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
    [aCoder encodeObject:iid forKey:@"iid"];
    
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

#pragma mark - User Default

- (void)saveObject:(id)object key:(NSString*)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:object forKey:key];
    [ud synchronize];
}

- (id)loadObjectWithKey:(NSString*)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud valueForKey:key];
}

- (id)loadArrayWithKey:(NSString*)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud arrayForKey:key];
}

- (void)removeObjectWithKey:(NSString*)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:key];
}

@end
