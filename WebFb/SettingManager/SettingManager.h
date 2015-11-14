//
//  SettingManager.h
//  QBar
//
//  Created by 飯塚 俊英 on 2015/10/08.
//  Copyright © 2015年 chopayer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingManager : NSObject {
    int _viewmode;
}
+ (SettingManager *)sharedManager;

////Dialog
//- (void)dialogMessage:(NSString*)message class:(id)class;
//
////Purchae
//- (void)setPurchasePrice:(NSString*)price;
//- (NSString*)getPurchasePrice;
//- (void)setPurchaseStatus;
//- (bool)getPurchaseStatus;
//- (bool)getPurchaseStatus:(id)object;

//Array
- (void)setHistoryArrayWithObject:(id)object;
- (NSArray*)getHistoryArray;
- (int)getHistoryArrayCount;
- (id)getHistoryArrayAtIndex:(int)index;
- (void)removeHistoryArrayAtIndex:(int)index;

@end
