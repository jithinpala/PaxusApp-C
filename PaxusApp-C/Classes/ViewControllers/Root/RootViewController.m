//
//  RootViewController.m
//  PaxusApp-C
//
//  Created by Jithin on 14/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import "RootViewController.h"
#import "PXAnimation.h"
#import "UIColor+ColorExtension.h"


@interface RootViewController ()

@end

@implementation RootViewController
@synthesize homeNavController;
@synthesize animationImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self launchHomeScreen];
    [self configureUserInterFaceAndAnimation];
    [[PXAnimation sharedManager] playAnimationWithImageView:self.animationImageView completion:^(BOOL finishedStatus) {
        [self launchHomeScreen];
    }];
}

-(void)removeNavigationController{
    if (homeNavController != nil) {       
        [homeNavController.view removeFromSuperview];
        [homeNavController removeFromParentViewController];        
    }
}

-(void)launchHomeScreen {
    [self removeNavigationController];
    UIViewController *actorsListController = [[ActorsListViewController alloc] init];
    actorsListController.view.backgroundColor = [UIColor whiteColor];
    homeNavController = [[UINavigationController alloc] initWithRootViewController:actorsListController];
    [homeNavController setNavigationBarHidden:true animated:false];
    [self.view addSubview:homeNavController.view];
    [self addChildViewController:homeNavController];
    [homeNavController didMoveToParentViewController:self];
}

-(void)configureUserInterFaceAndAnimation {
    UIView *superView = self.view;
    [superView setBackgroundColor:[UIColor colorFromHexCode:@"#175fad"]];
    
    self.animationImageView = [UIImageView new];
    self.animationImageView.image = [UIImage imageNamed:@"launchImage"];
    [superView addSubview:animationImageView];
    [animationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView.mas_centerX);
        make.centerY.equalTo(superView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(160, 160));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


