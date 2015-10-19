//
//  ViewController.m
//  WebFb
//
//  Created by 飯塚 俊英 on 2015/10/20.
//  Copyright © 2015年 chopayer. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CDRTranslucentSideBar *rightSideBar;
@property bool showRightMenu;
@end

@implementation ViewController

#define DEFAULT_URL @"https://www.facebook.com/"

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Side Menu Set
    [self setSideMenu];
    
    //Set
    self.showRightMenu = NO;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:DEFAULT_URL]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Action

- (IBAction)pressedTitleButton:(UIButton *)sender {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:DEFAULT_URL]]];
}

- (IBAction)pressedReloadButton:(UIBarButtonItem *)sender {
    [_webView reload];
}

- (IBAction)pressedBackButton:(UIBarButtonItem *)sender {
    [_webView goBack];
}

- (IBAction)pressedFowordButton:(UIBarButtonItem *)sender {
    [_webView goForward];
}

- (IBAction)pressedShareButton:(UIBarButtonItem *)sender {
    NSString* url = [_webView stringByEvaluatingJavaScriptFromString:@"document.URL"];
    NSString* text = [NSString stringWithFormat:@"%@ by WebFb", url];
    [self displayActivityControllerWithDataObject:text];
}

- (IBAction)pressedMenuButton:(UIBarButtonItem *)sender {
    if ( !self.showRightMenu ) {
        [self.rightSideBar showAnimated:YES];
        [self.rightController.tableView reloadData];
    } else {
        [self.rightSideBar dismissAnimated:YES];
    }
}

#pragma mark - Share

- (void)displayActivityControllerWithDataObject:(id)obj {
    UIActivityViewController* vc = [[UIActivityViewController alloc]
                                    initWithActivityItems:@[obj] applicationActivities:nil];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIWebView Delegate

-(void)webViewDidStartLoad:(UIWebView*)webView {
    [_loading setHidden:NO];
}

-(void)webViewDidFinishLoad:(UIWebView*)webView {
    [_webView setHidden:NO];
    [_loading setHidden:YES];
}

#pragma mark - Side Menu

- (void)setSideMenu {
    // Create Right SideBar
    self.rightSideBar = [[CDRTranslucentSideBar alloc] initWithDirectionFromRight:YES];
    self.rightSideBar.delegate = self;
    self.rightSideBar.translucentStyle = UIBarStyleBlack;
    self.rightSideBar.tag = 1;
    self.showRightMenu = NO;
    
    _rightController = (MenuViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    _rightController.delegate = self;
    [self.rightSideBar setContentViewInSideBar:_rightController.view];
}

- (void)didTapMenuSelectedRow:(int)row {
}

@end
