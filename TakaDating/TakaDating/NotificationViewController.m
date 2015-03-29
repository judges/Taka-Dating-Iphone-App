//
//  NotificationViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 17/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "NotificationViewController.h"
#import "NotificationCustomCell.h"
#import "SingletonClass.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*-(void)viewWillDisappear:(BOOL)animated{
    [self.notificationTable reloadData];
}*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    windowSize=[UIScreen mainScreen].bounds.size;
    
   // self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    self.view.backgroundColor= [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)148/255 blue:(CGFloat)214/255 alpha:1.0];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, self.view.frame.size.width, 55);
   // UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
   // UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)88/255 blue:(CGFloat)211/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)0/255 blue:(CGFloat)155/255 alpha:1.0];

    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    //Adding title Label
    self.titleLabel=[[UILabel alloc]init];
    self.titleLabel.frame=CGRectMake(120, 25, 150, 25);
    self.titleLabel.text=@"Notification";
    self.titleLabel.textColor=[UIColor whiteColor];
    self.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    [self.view addSubview:self.titleLabel];
    
    //Add Cancel Button
    self.cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame=CGRectMake(15, 25, 60, 25);
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelButton.layer.borderColor=[[UIColor redColor]CGColor];
    self.cancelButton.titleLabel.font=[UIFont systemFontOfSize:15];
    self.cancelButton.layer.cornerRadius=4;
    self.cancelButton.clipsToBounds=YES;
    self.cancelButton.layer.borderWidth=0.7;
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
    //self.cancelButton.hidden=NO;
    
    self.saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.saveButton.frame=CGRectMake(15, 25, 60, 25);
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    self.saveButton.layer.borderColor=[[UIColor redColor]CGColor];
    self.saveButton.titleLabel.font=[UIFont systemFontOfSize:15];
    self.saveButton.layer.cornerRadius=4;
    self.saveButton.clipsToBounds=YES;
    self.saveButton.layer.borderWidth=0.7;
    [self.saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveButton];
    self.saveButton.hidden=YES;
    
    self.editButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.editButton.frame=CGRectMake(250, 25, 60, 25);
    [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
    self.editButton.layer.borderColor=[[UIColor redColor]CGColor];
    self.editButton.titleLabel.font=[UIFont systemFontOfSize:15];
    self.editButton.layer.cornerRadius=4;
    self.editButton.clipsToBounds=YES;
    self.editButton.layer.borderWidth=0.7;
    [self.editButton addTarget:self action:@selector(editButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.editButton];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
         layer.frame = CGRectMake(0, 0, windowSize.width, 75);
        self.titleLabel.frame=CGRectMake(windowSize.width/2-50, 25, windowSize.width/2, 25);
        self.cancelButton.frame=CGRectMake(windowSize.width/2-350, 25, 120, 40);
        self.saveButton.frame=CGRectMake(windowSize.width-150, 25, 120, 40);
        self.editButton.frame=CGRectMake(windowSize.width-150, 25, 120, 40);
        
         self.cancelButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
         self.saveButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
         self.editButton.titleLabel.font=[UIFont boldSystemFontOfSize:20];
         self.titleLabel.font=[UIFont boldSystemFontOfSize:30];
        
    }
    
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)createUI{
    self.notificationTable=[[UITableView alloc]init];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
         self.notificationTable.frame=CGRectMake(0, 75, windowSize.width, windowSize.height-80);
        cell_hh=85.0;
        cell_font=25.0;
        cell_x=15;
    
        frameMbtn=CGRectMake(windowSize.width-200, 15, 40, 40);
        frameLbtn=CGRectMake(windowSize.width-100, 15, 40, 40);
        frame_bottomLbl=CGRectMake(windowSize.width-700, 20, windowSize.width-155, 120);
    }
    else{
        cell_hh=40.0;
        cell_font=12.0;
        cell_x=5;
        frameMbtn=CGRectMake(windowSize.width-100, 5, 25, 25);
        frameLbtn=CGRectMake(windowSize.width-60, 5, 25, 25);
        frame_bottomLbl=CGRectMake(windowSize.width-300, 10, windowSize.width-70, 60);
        if ([UIScreen mainScreen].bounds.size.height>500) {
            self.notificationTable.frame=CGRectMake(0, 55, windowSize.width, windowSize.height-80);
        }
        else{
            self.notificationTable.frame=CGRectMake(0, 55, windowSize.width, windowSize.height-80);
        }
    }
    self.notificationTable.delegate=self;
    self.notificationTable.dataSource=self;
    self.notificationTable.backgroundColor= [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)148/255 blue:(CGFloat)214/255 alpha:1.0];
    
    self.notificationTable.separatorColor= [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)148/255 blue:(CGFloat)214/255 alpha:1.0];
    self.notificationTable.userInteractionEnabled=NO;
    [self.view addSubview:self.notificationTable];
}

#pragma mark- TableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        return 0;
    }
    return 8;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 120;
    }
    return 35;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  cell_hh;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
    NotificationCustomCell * cell=(NotificationCustomCell*)[tableView cellForRowAtIndexPath:indexPath];
    if(cell==nil)
    {
        cell=[[NotificationCustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        [cell.mobileButton addTarget:self action:@selector(mobileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.letterButton addTarget:self action:@selector(letterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.containerView.frame = CGRectMake(0, 0, windowSize.width, cell_hh);
  
    cell.cellLabel.font=[UIFont systemFontOfSize:cell_font];
    cell.cellLabel.frame = CGRectMake(cell_x, 0, cell.frame.size.width-100 , cell.frame.size.height);
   
    
    cell.mobileButton.frame=frameMbtn;
    cell.letterButton.frame=frameLbtn;
    if (indexPath.section==0) {
        
    
    if(indexPath.row==0)
    {
        cell.cellLabel.text =@"Messages";
      
        cell.letterButton.titleLabel.textColor=[UIColor blackColor];
         cell.mobileButton.titleLabel.textColor=[UIColor blackColor];
        cell.mobileButton.tag=indexPath.row;
        cell.letterButton.tag=indexPath.row;
        
        if ([[SingletonClass shareSingleton].newmsgEmail isEqualToString:@"on"]) {
            [cell.letterButton setSelected:YES];
        }
        else{
            [cell.letterButton setSelected:NO];
        }
        if ([[SingletonClass shareSingleton].newmsgMobile isEqualToString:@"on"]) {
            [cell.mobileButton setSelected:YES];
        }
        else{
            [cell.mobileButton setSelected:NO];
        }
    }
    if(indexPath.row==1)
    {
       
        cell.mobileButton.tag=indexPath.row;
        cell.letterButton.tag=indexPath.row;
        cell.letterButton.titleLabel.textColor=[UIColor blackColor];
        cell.mobileButton.titleLabel.textColor=[UIColor blackColor];
        
        if ([[SingletonClass shareSingleton].profvisitEmail isEqualToString:@"on"]) {
            [cell.letterButton setSelected:YES];
        }
        else{
            [cell.letterButton setSelected:NO];
        }
        if ([[SingletonClass shareSingleton].profvisitMobile isEqualToString:@"on"]) {
            [cell.mobileButton setSelected:YES];
        }
        else{
            [cell.mobileButton setSelected:NO];
        }
        cell.cellLabel.text =@"Profile visitors";
        
    }
    if(indexPath.row==2)
    {
     
        cell.mobileButton.tag=indexPath.row;
        cell.letterButton.tag=indexPath.row;
        cell.letterButton.titleLabel.textColor=[UIColor blackColor];
        cell.mobileButton.titleLabel.textColor=[UIColor blackColor];
        
        if ([[SingletonClass shareSingleton].peopleEmail isEqualToString:@"on"]) {
            [cell.letterButton setSelected:YES];
        }
        else{
            [cell.letterButton setSelected:NO];
        }
        if ([[SingletonClass shareSingleton].peopleMobile isEqualToString:@"on"]) {
            [cell.mobileButton setSelected:YES];
        }
        else{
            [cell.mobileButton setSelected:NO];
        }
        cell.cellLabel.text =@"People";
    }
    if(indexPath.row==3)
    {
     
        cell.mobileButton.tag=indexPath.row;
        cell.letterButton.tag=indexPath.row;
        cell.letterButton.titleLabel.textColor=[UIColor blackColor];
        cell.mobileButton.titleLabel.textColor=[UIColor blackColor];
        
        if ([[SingletonClass shareSingleton].rateEmail isEqualToString:@"on"]) {
            [cell.letterButton setSelected:YES];
        }
        else{
            [cell.letterButton setSelected:NO];
        }
        if ([[SingletonClass shareSingleton].rateMobile isEqualToString:@"on"]) {
            [cell.mobileButton setSelected:YES];
        }
        else{
            [cell.mobileButton setSelected:NO];
        }
        cell.cellLabel.text =@"New photo ratings";
    }
    if(indexPath.row==4)
    {
        
        cell.mobileButton.tag=indexPath.row;
        cell.letterButton.tag=indexPath.row;
        cell.letterButton.titleLabel.textColor=[UIColor blackColor];
        cell.mobileButton.titleLabel.textColor=[UIColor blackColor];
        if ([[SingletonClass shareSingleton].alertEmail isEqualToString:@"on"]) {
            [cell.letterButton setSelected:YES];
        }
        else{
            [cell.letterButton setSelected:NO];
        }
        if ([[SingletonClass shareSingleton].alertMobile isEqualToString:@"on"]) {
            [cell.mobileButton setSelected:YES];
        }
        else{
            [cell.mobileButton setSelected:NO];
        }

        cell.cellLabel.text =@"Alerts";
    }
    if(indexPath.row==5)
    {
        
        cell.mobileButton.titleLabel.textColor=[UIColor blackColor];
        cell.mobileButton.tag=indexPath.row;
        cell.letterButton.tag=indexPath.row;
        if ([[SingletonClass shareSingleton].favEmail isEqualToString:@"on"]) {
            [cell.letterButton setSelected:YES];
        }
        else{
            [cell.letterButton setSelected:NO];
        }
        if ([[SingletonClass shareSingleton].favMobile isEqualToString:@"on"]) {
            [cell.mobileButton setSelected:YES];
        }
        else{
            [cell.mobileButton setSelected:NO];
        }
        cell.cellLabel.text =@"Favorite";
    }
    if(indexPath.row==6)
    {
         cell.letterButton.tag=indexPath.row;
        cell.mobileButton.tag=indexPath.row;
        cell.letterButton.titleLabel.textColor=[UIColor blackColor];
        
        if ([[SingletonClass shareSingleton].newsEmail isEqualToString:@"on"]) {
            [cell.letterButton setSelected:YES];
        }
        else{
            [cell.letterButton setSelected:NO];
        }
        if ([[SingletonClass shareSingleton].newsMobile isEqualToString:@"on"]) {
            [cell.mobileButton setSelected:YES];
        }
        else{
            [cell.mobileButton setSelected:NO];
        }

        cell.cellLabel.text =@"News";
    }
    if(indexPath.row==7)
    {
        cell.letterButton.tag=indexPath.row;
        cell.mobileButton.tag=indexPath.row;
        cell.letterButton.titleLabel.textColor=[UIColor blackColor];
        if ([[SingletonClass shareSingleton].giftEmail isEqualToString:@"on"]) {
                [cell.letterButton setSelected:YES];
        }
        else{
              [cell.letterButton setSelected:NO];
        }
        if ([[SingletonClass shareSingleton].giftMobile isEqualToString:@"on"]) {
           [cell.mobileButton setSelected:YES];
        }
        else{
            [cell.mobileButton setSelected:NO];
        }
        
        
        cell.cellLabel.text =@"Gifts";
    }
    }
    return  cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view;
    if (section==1) {
       view=[[UIView alloc]init];
        view.frame=CGRectMake(0, 10, self.view.frame.size.width, 60);
        view.backgroundColor=[UIColor clearColor];
        
        UILabel * label=[[UILabel alloc]init];
        label.frame=frame_bottomLbl;
        label.textColor=[UIColor blackColor];
        label.text=@"Keep notification enabled to be alerted of what's going on in your profile.";
        label.font=[UIFont systemFontOfSize:cell_font];
        label.lineBreakMode=NSLineBreakByCharWrapping;
        label.numberOfLines=0;
        label.textAlignment=NSTextAlignmentCenter;
        [view addSubview:label];
       
    }
     return view;
}

#pragma  mark- Button action for notification activation

-(void)mobileButtonAction:(id)sender{
    
    //self.cancelButton.hidden=YES;
    NSInteger tagValue = [sender tag];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tagValue inSection:0];
    NotificationCustomCell * cell = (NotificationCustomCell*)[self.notificationTable cellForRowAtIndexPath:indexPath];
  //  NSInteger selected=[sender tag];
    if(tagValue==0)
    {
        if (cell.mobileButton.selected==NO) {
            [cell.mobileButton setSelected:YES];
            [SingletonClass shareSingleton].newmsgMobile=@"on";
            //self.newmsgMobile=@"on";
        }
        else
        {
            //self.newmsgMobile=@"off";
            [SingletonClass shareSingleton].newmsgMobile=@"off";
            [cell.mobileButton setSelected:NO];
        }
    }
    if(tagValue==1)
    {
        if (cell.mobileButton.selected==NO) {
            [cell.mobileButton setSelected:YES];
            [SingletonClass shareSingleton].profvisitMobile=@"on";
             //self.profvisitMobile=@"on";
        }
        else
        {
            // self.profvisitMobile=@"off";
            [SingletonClass shareSingleton].profvisitMobile=@"off";
            [cell.mobileButton setSelected:NO];
        }
    }
    if(tagValue==2)
    {
        if (cell.mobileButton.selected==NO) {
            [cell.mobileButton setSelected:YES];
           // self.peopleMobile=@"on";
            [SingletonClass shareSingleton].peopleMobile=@"on";
        }
        else
        {
            //self.peopleMobile=@"off";
            [SingletonClass shareSingleton].peopleMobile=@"off";
            [cell.mobileButton setSelected:NO];
        }
    }
    if(tagValue==3)
    {
        if (cell.mobileButton.selected==NO) {
            [cell.mobileButton setSelected:YES];
            //self.rateMobile=@"on";
            [SingletonClass shareSingleton].rateMobile=@"on";
        }
        else
        {
            //self.rateMobile=@"off";
            [SingletonClass shareSingleton].rateMobile=@"off";
            [cell.mobileButton setSelected:NO];
        }
    }
    if(tagValue==4)
    {
        if (cell.mobileButton.selected==NO) {
            [cell.mobileButton setSelected:YES];
            //self.alertMobile=@"on";
            [SingletonClass shareSingleton].alertMobile=@"on";
        }
        else
        {
            self.alertMobile=@"off";
            [SingletonClass shareSingleton].alertMobile=@"off";
            [cell.mobileButton setSelected:NO];
        }
    }
    if(tagValue==5)
    {
        if (cell.mobileButton.selected==NO) {
            [cell.mobileButton setSelected:YES];
            //self.favMobile=@"on";
            [SingletonClass shareSingleton].favMobile=@"on";
        }
        else
        {
            self.favMobile=@"off";
            [SingletonClass shareSingleton].favMobile=@"off";
            //[cell.mobileButton setSelected:NO];
        }
    }
    if(tagValue==6)
    {
        if (cell.mobileButton.selected==NO) {
            [cell.mobileButton setSelected:YES];
            [SingletonClass shareSingleton].newsMobile=@"on";
            //self.newsMobile=@"on";
        }
        else
        {
           // self.newsMobile=@"off";
            [SingletonClass shareSingleton].newsMobile=@"off";
            
            [cell.mobileButton setSelected:NO];
        }
    }
    if(tagValue==7)
    {
        if (cell.mobileButton.selected==NO) {
            [cell.mobileButton setSelected:YES];
            //self.giftEmail=@"on";
            [SingletonClass shareSingleton].giftMobile=@"on";
        }
        else
        {
            //self.giftEmail=@"off";
            [SingletonClass shareSingleton].giftMobile=@"off";
            [cell.mobileButton setSelected:NO];
        }
    }

}




-(void)letterButtonAction:(id)sender{
    //self.cancelButton.hidden=YES;
    NSInteger tagValue = [sender tag];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tagValue inSection:0];
    NotificationCustomCell * cell = (NotificationCustomCell*)[self.notificationTable cellForRowAtIndexPath:indexPath];
   // NSInteger selected=[sender tag];
    if(tagValue==0)
    {
        if (cell.letterButton.selected==NO) {
            [cell.letterButton setSelected:YES];
            //self.newmsgEmail=@"on";
            [SingletonClass shareSingleton].newmsgEmail=@"on";
        }
        else
        {
           // self.newmsgEmail=@"off";
          [SingletonClass shareSingleton].newmsgEmail=@"off";
            [cell.letterButton setSelected:NO];
        }
    }
    if(tagValue==1)
    {
        if (cell.letterButton.selected==NO) {
            [cell.letterButton setSelected:YES];
            //self.profvisitEmail=@"on";
            [SingletonClass shareSingleton].profvisitEmail=@"on";
        }
        else
        {
            //self.profvisitEmail=@"off";
            [SingletonClass shareSingleton].profvisitEmail=@"off";
            [cell.letterButton setSelected:NO];
        }
    }
    if(tagValue==2)
    {
        if (cell.letterButton.selected==NO) {
            [cell.letterButton setSelected:YES];
            //self.peopleEmail=@"on";
            [SingletonClass shareSingleton].peopleEmail=@"on";
        }
        else
        {
            //self.peopleEmail=@"off";
            [SingletonClass shareSingleton].peopleEmail=@"off";
            [cell.letterButton setSelected:NO];
        }
    }
    if(tagValue==3)
    {
        if (cell.letterButton.selected==NO) {
            [cell.letterButton setSelected:YES];
            //self.rateEmail=@"on";
            [SingletonClass shareSingleton].rateEmail=@"on";
        }
        else
        {
            //self.rateEmail=@"off";
            [SingletonClass shareSingleton].rateEmail=@"off";
            [cell.letterButton setSelected:NO];
        }
    }
    if(tagValue==4)
    {
        if (cell.letterButton.selected==NO) {
            [cell.letterButton setSelected:YES];
           // self.alertEmail=@"on";
            [SingletonClass shareSingleton].alertEmail=@"on";
        }
        else
        {
            //self.alertEmail=@"off";
            [SingletonClass shareSingleton].alertEmail=@"off";
            [cell.letterButton setSelected:NO];
        }
    }
    if(tagValue==5)
    {
        if (cell.letterButton.selected==NO) {
            [cell.letterButton setSelected:YES];
            //self.favEmail=@"on";
            [SingletonClass shareSingleton].favEmail=@"on";
        }
        else
        {
            //self.favEmail=@"off";
            [SingletonClass shareSingleton].favEmail=@"off";
            [cell.letterButton setSelected:NO];
        }
    }
    
    if(tagValue==6)
    {
        if (cell.letterButton.selected==NO) {
            [cell.letterButton setSelected:YES];
            //self.newsEmail=@"on";
            [SingletonClass shareSingleton].newsEmail=@"on";
        }
        else
        {
           // self.newsEmail=@"off";
           [SingletonClass shareSingleton].newsEmail=@"off";
            [cell.letterButton setSelected:NO];
        }
    }
    if(tagValue==7)
    {
        if (cell.letterButton.selected==NO) {
            [cell.letterButton setSelected:YES];
            //self.giftEmail=@"on";
            [SingletonClass shareSingleton].giftEmail=@"on";
        }
        else
        {
            //self.giftEmail=@"off";
           [SingletonClass shareSingleton].giftEmail=@"off";
            [cell.letterButton setSelected:NO];
        }
    }
  }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)editButtonMethod:(id)sender{
    self.notificationTable.userInteractionEnabled=YES;
    self.cancelButton.hidden=YES;
    self.saveButton.hidden=NO;
    self.editButton.hidden=YES;
}

-(void)saveButtonAction:(id)sender{
    self.notificationTable.userInteractionEnabled=NO;
        
    
    
    
    NSError *error = nil;
    NSURLResponse *urlResponse=nil;
    
    /* NSString * urlstr=[NSString stringWithFormat:@"http://taka.dating/notification/settings/%@/%@/%@/%@/%@/%@/%@/%@/%@/%@/%@/%@/%@/%@/%@/%@/%@",[SingletonClass shareSingleton].userID,[SingletonClass shareSingleton].newmsgEmail,[SingletonClass shareSingleton].profvisitEmail,[SingletonClass shareSingleton].peopleEmail,[SingletonClass shareSingleton].rateEmail,[SingletonClass shareSingleton].alertEmail,[SingletonClass shareSingleton].favEmail,[SingletonClass shareSingleton].newsEmail,[SingletonClass shareSingleton].giftEmail,[SingletonClass shareSingleton].newmsgMobile,[SingletonClass shareSingleton].profvisitMobile,[SingletonClass shareSingleton].peopleMobile,[SingletonClass shareSingleton].rateMobile,[SingletonClass shareSingleton].alertMobile,[SingletonClass shareSingleton].favMobile,[SingletonClass shareSingleton].newsMobile,[SingletonClass shareSingleton].giftMobile];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];*/
    NSURL * url=[NSURL URLWithString:@"http://23.238.24.26/settings/notification-settings/"];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString * body=[NSString stringWithFormat:@"userId=%@&newmsgEmail=%@&profvisitEmail=%@&peopleEmail=%@&rateEmail=%@&alertEmail=%@&favEmail=%@&newsEmail=%@&giftEmail=%@&newmsgMobile=%@&profvisitMobile=%@&peopleMobile=%@&rateMobile=%@&alertMobile=%@&favMobile=%@&newsMobile=%@&giftMobile=%@",[SingletonClass shareSingleton].userID,[SingletonClass shareSingleton].newmsgEmail,[SingletonClass shareSingleton].profvisitEmail,[SingletonClass shareSingleton].peopleEmail,[SingletonClass shareSingleton].rateEmail,[SingletonClass shareSingleton].alertEmail,[SingletonClass shareSingleton].favEmail,[SingletonClass shareSingleton].newsEmail,[SingletonClass shareSingleton].giftEmail,[SingletonClass shareSingleton].newmsgMobile,[SingletonClass shareSingleton].profvisitMobile,[SingletonClass shareSingleton].peopleMobile,[SingletonClass shareSingleton].rateMobile,[SingletonClass shareSingleton].alertMobile,[SingletonClass shareSingleton].favMobile,[SingletonClass shareSingleton].newsMobile,[SingletonClass shareSingleton].giftMobile];
    
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    if(data==nil)
    {
        
        NSLog(@"No data available %@",error);
        return;
    }
    
        
        NSLog(@"Saved succesfully");
    
    
    self.cancelButton.hidden=NO;
    self.saveButton.hidden=YES;
    self.editButton.hidden=NO;
//   id  parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"Parse %@",parse);
  
    
    
}


-(void)cancelButtonAction:(id)sender{
    
      //[[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
