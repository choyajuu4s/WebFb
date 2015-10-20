//
//  ViewController.h
//  WebFb
//
//  Created by 飯塚 俊英 on 2015/10/20.
//  Copyright © 2015年 chopayer. All rights reserved.
//

//SideMenu
#import "CDRTranslucentSideBar.h"
#import "MenuViewController.h"

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <CDRTranslucentSideBarDelegate, MenuViewControllerDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonBack;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonFoword;

- (IBAction)pressedTitleButton:(UIButton *)sender;
- (IBAction)pressedReloadButton:(UIBarButtonItem *)sender;
- (IBAction)pressedBackButton:(UIBarButtonItem *)sender;
- (IBAction)pressedFowordButton:(UIBarButtonItem *)sender;
- (IBAction)pressedShareButton:(UIBarButtonItem *)sender;
- (IBAction)pressedMenuButton:(UIBarButtonItem *)sender;
- (IBAction)pressedCloseButton:(UIBarButtonItem *)sender;

//Menu
@property (nonatomic, strong) MenuViewController*  rightController;

//MenuViewControllerDelegate
- (void)didTapMenuSelectedRow:(int)row;

//Segue
- (void)callModal:(id)sender;

@end

