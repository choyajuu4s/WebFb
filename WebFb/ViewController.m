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
#define DEFAULT_HTTPNAME @"facebook.com"

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Navigation Bar Translucent
    [self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.alpha        = 1.0;
    self.navigationController.navigationBar.translucent  = YES;
    
    //Side Menu Set
    [self setSideMenu];
    
    //Set
    self.showRightMenu = NO;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:DEFAULT_URL]]];
    self.webView.scrollView.delegate = self;
    
    //Set touch events
    [self setFlickGesture];
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

- (IBAction)pressedCloseButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma - Touch Event

- (void)setFlickGesture
{
    // 右へスワイプ
    UISwipeGestureRecognizer* swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRightGesture:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRightGesture];
    swipeRightGesture = nil;
    
    // 左へスワイプ
    UISwipeGestureRecognizer* swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeftGesture:)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeftGesture];
    swipeLeftGesture = nil;
}

- (void) handleSwipeRightGesture:(UISwipeGestureRecognizer *)sender
{
    [self pressedBackButton:nil];
}

- (void) handleSwipeLeftGesture:(UISwipeGestureRecognizer *)sender
{
    [self pressedFowordButton:nil];
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
    
    if(webView.canGoBack == YES){
        _buttonBack.enabled = YES;
    }else{
        _buttonBack.enabled = NO;
    }
    
    if(webView.canGoForward == YES){
        _buttonFoword.enabled = YES;
    }else{
        _buttonFoword.enabled = NO;
    }
}

#if 0//様子見
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    bool flag = YES;
    // リンクがクリックされたとき
    if (navigationType == UIWebViewNavigationTypeLinkClicked /*||
        navigationType == UIWebViewNavigationTypeOther*/) {
        //Facebook
        if ( [self isCheckURL:[request URL] checkUrlString:DEFAULT_URL] ) {
            NSLog(@"Facebook");
            flag = YES;
        } else {
            //Facebook以外
            NSLog(@"Facebook以外");
            [self performSelector:@selector(callModal:) withObject:self afterDelay:0.1];
            flag = NO;
        }
    }
    
    return flag;
}
#endif

- (void)callModal:(id)sender {
    [self performSegueWithIdentifier:@"CallModal" sender:sender];
}

#pragma mark - Check

- (BOOL)isCheckURL:(NSURL *)url checkUrlString:(NSString*)checkUrlString
{
    NSString *urlString = [url absoluteString];
    
    // 指定のページか?
    NSRange range = [urlString rangeOfString:checkUrlString];
    if (range.location != NSNotFound) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - UIScrollView Delegate

#define RELOAD_OFFSET 200.0
#define ADJUST_Y 44.0
static float begin_y = NAN;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    begin_y = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float end_y = scrollView.contentOffset.y;
    if ( begin_y - end_y + ADJUST_Y < -10 ) {
        //Hide
        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        NSLog(@"Hide %f - %f = %f", begin_y, end_y, begin_y - end_y);
    } else if ( begin_y - end_y + ADJUST_Y > 10 ) {
        //Show
        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        NSLog(@"Show %f - %f = %f", begin_y, end_y, begin_y - end_y);
    }
    
    //Reload
    if (scrollView.contentOffset.y < -RELOAD_OFFSET)
    {
        //Call Reload
        [self pressedReloadButton:nil];
    }
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
