//
//  CellSelectionViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 19/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellSelectionViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate>
{
    CGSize windowSize;
}

@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)int indexRow;
@property(nonatomic)NSString * titleStr;
@property(nonatomic)UIButton * cancelButton,* sendButton;
@property(nonatomic)UITextView * textView;
@property(nonatomic)UIScrollView * scroll;
@end
