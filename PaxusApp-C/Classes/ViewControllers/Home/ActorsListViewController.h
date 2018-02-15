//
//  ActorsListViewController.h
//  PaxusApp-C
//
//  Created by Jithin on 14/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "ActorDetailsTableCell.h"
#import "NSTEasyJSON.h"
#import "UIColor+ColorExtension.h"
#import "ActorsModel.h"
#import "PXAlertController.h"

@interface ActorsListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

#pragma mark - Variable declaration
@property (nonatomic, strong) UITableView *actorsListTableView;
@property (nonatomic, strong) UIView    *controllerHeaderBar;
@property (nonatomic, strong) UILabel   *headerBarLabel;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end
