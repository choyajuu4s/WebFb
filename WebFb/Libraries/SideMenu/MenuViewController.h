//
//  MenuViewController.h
//  QBar
//
//  Created by Toshihide Iizuka on 2015/10/04.
//  Copyright © 2015年 ZILAPP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewControllerDelegate <NSObject>

- (void)didTapMenuSelectedUrl:(NSString*)url;
//- (void)didTapMenuSelectedRow:(int)row;

@end

@interface MenuViewController : UIViewController

- (UIModalPresentationStyle)modalPresentationStyle;

@property (strong, nonatomic) id<MenuViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView* tableView;

@property (strong, nonatomic) NSIndexPath* selectPath;

@end
