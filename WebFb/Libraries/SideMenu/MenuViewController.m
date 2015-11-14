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
//    NSArray* _sectionTypeArray;
    id _selectObject;
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
//    _sectionTypeArray = [NSArray arrayWithObjects:@"MenuList", nil];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}

// This is just a sample for tableview menu
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[SettingManager sharedManager] getHistoryArrayCount];
//    return [_sectionTypeArray count];
}

-(CGFloat) tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell* cell = (UITableViewCell*)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.selectionStyle = self.editing ? UITableViewCellSelectionStyleNone : UITableViewCellSelectionStyleBlue;
    
    // Configure the cell...
    id object = [[SettingManager sharedManager] getHistoryArrayAtIndex:(int)indexPath.row];
    //    LOG(@"object : %@", [object description]);
    
#if DEBUG
    FBObject* qro = object;
    LOG(@"QRObject IID : %@", qro->iid);
    qro = nil;
#endif
    
    //    UIImage* icon = nil;
    NSString* title = nil;
    if ( [object isKindOfClass:[FBHistoryData class]] ) {
        FBHistoryData* data = (FBHistoryData*)object;
        if ( ![data->title isEqualToString:@"Facebook"] ) {
            title = data->title;
        }
        if ( !title || [data->title isEqualToString:@""] ) title = data->url;
        
        //        icon = [UIImage imageNamed:@"icn_text_ble"];
    }
    
    enum {
        CELLSTATE_TITLE = 1,
        CELLSTATE_IMAGE = 3,
    };
    
    UILabel* label = (UILabel*)[cell viewWithTag:CELLSTATE_TITLE];
    label.text = title;
    //    QRImageView* imageView = (QRImageView*)[cell viewWithTag:CELLSTATE_IMAGE];
    //    imageView.image = icon;
    label = nil;
    
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
    // Configure the cell...
    id object = [[SettingManager sharedManager] getHistoryArrayAtIndex:(int)indexPath.row];
//    _selectObject = object;
    
    //Call
    if ( [object isKindOfClass:[FBHistoryData class]] ) {
        FBHistoryData* data = (FBHistoryData*)object;
        //        [self performSegueWithIdentifier:@"EditText" sender:data];
        [self performSelector:@selector(didTapMenuSelectedUrl:) withObject:data->url];
        LOG(@"data : %@ - %@", data->title, data->url);
    }

}

- (void)didTapMenuSelectedUrl:(NSString*)url {
    if ([self.delegate respondsToSelector:@selector(didTapMenuSelectedUrl:)]) {
        [self.delegate didTapMenuSelectedUrl:url];
    }
}

//- (void)didTapRightMenuSelectedRow:(int)row {
////    LOG(@"<<didTapMenuSelectedRow>> : %@", [self.delegate class]);
//    //デリゲート先へ通知する
////    @try {
//        if ([self.delegate respondsToSelector:@selector(didTapMenuSelectedRow:)]) {
//            [self.delegate didTapMenuSelectedRow:row];
//        }
////    }
////    @catch (NSException *exception) {
////    }
////    @finally {
////    }
//}

@end
