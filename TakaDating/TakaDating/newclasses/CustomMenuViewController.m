
//
//  CustomMenuViewController.m
//  MOVYT
//
//  Created by Sumit Ghosh on 27/05/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "CustomMenuViewController.h"
#import <objc/runtime.h>
#import "SettingViewController.h"
#import "ProfileViewController.h"
#import "EncounterFilterViewController.h"
#import "ProfileNearFilterViewController.h"
#import "SingletonClass.h"
#import "AppDelegate.h"
#import "PhotoViewController.h"
#import "LikedYouViewController.h"
#import "PeopleNearByViewController.h"
#import "CustomTableCell.h"


@interface CustomMenuViewController ()
{
    AppDelegate * appdelegate;
    ProfileNearFilterViewController * pnbVC;
    PhotoViewController * photoVC;
    LikedYouViewController * likedYouVC;
}
@property(nonatomic,strong)SettingViewController * settingVC;
@property(nonatomic,strong)EncounterFilterViewController * encounterFiletrVC;

@end

@implementation CustomMenuViewController
@synthesize nav;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



#pragma mark -
-(void) setViewControllers:(NSArray *)viewControllers{
    
    _viewControllers = [viewControllers copy];
    
    for (UIViewController *viewController in _viewControllers) {
        [self addChildViewController:viewController];
        viewController.view.frame = CGRectMake(0, 55,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height-55);
        
        [viewController didMoveToParentViewController:self];
    }
    
}
-(void) setSecondSectionViewControllers:(NSArray *)secondSectionViewControllers{
    _secondSectionViewControllers = [secondSectionViewControllers copy];
    
    for (UIViewController *viewController in self.secondSectionViewControllers ) {
        [self addChildViewController:viewController];
        viewController.view.frame = CGRectMake(0, 55,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height-55);
        [viewController didMoveToParentViewController:self];
    }
}
-(void) setSelectedViewController:(UIViewController *)selectedViewController{
    _selectedViewController = selectedViewController;
}

-(void) setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
}

-(NSArray *) getAllViewControllers{
    return self.viewControllers;
}
-(void) setSelectedSection:(NSInteger)selectedSection{
    _selectedSection = selectedSection;
}
-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:YES];
    
    // [self.navigationController pushViewController:self.settingVC animated:YES];
    //[self presentViewController:nav  animated:YES completion:nil];
}

#pragma mark -
- (void)viewDidLoad

{
    
    [super viewDidLoad];
    [SingletonClass shareSingleton].userImages =[[NSMutableArray alloc]init];
   [SingletonClass shareSingleton].viewerID=[[NSMutableArray alloc]init];
    [SingletonClass shareSingleton].viewerImage=[[NSMutableArray alloc]init];
    [SingletonClass shareSingleton].viewerName=[[NSMutableArray alloc]init];
  
    self.nav=[[UINavigationController alloc]init];
    //---------
    
    menuImgArr=[NSArray arrayWithObjects:@"profile_male.png",@"people_nearby.png",@"encounter.png",nil];
    sectionArr=[NSArray arrayWithObjects:@"setting_message_icon.png",@"visitor_icon.png", @"favorite_icon.png",@"liked_you_icon.png",nil];
    //---------
	// Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)224/255 green:(CGFloat)64/255 blue:(CGFloat)5/255 alpha:1];
    
    self.screen_height = [UIScreen mainScreen].bounds.size.height;
    
    //Add View SubView;
    if (self.mainsubView) {
        self.mainsubView=nil;
    }
    self.mainsubView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.view addSubview:self.mainsubView];
    
    
    //Add Header View
    CGFloat hh;
   
    CGRect frame_b,frame_button;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        self.mainsubView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"profile_screen_bg_ipad.png"]];
        hh = 92;
      
        frame_button=CGRectMake(self.view.frame.size.width-120, 20, 100, 30);
        frame_b = CGRectMake(25, 20, 50, 30);
    }
    else{
        self.mainsubView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"profile_screen_bg_568.png"]];
        
        hh = 55;
       frame_button= CGRectMake(self.view.frame.size.width-70, 20, 60, 25);
        frame_b = CGRectMake(10, 20, 30, 25);
    }
    
    //=======================================
    // Add Container View
  CGRect  frame = CGRectMake(0,0, self.view.frame.size.width, self.screen_height-hh);
    self.contentContainerView = [[UIView alloc] initWithFrame:frame];
    self.contentContainerView.backgroundColor = [UIColor grayColor];
    self.contentContainerView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    //[self.mainsubView addSubview:self.contentContainerView];
    //[self.mainsubView insertSubview:self.contentContainerView atIndex:0];
    frame = CGRectMake(0, 0, self.view.frame.size.width, hh);
    
    self.headerView = [[UIView alloc] initWithFrame:frame];
    
    self.headerView.backgroundColor = [UIColor colorWithRed:(CGFloat)224/255 green:(CGFloat)64/255 blue:(CGFloat)5/255 alpha:1];
    
    [self.mainsubView addSubview:self.headerView];
    

    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.headerView.bounds;
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.headerView.layer insertSublayer:layer atIndex:0];
    
    self.headerView.layer.shadowRadius = 5.0;
    self.headerView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.headerView.layer.shadowOpacity = 0.6;
    self.headerView.layer.shadowOffset = CGSizeMake(0.0f,5.0f);
    self.headerView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.headerView.bounds].CGPath;
     NSLog(@"Width menu== %f",self.view.frame.size.width);
    //frame = CGRectMake(0, hh, self.view.frame.size.width, self.screen_height-hh);
    
    self.headerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, self.view.frame.size.width-120, 25)];
    self.headerTitleLabel.backgroundColor = [UIColor clearColor];
    self.headerTitleLabel.textColor = [UIColor whiteColor];
    self.headerTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.headerTitleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.headerView addSubview:self.headerTitleLabel];
   
    //============================
    //Add Menu Button
    
    self.menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.menuButton.frame = frame_b;
    self.menuButton.titleLabel.font = [UIFont systemFontOfSize:9.0f];
    self.menuButton.titleLabel.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    //self.menuButton.titleLabel.layer.
    [self.menuButton addTarget:self action:@selector(menuButtonClciked:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuButton setBackgroundImage:[UIImage imageNamed:@"menu_icon.png"] forState:UIControlStateNormal];
    [self.menuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   
    [self.headerView addSubview:self.menuButton];
    
    self.setting=[[UIButton alloc]init];
    self.setting.frame=frame_button;
    [ self.setting setTitle:@"Setting" forState:UIControlStateNormal];
    [ self.setting setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.setting.layer.borderColor=[[UIColor redColor]CGColor];
    self.setting.layer.borderWidth=0.7;
    self.setting.layer.cornerRadius=4;
    self.setting.clipsToBounds=YES;
    [ self.setting addTarget:self action:@selector(settingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview: self.setting];
    
    self.filter1=[[UIButton alloc]init];
    self.filter1.frame=frame_button;
    [ self.filter1 setTitle:@"Filter" forState:UIControlStateNormal];
    [ self.filter1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.filter1.layer.borderColor=[[UIColor redColor]CGColor];
    self.filter1.layer.borderWidth=0.7;
    self.filter1.layer.cornerRadius=4;
    self.filter1.clipsToBounds=YES;
    [ self.filter1 addTarget:self action:@selector(FilterEncounterAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview: self.filter1];
    
    self.filter2=[[UIButton alloc]init];
    self.filter2.frame=frame_button;
    [ self.filter2 setTitle:@"Filter" forState:UIControlStateNormal];
    [ self.filter2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.filter2.layer.borderColor=[[UIColor redColor]CGColor];
    self.filter2.layer.borderWidth=0.7;
    self.filter2.layer.cornerRadius=4;
    self.filter2.clipsToBounds=YES;
    [ self.filter2 addTarget:self action:@selector(PeopleNearEncounterAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview: self.filter2];
    
    
    self.edit=[[UIButton alloc]init];
    self.edit.frame=frame_button;
    [ self.edit setTitle:@"Edit" forState:UIControlStateNormal];
    [ self.edit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.edit.layer.borderColor=[[UIColor redColor]CGColor];
    self.edit.layer.borderWidth=0.7;
    self.edit.layer.cornerRadius=4;
    self.edit.clipsToBounds=YES;
    [ self.edit addTarget:self action:@selector(editButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview: self.edit];
    
    self.cancel=[[UIButton alloc]init];
    self.cancel.frame=CGRectMake(25, 25, 70, 25);
    [ self.cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [ self.cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancel.layer.borderColor=[[UIColor redColor]CGColor];
    self.cancel.layer.borderWidth=0.7;
    self.cancel.layer.cornerRadius=4;
    self.cancel.clipsToBounds=YES;
    [ self.cancel addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview: self.cancel];
    self.cancel.hidden=YES;
    
    self.select=[[UIButton alloc]init];
    self.select.frame=frame_button;
    [ self.select setTitle:@"Select All" forState:UIControlStateNormal];
    [ self.select setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.select.layer.borderColor=[[UIColor redColor]CGColor];
    self.select.layer.borderWidth=0.7;
    self.select.layer.cornerRadius=4;
    self.select.clipsToBounds=YES;
    [ self.select addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview: self.select];
    self.select.hidden=YES;
    
    self.deselect=[[UIButton alloc]init];
    self.deselect.frame=frame_button;
    [ self.deselect setTitle:@"Deselect All" forState:UIControlStateNormal];
    [ self.deselect setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.deselect.layer.borderColor=[[UIColor redColor]CGColor];
    self.deselect.layer.borderWidth=0.7;
    self.deselect.layer.cornerRadius=4;
    self.deselect.clipsToBounds=YES;
    [ self.deselect addTarget:self action:@selector(deselectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview: self.deselect];
    self.deselect.hidden=YES;
    
    
   // self.menuButton.layer.cornerRadius = 5.0f;
    //self.menuButton.clipsToBounds = YES;
    //===================================
    
    self.selectedIndex = 2;
    self.selectedViewController = [self.viewControllers objectAtIndex:0];
    [self updateViewContainer];
    [self createMenuTableView];
    
    
    self.swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    self.swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.mainsubView addGestureRecognizer:self.swipeGesture];
    
    
    //self.customMenuViewController = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) handleSwipeGesture:(UISwipeGestureRecognizer *)swipeGesture{
    
    
    if (self.mainsubView.frame.origin.x>100) {
        
        [UIView animateWithDuration:.5 animations:^{
            self.mainsubView.frame = CGRectMake(0, 0,self.view.frame.size.width, self.screen_height);
        }completion:^(BOOL finish){
            
            
            self.swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
        }];
        
    }
    else{
        [UIView animateWithDuration:.5 animations:^{
            self.mainsubView.frame = CGRectMake(250, 0, self.view.frame.size.width, self.screen_height);
        }completion:^(BOOL finish){
            self.swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
        }];
    }
    
    
}
-(void) createMenuTableView{
    if (!self.menuTableView) {
        self.selectedIndex = 2;
        self.menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2+90, self.screen_height) style:UITableViewStylePlain];
        //self.menuTableView.backgroundColor =  [UIColor colorWithRed:(CGFloat)112/255 green:(CGFloat)147/255 blue:(CGFloat)148/255 alpha:1];
        
        self.menuTableView.backgroundColor =  [UIColor colorWithRed:(CGFloat)39/255 green:(CGFloat)39/255 blue:(CGFloat)41/255 alpha:1];
        
        self.menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.menuTableView setScrollEnabled:NO];
        self.menuTableView.delegate = self;
        self.menuTableView.dataSource = self;
        
    }
    else{
        [self.menuTableView reloadData];
    }
    
    [self.view insertSubview:self.menuTableView belowSubview:self.mainsubView];
    //[self.view addSubview:self.menuTableView];
    
    /*
    //Display Menu table With Animation
    [UIView animateWithDuration:.5 animations:^{
        
        self.menuTableView.frame = CGRectMake(0, 0, self.view.frame.size.width/2, self.contentContainerView.frame.size.height);
        
    }];*/
}

#pragma mark -
-(void) menuButtonClciked:(id)sender{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadCollectionView" object:nil];

    if (self.mainsubView.frame.origin.x>100 ) {
        
        [UIView animateWithDuration:.5 animations:^{
            self.mainsubView.frame = CGRectMake(0, 0,self.view.frame.size.width, self.screen_height);
        }completion:^(BOOL finish){
            self.swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
            
        }];
        
    }
    else{
        [UIView animateWithDuration:.5 animations:^{
            self.mainsubView.frame = CGRectMake(250, 0, self.view.frame.size.width, self.screen_height);
        }completion:^(BOOL finish){
            
            self.swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
            
        }];
    }
   
    
}

#pragma mark -
#pragma mark TableView Delegate and DataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
   
    return  self.numberOfSections;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        
        return self.viewControllers.count+1;
    }
    else if (section == 1){
        return self.secondSectionViewControllers.count;
    }
    return 0;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 30;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section==0) {
        return nil;
    }
    else if (section==1){
        if (!self.secondHeaderLabel) {
            self.secondHeaderLabel
            = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 25)];
            self.secondHeaderLabel.backgroundColor = [UIColor colorWithRed:(CGFloat)0.1 green:(CGFloat)0.1 blue:(CGFloat)0.1 alpha:.5];
            self.secondHeaderLabel.textColor = [UIColor whiteColor];
            self.secondHeaderLabel.text = @" YOUR CONNECTIONS";
        }
        return self.secondHeaderLabel;
    }
    return nil;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UIColor *firstColor =  [UIColor colorWithRed:(CGFloat)39/255 green:(CGFloat)39/255 blue:(CGFloat)41/255 alpha:1];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)48/255 green:(CGFloat)48/255 blue:(CGFloat)50/255 alpha:1];
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = cell.contentView.frame;
    layer.colors = [NSArray arrayWithObjects:(id)firstColor.CGColor,(id)secColor.CGColor, nil];
    
    [cell.contentView.layer insertSublayer:layer atIndex:0];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0f];
  
      // CGRect frame = CGRectMake(cell.frame.origin.x, cell.frame.size.height-2, cell.frame.size.width, 2);
//    UIImageView *dividerImageView = [[UIImageView alloc] initWithFrame:frame];
//    dividerImageView.image = [UIImage imageNamed:@"vesyl_border_setting.png"];
//    [cell.contentView addSubview:dividerImageView];
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell Identifier";
    
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UITableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //Check Section
        if (indexPath.section==0) {
        if (indexPath.row<self.viewControllers.count) {
            
            if (indexPath.row==0) {
                cell.textLabel.text = [NSString stringWithFormat:@"  %@",[(UIViewController *)[self.viewControllers objectAtIndex:2] title]];
            }
            else if (indexPath.row==2) {
                 cell.textLabel.text = [NSString stringWithFormat:@"  %@",[(UIViewController *)[self.viewControllers objectAtIndex:0] title]];
            }
            else
            {
    
            cell.textLabel.text = [NSString stringWithFormat:@"  %@",[(UIViewController *)[self.viewControllers objectAtIndex:indexPath.row] title]];
            }
            //if (indexPath.row==0) {
              //  cell.imageView.image=[UIImage imageNamed:@"profile_male.png"];
           // }
           // else{
                cell.imageView.image=[UIImage imageNamed:[menuImgArr objectAtIndex:indexPath.row]];
            //}
        }
        else
        {
            cell.textLabel.text = @"  Invite";
            cell.imageView.image=[UIImage imageNamed:@"invite.png"];
        }
    }
    else{
        
        
        if (indexPath.row<self.secondSectionViewControllers.count) {
            cell.textLabel.text = [NSString stringWithFormat:@"  %@",[(UIViewController *)[self.secondSectionViewControllers objectAtIndex:indexPath.row] title]];
            cell.imageView.image=[UIImage imageNamed:[sectionArr objectAtIndex:indexPath.row]];
           
        }

    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Add your Colour.
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    UIColor *a = [UIColor colorWithRed:(CGFloat)237/255 green:(CGFloat)237/255 blue:(CGFloat)237/255 alpha:1];
    [self setCellColor:a ForCell:cell];  //highlight colour
}
- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell {
    
    if (color == [UIColor clearColor]) {
        cell.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)251/255 blue:(CGFloat)251/255 alpha:1];
    }
    else{
        cell.backgroundColor = color;
    }
    
    cell.backgroundColor = color;
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Reset Colour.
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    UIColor *a = [UIColor clearColor];
    [self setCellColor:a ForCell:cell]; //normal color
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (indexPath.section==0) {
        
        //Dismiss Menu TableView with Animation
        [UIView animateWithDuration:.5 animations:^{
            
            self.mainsubView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.screen_height);
            
        }completion:^(BOOL finished){
            //After completion
            //first check if new selected view controller is equals to previously selected view controller
            //self.isSignIn=YES;
            if (indexPath.row==self.viewControllers.count) {
                NSLog(@"Invite click");
                return;
            }
            NSLog(@"%ld",(long)self.selectedIndex);
            if (self.selectedIndex==indexPath.row  && self.selectedSection == indexPath.section) {
                return;
            }
            UIViewController *newViewController;
            if (indexPath.row==0) {
                newViewController= [self.viewControllers objectAtIndex:2];
                _selectedSection = indexPath.section;
                _selectedIndex = indexPath.row;
                if ([SingletonClass shareSingleton].facebookLog==YES) {
                    NSString * picUrl=[[NSUserDefaults standardUserDefaults]objectForKey:@"profilePicUrl"];
                    [[SingletonClass shareSingleton].userImages addObject:picUrl];
                    NSLog(@"Profile pic url %@",[SingletonClass shareSingleton].userImages);
                }
                else{
                    if ([SingletonClass shareSingleton].userImages.count<=0) {
                        // [NSThread detachNewThreadSelector:@selector(getProfileImages) toTarget:self withObject:nil];
                        [self getProfileImages]; //---------- Error in service
                    }
                    
                }
                
                
            }
            else if (indexPath.row==2)
            {
                newViewController= [self.viewControllers objectAtIndex:0];
                _selectedSection = indexPath.section;
                _selectedIndex = indexPath.row;
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"callWebServiceForEncounter" object:nil userInfo:nil];
                });
            }
            else{
                
                newViewController= [self.viewControllers objectAtIndex:indexPath.row];
                _selectedSection = indexPath.section;
                _selectedIndex = indexPath.row;
            }
            if (indexPath.row==1) {

            [[ NSNotificationCenter defaultCenter]postNotificationName:@"peopleNearby" object:nil];
            }
            
           
            [self getSelectedViewControllers:newViewController];
           
        }];
     
    }//Index Path 1 End
    else if (indexPath.section == 1){
        
        [UIView animateWithDuration:0.3 animations:^{
            self.mainsubView.frame = CGRectMake(320, 0, self.view.frame.size.width, self.screen_height);
        }completion:^(BOOL finished){
            
            UIViewController *newViewController = [self.secondSectionViewControllers objectAtIndex:indexPath.row];
            _selectedSection = indexPath.section;
            _selectedIndex = indexPath.row;
            
            //=====Call service for visitors
            if (indexPath.row==1) {
                // servce for profile visitors
                [[NSNotificationCenter defaultCenter]postNotificationName:@"visitorsUI" object:nil userInfo:nil];
//               
//                [NSThread detachNewThreadSelector:@selector(callWebService:) toTarget:self withObject:urlStr];
                //  [self callWebService:urlStr];
            };
            
            if (indexPath.row==3) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"likedYou" object:nil userInfo:nil];
            }
            
            if (indexPath.row==2) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"FavouriteUI" object:nil userInfo:nil];
            }
            // [self getSelectedViewControllers:newViewController];
           
            [UIView animateWithDuration:.5 animations:^{
                self.mainsubView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.screen_height);
            }completion:^(BOOL finished){
                [self performSelector:@selector(getSelectedViewControllers:) withObject:newViewController afterDelay:0];
                
            }];
            
        }];
        
    }
    
}
-(void) getSelectedViewControllers:(UIViewController *)newViewController{
    // selected new view controller
    UIViewController *oldViewController = _selectedViewController;
    
    
    if (newViewController != nil) {
        [oldViewController.view removeFromSuperview];
        _selectedViewController = newViewController;
        //Update Container View with selected view controller view
        [self updateViewContainer];
        //Check Delegate assign or not
        
        
    }
}
-(void) updateViewContainer{
    self.selectedViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    //NSLog(@"View Height  = %f",self.contentContainerView.frame.size.height);
   // self.selectedViewController.view.frame = self.contentContainerView.bounds;
    NSLog(@"Selected view frame = %f",self.selectedViewController.view.frame.size.width);
    //NSLog(@"Selected View Height = %f",self.selectedViewController.view.frame.size.height);
    self.headerTitleLabel.text = self.selectedViewController.title;
    if ([self.headerTitleLabel.text isEqualToString:@"Profile"]) {
        self.setting.hidden=NO;
        self.filter1.hidden=YES;
        self.filter2.hidden=YES;
        self.edit.hidden=YES;
    }
    if ([self.headerTitleLabel.text isEqualToString:@"Rendezvous"]) {
        self.setting.hidden=YES;
        self.filter1.hidden=NO;
        self.filter2.hidden=YES;
        self.edit.hidden=YES;
    }
    if ([self.headerTitleLabel.text isEqualToString:@"People Nearby"]) {
        self.setting.hidden=YES;
        self.filter1.hidden=YES;
        self.filter2.hidden=NO;
        self.edit.hidden=YES;
    }
    if ([self.headerTitleLabel.text isEqualToString:@"Messages"]) {
        self.setting.hidden=YES;
        self.filter1.hidden=YES;
        self.filter2.hidden=YES;
        self.edit.hidden=NO;
        editMessage=YES;
        selectMessage=YES;
    }
    if ([self.headerTitleLabel.text isEqualToString:@"Visitors"]) {
        self.setting.hidden=YES;
        self.filter1.hidden=YES;
        self.filter2.hidden=YES;
        self.edit.hidden=NO;
        editVisitors=YES;
        selectVisitors=YES;
    }
    if ([self.headerTitleLabel.text isEqualToString:@"Favorite"]) {
        self.setting.hidden=YES;
        self.filter1.hidden=YES;
        self.filter2.hidden=YES;
        self.edit.hidden=NO;
        editFavorite=YES;
        selectFavorite=YES;
        
    }
    if ([self.headerTitleLabel.text isEqualToString:@"Liked you"]) {
        self.setting.hidden=YES;
        self.filter1.hidden=YES;
        self.filter2.hidden=YES;
        self.edit.hidden=NO;
        editFavorite=YES;
        selectFavorite=YES;
        
    }

    [self.mainsubView addSubview:self.selectedViewController.view];
      //  [self.contentContainerView addSubview:self.selectedViewController.view];
}

-(void)editButtonAction:(id)sender{
   /* if (!self.editMessageVC) {
        self.editMessageVC=[[EditMessagesViewController alloc]initWithNibName:@"EditMessagesViewController" bundle:nil];
    }
    [self.navigationController pushViewController:self.editMessageVC animated:YES];*/
    self.cancel.hidden=NO;
    self.setting.hidden=YES;
    self.filter1.hidden=YES;
    self.filter2.hidden=YES;
    self.edit.hidden=YES;
    self.select.hidden=NO;
    self.deselect.hidden=YES;
    self.menuButton.hidden=YES;
    if (editMessage) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"editButtonAction" object:nil];
    }
    if (editVisitors) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"editVisitorsButtonAction" object:nil];
    }
    if (editFavorite) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"editFavoriteButtonAction" object:nil];
    }
    if (editLike) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"editLikeButtonAction" object:nil];
    }
}


-(void)cancelButtonAction:(id)sender{
    self.edit.hidden=NO;
    self.cancel.hidden=YES;
    self.setting.hidden=YES;
    self.filter1.hidden=YES;
    self.filter2.hidden=YES;
    self.select.hidden=YES;
     self.deselect.hidden=YES;
    self.menuButton.hidden=NO;
    
    if (editMessage) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelButtonAction" object:nil];
    }
    if (editVisitors) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelVisitorsButtonAction" object:nil];
    }
    if (editFavorite) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelFavoriteButtonAction" object:nil];
    }
    if (editLike) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"cancelLikeButtonAction" object:nil];
    }
}

-(void)selectButtonAction:(id)sender{
     self.deselect.hidden=NO;
    self.select.hidden=YES;
    if (editMessage) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectButtonAction" object:nil];
    }
    if (editVisitors) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectVisitorsButtonAction" object:nil];
    }
    if (editFavorite) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectFavoriteButtonAction" object:nil];
    }
    if (editLike) {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"selectLikeButtonAction" object:nil];
    }
   
}
-(void)deselectButtonAction:(id)sender{
    self.deselect.hidden=YES;
    self.select.hidden=NO;
    if (editMessage) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deselectButtonAction" object:nil];
    }
    if (editVisitors) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deselectVisitorsButtonAction" object:nil];
    }
    if (editFavorite) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deselectFavoriteButtonAction" object:nil];
    }
    if(editLike){
         [[NSNotificationCenter defaultCenter] postNotificationName:@"deselectLikeButtonAction" object:nil];
    }
}

-(void)settingButtonAction:(id)sender{
    //self.navigationController.title=@"Settings";
    if(self.settingVC)
    {
        self.settingVC=nil;
        
        // self.nav=[[UINavigationController alloc]initWithRootViewController:self.settingVC];
        //        [self.nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"Cellheader.png"] forBarMetrics:UIBarMetricsDefault];
    }
    self.settingVC=[[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil];
//    appdelegate=[UIApplication sharedApplication].delegate;
//    [appdelegate.window addSubview:self.settingVC.view];
   [self.navigationController pushViewController:self.settingVC animated:YES];
    
    //[self presentViewController:self.nav  animated:YES completion:nil];
}

#pragma  mark- getProfileImages
-(void)getProfileImages{
    NSError * error;
     NSURLResponse *urlResponse=nil;
    NSString * urlstr=[NSString stringWithFormat:@"http://taka.dating/user-images/userid/%@",[SingletonClass shareSingleton].userID];
    urlstr=[urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url=[NSURL URLWithString:urlstr];
    
    NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (!data) {
        NSLog(@"No data available.");
    }
    else{
        id  parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
      //  NSLog(@"Parse %@",parse);
        
        if ([[parse objectForKey:@"code"]isEqualToNumber:[NSNumber numberWithInt:200]]) {
            imagesArr=[parse objectForKey:@"data"];
            NSMutableDictionary * dict=[[NSMutableDictionary  alloc]init];
            NSMutableArray * dictarr=[[NSMutableArray alloc]init];
            NSMutableArray * arr=[[NSMutableArray alloc]init];
            NSLog(@"image arr %@",imagesArr);
            for (int i=0; i<imagesArr.count; i++) {
                dict =[imagesArr objectAtIndex:i];
                if ([[dict objectForKey:@"privacy"]isEqualToString:@"3"]){
                    NSString * imageName=[NSString stringWithString:[dict objectForKey:@"imageLink"]];
                    [arr addObject:imageName];

                }
            else{
                [dictarr addObject:[dict objectForKey:@"imageLink"]];
                NSString * imageName=[NSString stringWithFormat:@"http://taka.dating/%@",[dict objectForKey:@"imageLink"]];
                NSLog(@"image Name %@",imageName);
                [arr addObject:imageName];
            }
               
            }
        [SingletonClass shareSingleton].userImages =[[NSMutableArray alloc]initWithArray:arr];
            NSLog(@"user profile images %@",[SingletonClass shareSingleton].userImages);
          [SingletonClass shareSingleton].profileImages=(NSArray*)imagesArr;
    }
    }
}


/*
-(void) goToBroadCastView{
    
    BroadCastViewController *broadCast = [[BroadCastViewController alloc] initWithNibName:@"BroadCastViewController" bundle:nil];
    [self presentViewController:broadCast animated:YES completion:nil];
}

#pragma mark -
#pragma mark Signin View
-(void)displaySignInViewController:(NSInteger)value{
    
    SignInViewController *signIn;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        signIn = [[SignInViewController alloc] initWithNibName:@"SignInViewController_iPad" bundle:nil];
    }
    else{
        signIn = [[SignInViewController alloc] initWithNibName:@"SignInViewController" bundle:nil];
    }
    signIn.value = value;
    [self.navigationController pushViewController:signIn animated:YES];
    //[self presentViewController:signIn animated:YES completion:nil];
}
*/



#pragma mark- filter encounter method

-(void)FilterEncounterAction:(id)sender{
    if (!self.encounterFiletrVC) {
        self.encounterFiletrVC=[[EncounterFilterViewController alloc]initWithNibName:@"EncounterFilterViewController" bundle:nil];
    }
    [self.navigationController pushViewController:self.encounterFiletrVC animated:YES];
}

-(void)PeopleNearEncounterAction:(id)sender
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadCollectionView" object:nil];
    if (!pnbVC) {
        pnbVC=[[ProfileNearFilterViewController alloc]initWithNibName:@"ProfileNearFilterViewController" bundle:nil];
    }
    [self.navigationController pushViewController:pnbVC animated:YES];
}
@end


static void * const kMyPropertyAssociatedStorageKey = (void*)&kMyPropertyAssociatedStorageKey;



@implementation UIViewController (CustomMenuViewControllerItem)
@dynamic customMenuViewController;

static char const * const orderedElementKey;

-(void) setCustomMenuViewController:(CustomMenuViewController *)customMenuViewController{
    
    NSLog(@"cc==%@",customMenuViewController.viewControllers);
    
    objc_setAssociatedObject(self, &orderedElementKey, customMenuViewController,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//        objc_setAssociatedObject(self, @selector(customMenuViewController), customMenuViewController,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(CustomMenuViewController *) customMenuViewController{
    
    if (objc_getAssociatedObject(self, &orderedElementKey) != nil)
    {
        NSLog(@"Element: %@", objc_getAssociatedObject(self, orderedElementKey));
    }
    
     NSLog(@"Element: %@", objc_getAssociatedObject(self, &orderedElementKey));
//    return objc_getAssociatedObject(self, @selector(customMenuViewController));
     return objc_getAssociatedObject(self, orderedElementKey);
    //return  self.customMenuViewController;
}


/*
-(CustomMenuViewController *) customViewController{
    //return objc_getAssociatedObject(self, kMyPropertyAssociatedStorageKey);
    return objc_getAssociatedObject(self, @selector(customMenuViewController));
}
-(CustomMenuViewController *)firstAvailableViewController{
    return (CustomMenuViewController*)[self traverseResponderChainforUIViewController];
}

-(id) traverseResponderChainforUIViewController{
    
    id nextResponse = [self nextResponder];
    
     if ([nextResponse isKindOfClass:[CustomMenuViewController class]]){
        return nextResponse;
    }
    else if ([nextResponse isKindOfClass:[UIViewController class]]) {
        return nextResponse;
    }
    else{
        [self traverseResponderChainforUIViewController];
    }
    return  nil;
}
*/

@end
