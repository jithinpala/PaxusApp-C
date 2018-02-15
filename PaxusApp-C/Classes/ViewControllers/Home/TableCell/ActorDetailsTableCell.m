//
//  ActorDetailsTableCell.m
//  PaxusApp-C
//
//  Created by Jithin on 14/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

#import "ActorDetailsTableCell.h"

@implementation ActorDetailsTableCell
@synthesize actorNameLabel;
@synthesize actorDOBLabel;
@synthesize actorCountryLabel;
@synthesize actorChildrenLabel;
@synthesize actorDescriptionLabel;
@synthesize actorImageView;
@synthesize bottomBorderView;


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureCellUserInterFace];
    }
    return self;
}

#pragma mark - Configure the cell interface
- (void)configureCellUserInterFace {
    UIView *superContentView = self.contentView;
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.actorImageView = [UIImageView new];
    
    [superContentView addSubview:actorImageView];
    [actorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.left.equalTo(superContentView.mas_left).offset(20);
        make.top.equalTo(superContentView.mas_top).offset(15);       
    }];
    [actorImageView.layer setCornerRadius:40];
    [actorImageView.layer setMasksToBounds:true];
    
    self.actorNameLabel = [UILabel new];
    [superContentView addSubview:self.actorNameLabel];    
    [actorNameLabel setTextColor:[UIColor blackColor]];
    [actorNameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [actorNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(actorImageView.mas_trailing).offset(20);
        make.top.equalTo(superContentView.mas_top).offset(45);
        make.trailing.equalTo(superContentView.mas_trailing).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    self.actorCountryLabel = [UILabel new];
    [superContentView addSubview:actorCountryLabel];
    [actorCountryLabel setBackgroundColor:[UIColor clearColor]];
    [actorCountryLabel setTextColor:[UIColor darkGrayColor]];
    [actorCountryLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [actorCountryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(superContentView.mas_leading).offset(20);
        make.top.equalTo(actorImageView.mas_bottom).offset(10);
        make.trailing.equalTo(superContentView.mas_trailing).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    self.actorDOBLabel = [UILabel new];
    [superContentView addSubview:actorDOBLabel];
    [actorDOBLabel setBackgroundColor:[UIColor clearColor]];
    [actorDOBLabel setTextColor:[UIColor darkGrayColor]];
    [actorDOBLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [actorDOBLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(superContentView.mas_leading).offset(20);
        make.top.equalTo(actorCountryLabel.mas_bottom).offset(10);
        make.trailing.equalTo(superContentView.mas_trailing).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    self.actorChildrenLabel = [UILabel new];
    [superContentView addSubview:actorChildrenLabel];
    [actorChildrenLabel setNumberOfLines:0];
    [actorChildrenLabel setBackgroundColor:[UIColor clearColor]];
    [actorChildrenLabel setTextColor:[UIColor lightGrayColor]];
    [actorChildrenLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [actorChildrenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(superContentView.mas_leading).offset(20);
        make.top.equalTo(actorDOBLabel.mas_bottom).offset(10);
        make.trailing.equalTo(superContentView.mas_trailing).offset(-10);
    }];
    
    self.actorDescriptionLabel = [UILabel new];
    [superContentView addSubview:actorDescriptionLabel];
    [actorDescriptionLabel setNumberOfLines:0];
    [actorDescriptionLabel setBackgroundColor:[UIColor clearColor]];
    [actorDescriptionLabel setTextColor:[UIColor lightGrayColor]];
    [actorDescriptionLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [actorDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(superContentView.mas_leading).offset(20);
        make.top.equalTo(actorChildrenLabel.mas_bottom).offset(10);
        make.trailing.equalTo(superContentView.mas_trailing).offset(-10);
        //make.bottom.equalTo(superContentView.mas_bottom).offset(-10);
    }];
    
    self.bottomBorderView = [UIView new];
    [superContentView addSubview:bottomBorderView];
    [bottomBorderView setBackgroundColor:[UIColor colorFromHexCode:@"#175fad"]];
    [bottomBorderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(superContentView.mas_leading).offset(20);
        make.top.equalTo(actorDescriptionLabel.mas_bottom).offset(10);
        make.trailing.equalTo(superContentView.mas_trailing).offset(0);
        make.bottom.equalTo(superContentView.mas_bottom).offset(0);
        make.height.mas_equalTo(1);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
