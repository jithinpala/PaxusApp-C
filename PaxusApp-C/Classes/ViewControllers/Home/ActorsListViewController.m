//
//  ActorsListViewController.m
//  PaxusApp-C
//
//  Created by Jithin on 14/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import "ActorsListViewController.h"
#import "ActorsListServiceManager.h"

@interface ActorsListViewController ()

@end

@implementation ActorsListViewController
@synthesize actorsListTableView;
@synthesize controllerHeaderBar;
@synthesize headerBarLabel;
@synthesize refreshControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureUserInterFace];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchActorListFromServe];
}

#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return [[ActorsModel sharedManager] actorsArray].count;
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ActorDetailsTableCell";
    ActorDetailsTableCell *cell = [theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = (ActorDetailsTableCell *)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSArray *singleActor = [[[ActorsModel sharedManager] actorsArray] objectAtIndex:indexPath.row];
    cell.actorNameLabel.text = [singleActor valueForKey:@"name"];
    cell.actorCountryLabel.text = [singleActor valueForKey:@"country"];
    cell.actorDOBLabel.text = [singleActor valueForKey:@"dob"];
    cell.actorChildrenLabel.text = [singleActor valueForKey:@"children"];
    cell.actorDescriptionLabel.text = [singleActor valueForKey:@"description"];
    [[ActorsListServiceManager sharedManager] fetchImageFromServer:cell.actorImageView imageURLPath:[singleActor valueForKey:@"image"] placeHoldeImage:@"launchImage"];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Configure user interface
-(void)configureUserInterFace {
    UIView *superView = self.view;
    
    self.controllerHeaderBar = [UIView new];
    [superView addSubview:controllerHeaderBar];
    [controllerHeaderBar setBackgroundColor:[UIColor colorFromHexCode:@"175fad"]];
    [controllerHeaderBar mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.left.equalTo(superView.mas_safeAreaLayoutGuideLeft);
            make.top.equalTo(superView.mas_safeAreaLayoutGuideTop);
            make.right.equalTo(superView.mas_safeAreaLayoutGuideRight);
            make.height.mas_equalTo(44);
        } else {
            make.left.equalTo(superView.mas_left);
            make.top.equalTo(superView.mas_top);
            make.right.equalTo(superView.mas_right);
            make.height.mas_equalTo(44);
        }
    }];
    self.headerBarLabel = [UILabel new];
    [controllerHeaderBar addSubview:headerBarLabel];
    [headerBarLabel setTextColor:[UIColor whiteColor]];
    [headerBarLabel setText:@"Actors"];
    [headerBarLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17.0]];
    [headerBarLabel setTextAlignment:NSTextAlignmentCenter];
    [headerBarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(controllerHeaderBar.mas_leading).offset(10);
        make.top.equalTo(controllerHeaderBar.mas_top).offset(12);
        make.trailing.equalTo(controllerHeaderBar.mas_trailing).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    self.actorsListTableView = [[UITableView alloc] init];
    [self.actorsListTableView setDelegate:self];
    [self.actorsListTableView setDataSource:self];
    [self.actorsListTableView registerClass:[ActorDetailsTableCell class] forCellReuseIdentifier:@"ActorDetailsTableCell"];
    self.actorsListTableView.rowHeight = UITableViewAutomaticDimension;
    self.actorsListTableView.estimatedRowHeight = 250.0;
    [self.actorsListTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [superView addSubview:self.actorsListTableView];
    [actorsListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        if (@available(iOS 11.0, *)) {
            make.left.equalTo(superView.mas_safeAreaLayoutGuideLeft);
            make.top.equalTo(controllerHeaderBar.mas_bottom).offset(0);
            make.right.equalTo(superView.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(superView.mas_safeAreaLayoutGuideBottom);
        } else {
            make.left.equalTo(superView.mas_left);
            make.top.equalTo(controllerHeaderBar.mas_bottom).offset(0);
            make.right.equalTo(superView.mas_right);
            make.bottom.equalTo(superView.mas_bottom);
        }
    }];
    
    refreshControl = [UIRefreshControl new];
    refreshControl.tintColor = [UIColor colorFromHexCode:@"#175fad"];
    [self.actorsListTableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(stopRefreshController) forControlEvents:UIControlEventValueChanged];
    
}
#pragma mark - Method to fetch data from server
-(void)fetchActorListFromServe{
    
    ActorsListServiceManager    *serviceManager = [ActorsListServiceManager sharedManager];
    [serviceManager fetchAcotrsListfromServerWithSuccess:^(BOOL resultSuccess) {        
        NSRange range = NSMakeRange(0, actorsListTableView.numberOfSections);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [actorsListTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        if (refreshControl.refreshing) {
            [refreshControl endRefreshing];
        }
    } failure:^(NSError *error) {
        if (refreshControl.refreshing) {
            [refreshControl endRefreshing];
        }
        [PXAlertController showSimpleAlertWithMessage:@"Alert.webservice.failure" inController:self];
    }];
}

#pragma mark - UIRefreshControl method
- (void)stopRefreshController {
    
    [self fetchActorListFromServe];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
