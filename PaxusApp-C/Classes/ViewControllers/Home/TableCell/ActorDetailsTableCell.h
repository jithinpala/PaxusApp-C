//
//  ActorDetailsTableCell.h
//  PaxusApp-C
//
//  Created by Jithin on 14/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "UIColor+ColorExtension.h"

@interface ActorDetailsTableCell : UITableViewCell

#pragma mark - Variable declaration

@property (nonatomic, strong) UILabel       *actorNameLabel;
@property (nonatomic, strong) UILabel       *actorCountryLabel;
@property (nonatomic, strong) UILabel       *actorDOBLabel;
@property (nonatomic, strong) UILabel       *actorChildrenLabel;
@property (nonatomic, strong) UILabel       *actorDescriptionLabel;
@property (nonatomic, strong) UIImageView   *actorImageView;
@property (nonatomic, strong) UIView        *bottomBorderView;


@end
