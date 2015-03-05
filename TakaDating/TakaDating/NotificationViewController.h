//
//  NotificationViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 17/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    CGSize windowSize;
    CGFloat font_size,cell_font,cell_hh,cell_x,cell_mbtn,cell_lBtn;
    CGRect frameMbtn,frameLbtn,frame_bottomLbl;
}

@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)UIButton * cancelButton, *saveButton,*editButton;
@property(nonatomic)UITableView * notificationTable;

@property(nonatomic)NSString * newmsgEmail,*newmsgMobile,*profvisitEmail,*profvisitMobile,*peopleEmail,*peopleMobile,*rateEmail,*rateMobile,*alertEmail,*alertMobile,*favEmail,*favMobile,*newsEmail,*newsMobile,*giftEmail,*giftMobile;

@end
