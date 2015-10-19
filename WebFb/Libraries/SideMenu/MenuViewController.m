//
//  MenuViewController.m
//  QBar
//
//  Created by Toshihide Iizuka on 2015/10/04.
//  Copyright © 2015年 ZILAPP. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray* _sectionTypeArray;
}

@end

@implementation MenuViewController

- (UIModalPresentationStyle)modalPresentationStyle
{
    return UIModalPresentationOverCurrentContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    //Set table
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setBounces:NO];
    
    //Set Section
    [self setViewSection];
    
//    self.selectPath = nil;
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    
//    LOG(@"<<MENU viewWillAppear>>");
//    
//    self.selectPath = nil;
//    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setViewSection
{
    //セクションタイプ配列を読み込む
    _sectionTypeArray = [NSArray arrayWithObjects:@"MenuTitle", nil];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}

// This is just a sample for tableview menu
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_sectionTypeArray count];
}

-(CGFloat) tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell* cell = (UITableViewCell*)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:[_sectionTypeArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)setSelectCellView:(UITableViewCell*)cell selected:(bool)selected{
    for ( UIView* view in cell.subviews ) {
        if ( selected ) {
            view.alpha = 0.5;
        } else {
            view.alpha = 1.0;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
}

- (void)didTapRightMenuSelectedRow:(int)row {
//    LOG(@"<<didTapMenuSelectedRow>> : %@", [self.delegate class]);
    //デリゲート先へ通知する
//    @try {
        if ([self.delegate respondsToSelector:@selector(didTapMenuSelectedRow:)]) {
            [self.delegate didTapMenuSelectedRow:row];
        }
//    }
//    @catch (NSException *exception) {
//    }
//    @finally {
//    }
}

@end
