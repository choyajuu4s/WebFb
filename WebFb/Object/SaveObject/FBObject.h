//
//  FBObject.h
//  QBar
//
//  Created by 飯塚 俊英 on 2015/10/31.
//  Copyright © 2015年 chopayer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBObject : NSObject {
    @public
        NSNumber*   iid;
        NSDate*   timeStamp;
}

//保存
- (void)generate;

//User Default
- (void)saveObject:(id)object key:(NSString*)key;
- (id)loadObjectWithKey:(NSString*)key;
- (id)loadArrayWithKey:(NSString*)key;
- (void)removeObjectWithKey:(NSString*)key;

@end
