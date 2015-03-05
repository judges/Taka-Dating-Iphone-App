//
//  SelectClassCell.h
//  TakaDating
//
//  Created by Sumit Ghosh on 16/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectClassCell : UITableViewCell
@property(nonatomic,strong)UIView * containerView;
@property(nonatomic,strong)UIButton * rightButton,* leftbutton;
@property(nonatomic,strong)UILabel * cellLabel;
@end
