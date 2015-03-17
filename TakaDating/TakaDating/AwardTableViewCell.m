//
//  AwardTableViewCell.m
//  TakaDating
//
//  Created by Sumit Ghosh on 14/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "AwardTableViewCell.h"

@implementation AwardTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.containerView=[[UIView alloc]init];
        self.containerView.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:self.containerView];
        
        self.cellLable=[[UILabel alloc]init];
        self.cellLable.font=[UIFont boldSystemFontOfSize:15];
        self.cellLable.textColor=[UIColor blackColor];
        self.cellLable.numberOfLines=0;
        self.cellLable.lineBreakMode=NSLineBreakByCharWrapping;
        [self.containerView addSubview:self.cellLable];
        
        
        
        self.cellSubLbl=[[UILabel alloc]init];
        self.cellSubLbl.font=[UIFont systemFontOfSize:12];
        self.cellSubLbl.textColor=[UIColor blackColor];
        self.cellSubLbl.numberOfLines=0;
        self.cellSubLbl.lineBreakMode=NSLineBreakByCharWrapping;
        
        [self.containerView addSubview:self.cellSubLbl];
        
        self.imgView=[[UIImageView alloc]init];
        [self.containerView addSubview:self.imgView];
        if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
            self.cellLable.font=[UIFont boldSystemFontOfSize:22];
            self.cellSubLbl.font=[UIFont systemFontOfSize:20];
        }
        
    }
    return self;

}



- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
