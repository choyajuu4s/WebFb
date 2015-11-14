//
//  SettingManager.m
//  QBar
//
//  Created by 飯塚 俊英 on 2015/10/08.
//  Copyright © 2015年 chopayer. All rights reserved.
//

#import "FBHistoryData.h"
#import <CommonCrypto/CommonDigest.h>
#import "SettingManager.h"

@implementation SettingManager

static SettingManager *sharedData = nil;

+ (SettingManager *)sharedManager {
    if (!sharedData) {
        sharedData = [[SettingManager alloc] init];
        //        [sharedData set];
    }
    return sharedData;
}

- (id)init
{
    self = [super init];
    if ( self )
    {
//        [self set];
    }
    return self;
}

//#pragma mark - Dialog
//
//- (void)dialogMessage:(NSString*)message class:(id)class {
//    //ダイアログを表示
//    __block __weak typeof(self) weakSelf = class;
//    [RMUniversalAlert showAlertInViewController:(UIViewController*)weakSelf
//                                      withTitle:nil
//                                        message:message
//                              cancelButtonTitle:nil
//                         destructiveButtonTitle:nil
//                              otherButtonTitles:@[@"OK"]
//                                       tapBlock:
//     ^(RMUniversalAlert* alert, NSInteger buttonIndex){
//     }];
//}

#pragma mark - Array

- (void)setHistoryArrayWithObject:(id)object {
#if DEBUG
    FBHistoryData* qro = object;
//    LOG(@"QRObject IID : %@", qro->iid);
#endif
    
    //原則NSDataに変換する
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSMutableArray* history = [NSMutableArray arrayWithCapacity:HISTORY_DATACOUNT];
    [history addObjectsFromArray:[self getHistoryArray]];
    
    //同じデータの重複削除
    NSMutableArray* removes = [NSMutableArray array];
    for ( NSData* loaddata in history ) {
        if ( [loaddata isEqualToData:data] ) continue;
#if 1
        //URLで比較
        FBHistoryData* loadqro = [NSKeyedUnarchiver unarchiveObjectWithData:loaddata];
        if ( [qro->url isEqualToString:loadqro->url] ) {
            //同じデータの場合
            [removes addObject:loaddata];
//            LOG(@"removes : %@", loadqro->iid);
        }
#else
        //IIDで比較
        FBHistoryData* loadqro = [NSKeyedUnarchiver unarchiveObjectWithData:loaddata];
        if ( [qro->iid isEqualToNumber:loadqro->iid] ) {
            //同じデータの場合
            [removes addObject:loaddata];
            //            LOG(@"removes : %@", loadqro->iid);
        }
#endif
    }
    [history removeObjectsInArray:removes];
    
    //追加
#if 1//先頭に追加
    [history insertObject:data atIndex:0];
#else//末尾に追加
    [history addObject:data];
#endif
    
    //保存
    [self saveObject:history key:@"history"];
//    LOG(@"history : %@", [history description]);
}

- (NSArray*)getHistoryArray {
    @try {
        return [self loadArrayWithKey:@"history"];
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
    return nil;
}

- (int)getHistoryArrayCount {
    NSArray* history = [self getHistoryArray];
    @try {
        return (int)history.count;
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
    return 0;
}

- (id)getHistoryArrayAtIndex:(int)index {
    NSArray* history = [self getHistoryArray];
    @try {
        NSData* data = [history objectAtIndex:index];
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
    return nil;
}

- (void)removeHistoryArrayAtIndex:(int)index {
    NSMutableArray* history = [NSMutableArray arrayWithArray:[self getHistoryArray]];
    @try {
        NSData* data = [history objectAtIndex:index];
        [history removeObject:data];
        
        //保存
        [self saveObject:history key:@"history"];
//        LOG(@"history : %@", [history description]);
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

#pragma mark - Purchae

- (void)setPurchasePrice:(NSString*)price {
    
}

- (NSString*)getPurchasePrice {
    return @"$0.99";
}

- (void)setPurchaseStatus {
    
}

- (bool)getPurchaseStatus {
    //デフォルトはNO
//    return YES;
    return NO;
    //課金状態をロードして返却する
}

- (bool)getPurchaseStatus:(id)object {
    //デフォルトはNO
#if DEBUG
//    [self dialogMessage:@"DEBUG MODE" class:object];
    return YES;
#else
//    return NO;
#endif
    
    //課金状態をロードして返却する
    return [self getPurchaseStatus];
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
