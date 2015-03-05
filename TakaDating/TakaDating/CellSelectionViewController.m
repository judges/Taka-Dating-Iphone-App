//
//  CellSelectionViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 19/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "CellSelectionViewController.h"

@interface CellSelectionViewController ()

@end

@implementation CellSelectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    
    windowSize=[UIScreen mainScreen].bounds.size;
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    //Adding title Label
    self.titleLabel=[[UILabel alloc]init];
    
    self.titleLabel.text=self.titleStr;
    self.titleLabel.textColor=[UIColor whiteColor];
    
    [self.view addSubview:self.titleLabel];
    
    //Add Cancel Button
    self.cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelButton.layer.borderColor=[[UIColor redColor]CGColor];
    
    self.cancelButton.layer.cornerRadius=4;
    self.cancelButton.clipsToBounds=YES;
    self.cancelButton.layer.borderWidth=0.7;
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
    
    
    self.sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
   
    [self.sendButton setTitle:@"Send" forState:UIControlStateNormal];
   
    [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sendButton.clipsToBounds=YES;
    self.sendButton.backgroundColor=[UIColor clearColor];
    self.sendButton.layer.borderColor=[[UIColor redColor]CGColor];
    self.sendButton.layer.borderWidth=0.7;
    self.sendButton.layer.cornerRadius=4;
    [self.sendButton addTarget:self action:@selector(sendButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sendButton];
    
    
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        layer.frame = CGRectMake(0, 0, windowSize.width, 75);
        self.titleLabel.frame=CGRectMake(windowSize.width/2-40, 25, 150, 40);
        self.cancelButton.frame=CGRectMake(windowSize.width/2-365, 25, 110, 40);
         self.sendButton.frame=CGRectMake(windowSize.width-130, 25, 110, 40);
        
        self.titleLabel.font=[UIFont boldSystemFontOfSize:25];
        self.cancelButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
         self.sendButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
        
    }
    else{
        
        layer.frame = CGRectMake(0, 0, windowSize.width, 55);
        self.titleLabel.frame=CGRectMake(windowSize.width/2-40, 25, 100, 25);
        self.cancelButton.frame=CGRectMake(windowSize.width-305, 25, 60, 25);
         self.sendButton.frame=CGRectMake(windowSize.width-30, 25, 60, 25);
        
        self.titleLabel.font=[UIFont boldSystemFontOfSize:20];
        self.cancelButton.titleLabel.font=[UIFont systemFontOfSize:15];
         self.sendButton.titleLabel.font=[UIFont systemFontOfSize:15];
        
    }
    
   
    
    [self createUI];

    // Do any additional setup after loading the view from its nib.
}

#pragma mark-CreatUI
-(void)createUI{
    CALayer * layer=[[CALayer alloc]init];
    //layer.frame=CGRectMake(15, 70, self.view.frame.size.width-30, 305);
    layer.backgroundColor=[UIColor whiteColor].CGColor;
    layer.borderColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)97/255 blue:(CGFloat)97/255 alpha:1.0].CGColor;
    
    layer.borderWidth=0.7;
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.textView=[[UITextView alloc]init];
    self.textView.backgroundColor=[UIColor whiteColor];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        self.textView.frame=CGRectMake(15, 100, windowSize.width-30, windowSize.height/2-200);
    }
    else
    {
    if ([UIScreen mainScreen].bounds.size.height<500) {
        self.textView.frame=CGRectMake(15, 70, self.view.frame.size.width-30, 150);
    }
    else{
    self.textView.frame=CGRectMake(15, 70, self.view.frame.size.width-30,230 );
    }
}//else part
    self.textView.delegate=self;
    self.textView.editable=YES;
    self.textView.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:self.textView];
    
    UILabel * bottomLabel=[[UILabel alloc]init];
    
   
        bottomLabel.frame=CGRectMake(5, self.view.frame.size.height-49, self.view.frame.size.width, 50);

    bottomLabel.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)106/255 alpha:1.0];;
    bottomLabel.text=@"For more information  tap here to visit our Help Section.";
    bottomLabel.font=[UIFont systemFontOfSize:12];
    bottomLabel.textColor=[UIColor grayColor];
   [self.view addSubview:bottomLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBottomLabelTap:)];
    [bottomLabel addGestureRecognizer:tap];
    
    
    
    for (UIView *view in self.view.subviews)
    {
        if ([view isKindOfClass:[UITextView  class]])
        {
            [view becomeFirstResponder];
//             self.textView.frame=CGRectMake(15, 70, self.view.frame.size.width-30, 150);
            if ([UIScreen mainScreen].bounds.size.height<500) {
                bottomLabel.frame=CGRectMake(5, 230, self.view.frame.size.width, 50);
            }
            else{
            bottomLabel.frame=CGRectMake(5, 305, self.view.frame.size.width, 50);
            }
            [self.view insertSubview:bottomLabel aboveSubview:self.textView];

//           [bottomLabel becomeFirstResponder];
            break;
        }
    }

    
}

#pragma mark-TextViewDelegate Method



-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
   
        if(!text)
        {
         UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Done!" message:@"Thanks for your feedback, we'll act on it shortly." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
            
     }
    
    
   
    return YES;
    
}


#pragma mark- Tap gesture
-(void)handleBottomLabelTap:(UITapGestureRecognizer *) tap{
    NSLog(@" Bottom Label tapped..!");
}

#pragma mark-alertView Deleagte methods
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0)
    {
        //[self.textView resignFirstResponder];
       // [self.navigationController popViewControllerAnimated:YES];
//        [[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
    }
}


#pragma  mark- send Buttom

-(void)sendButtonAction:(id)sender{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Done!" message:@"Thanks for your feedback, we'll act on it shortly." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    

    if(self.indexRow==0)
    {
        NSLog(@"ErrorBugs are sent..!");
    }
    if(self.indexRow==1)
    {
        NSLog(@"Your ideas are sent..!");
    }
    if(self.indexRow==2)
    {
        NSLog(@"Question has sent..!");
    }
    if(self.indexRow==3)
    {
        NSLog(@"Bussiness matters  are sent..!");
    }
    if(self.indexRow==4)
    {
        NSLog(@"Billing questions..!");
    }
    
}
#pragma mark-

-(void)cancelButtonAction:(id)sender{
    self.titleStr=nil;
    [self.navigationController popViewControllerAnimated:YES];
    //[[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
