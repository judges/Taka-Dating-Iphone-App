//
//  CreditsCustomCell.m
//  TakaDating
//
//  Created by Sumit Ghosh on 12/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "CreditsCustomCell.h"

@implementation CreditsCustomCell

- (void)awakeFromNib
{
    // Initialization code
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, 320, 200)];
    self.containerView.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)251/255 blue:(CGFloat)251/255 alpha:1];
    [self.contentView addSubview:self.containerView];

    
    self.topLabel=[[UILabel alloc]init];
    self.topLabel.frame=CGRectMake(10, 10, 200, 60);
    self.topLabel.text=@"Boosting your popularity just got really easy! Refill your Taka  credits and meet new people faster than ever";
    self.topLabel.font=[UIFont systemFontOfSize:8];
    self.topLabel.textColor=[UIColor blackColor];
    self.topLabel.lineBreakMode=NSLineBreakByCharWrapping;
    self.topLabel.numberOfLines=0;
    [self.topLabel sizeToFit];
    [self.containerView addSubview:self.topLabel];
    
    self.bottomLabel=[[UILabel alloc]init];
    self.bottomLabel.frame=CGRectMake(10, 70, 200, 60);
    self.bottomLabel.text=@"Your credit balance";
    self.bottomLabel.font=[UIFont boldSystemFontOfSize:12];
     self.bottomLabel.textColor=[UIColor blackColor];
    self.bottomLabel.lineBreakMode=NSLineBreakByCharWrapping;
    self.bottomLabel.numberOfLines=0;
    [self.bottomLabel sizeToFit];
    [self.containerView addSubview:self.bottomLabel];
    
    self.refillCredits=[UIButton buttonWithType:UIButtonTypeCustom];
    self.refillCredits.frame=CGRectMake(10, 200, 200, 25);
    self.refillCredits.backgroundColor=[UIColor blueColor];
    self.refillCredits.layer.cornerRadius=4;
    self.refillCredits.clipsToBounds=YES;
    [self.containerView addSubview:self.refillCredits];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
