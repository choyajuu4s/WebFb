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

@property (strong, nonatomic) IBOutlet UIButton *buttonMenu;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonBack;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonFoword;

- (IBAction)pressedTitleButton:(id)sender;
- (IBAction)pressedMenuButton:(id)sender;
- (IBAction)pressedShareButton:(id)sender;
- (IBAction)pressedReloadButton:(UIBarButtonItem *)sender;
- (IBAction)pressedBackButton:(UIBarButtonItem *)sender;
- (IBAction)pressedFowordButton:(UIBarButtonItem *)sender;
- (IBAction)pressedCloseButton:(UIBarButtonItem *)sender;

//Menu
@property (nonatomic, strong) MenuViewController*  rightController;

//MenuViewControllerDelegate
//- (void)didTapMenuSelectedRow:(int)row;
- (void)didTapMenuSelectedUrl:(NSString *)url;

//Segue
- (void)callModal:(id)sender;

@end

