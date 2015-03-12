//
//  MessagesViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 30/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "MessagesViewController.h"
#import  "MessageDetailViewController.h"

// Log levels: off, error, warn, info, verbose
#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_INFO;
#endif



@interface MessagesViewController ()
@property(nonatomic,strong)MessageDetailViewController * mdVC;

@end

@implementation MessagesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (XMPPRoster *)xmppRoster {
    return [[self appDelegate] xmppRoster];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    nameArr=[[NSMutableArray alloc]initWithObjects:@"One",@"Two",@"Three",@"Four",@"Five", nil];
    
    windowSize =[UIScreen mainScreen].bounds.size;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(editButtonAction) name:@"editButtonAction" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(cancelButtonAction) name:@"cancelButtonAction" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectButtonAction) name:@"selectButtonAction" object:nil];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deselectButtonAction) name:@"deselectButtonAction" object:nil];
   
    [self createUI];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark-editbutton action

-(void)editButtonAction{
    editbuttonSelect =YES;
    [self.messageTable reloadData];
}
-(void)cancelButtonAction{
    editbuttonSelect=NO;
    selectAll=NO;
    [self.messageTable reloadData];
}

-(void)selectButtonAction{
    NSLog(@"Select Button clicked");
    selectAll=YES;
    [self.messageTable reloadData];
   
}

-(void)deselectButtonAction{
    NSLog(@"Select Button clicked");
    selectAll=NO;
    [self.messageTable reloadData];
    
}


-(void)createUI{
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    UIView * sectionView=[[UIView alloc]init];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        sectionView.frame=CGRectMake(0, 0, windowSize.width, 150);
    }
    else{
            sectionView.frame=CGRectMake(0, 0, windowSize.width, 60);
    }
    
    sectionView.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    CGRect   frame,srchFrame;
    if (!self.messageTable) {
        self.messageTable=[[UITableView alloc]init];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
           
                self.messageTable.frame=CGRectMake(0, 10, windowSize.width, windowSize.height-50);
            frame=CGRectMake(10, 70, windowSize.width-20, 50);
            srchFrame=CGRectMake(10, 10, windowSize.width-20, 50);
            row_hh=80;
        }
        else{
        //if ([UIScreen mainScreen].bounds.size.height>500) {
            self.messageTable.frame=CGRectMake(0, 10, windowSize.width, windowSize.height-50);
            frame=CGRectMake(10, 35, windowSize.width-20, 20);
            srchFrame=CGRectMake(10, 10, windowSize.width-20, 20);
            row_hh=40;
      //  }
        }
//        else{
//             self.messageTable.frame=CGRectMake(0, 0, 320, self.view.frame.size.height-50);
//        }
        self.messageTable.delegate=self;;
        self.messageTable.dataSource=self;
            self.messageTable.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
        self.messageTable.separatorColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)165/255 blue:(CGFloat)165/255 alpha:1.0];
        
        [self.view addSubview:self.messageTable];
        
        self.searchbar =[[UISearchBar alloc]init];
        self.searchbar.frame=srchFrame;
        self.searchbar.layer.cornerRadius=7;
        self.searchbar.placeholder=@"Search";
        self.searchbar.clipsToBounds=YES;
        self.searchbar.delegate=self;
        
        self.searchbar.backgroundColor=[UIColor whiteColor];
        self.searchbar.searchBarStyle=UISearchBarStyleProminent;
        [sectionView addSubview:self.searchbar];
        
        
         NSArray *arry=[NSArray arrayWithObjects:@"All",@"Unread",@"Online", nil];
        
        self.segment=[[UISegmentedControl alloc]initWithItems:arry];
        
        self.segment.frame=frame;
        [self.segment addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
        self.segment.selectedSegmentIndex = 0;
        //[self.segment setTintColor:[UIColor colorWithRed:50.0/255.0 green:49.0/255.0 blue:49.0/255.0 alpha:1.0]];
       

        [sectionView addSubview:self.segment];
       for (UIControl *subview in self.segment.subviews) {
            subview.tintColor = [subview isSelected] ? [UIColor colorWithRed:135.0/255.0 green:10.0/255.0 blue:2.0/255.0 alpha:1.0] : [UIColor blackColor];
       }
        self.messageTable.tableHeaderView=sectionView ;
    }
}


#pragma mark-Segment method

-(void)MySegmentControlAction:(UISegmentedControl *)sender{
        for (UIControl *subview in sender.subviews) {
            subview.tintColor = [subview isSelected] ? [UIColor colorWithRed:135.0/255.0 green:10.0/255.0 blue:2.0/255.0 alpha:1.0] : [UIColor blackColor];
        }
    
 
    
    if (sender.selectedSegmentIndex==0) {
        online=NO;
        [self.messageTable reloadData];
        NSLog(@"index one selected");
    }
    else if (sender.selectedSegmentIndex==1)
    {
        NSLog(@"index Two selected");
    }
    else{
        online=YES;
        [self.messageTable reloadData];
        NSLog(@"index three selected");
    }
}

#pragma mark- table delegate methods

- (NSString *)tableView:(UITableView *)sender titleForHeaderInSection:(NSInteger)sectionIndex
{
    NSArray *sections = [[self fetchedResultsController] sections];
    
    if (sectionIndex < [sections count])
    {
        id <NSFetchedResultsSectionInfo> sectionInfo = sections[sectionIndex];
        
        int section = [sectionInfo.name intValue];
       /* switch (section)
        {
            case 0  : return @"Available";
            case 1  : return @"Away";
            default : return @"Offline";
        }*/
    }
    
    return @"";
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return row_hh;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[self fetchedResultsController] sections] count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *sections = [[self fetchedResultsController] sections];
    if (!online) {
        if (section < [sections count])
        {
            id <NSFetchedResultsSectionInfo> sectionInfo = sections[section];
            return sectionInfo.numberOfObjects;
        }
        
    }
    else{
        NSArray *sections = [[self fetchedResultsController] sections];
        
        if (section < [sections count])
        {
            id <NSFetchedResultsSectionInfo> sectionInfo = sections[section];
            
            int sec = [sectionInfo.name intValue];
            if (sec==0) {
                return sectionInfo.numberOfObjects;
            }
        }
        
    }
    
    return 0;
}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageTableViewCell * cell=(MessageTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[MessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell.deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (editbuttonSelect==YES) {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            cell.imgView.frame=CGRectMake(35, 10, 50, 50);
            cell.deleteButton.frame=CGRectMake(15, 10, 25, 25);
            cell.cellLabel.frame=CGRectMake(100, 15, 200, 30);
            cell.deleteButton.tag=indexPath.row;
        }
        else{
        cell.imgView.frame=CGRectMake(25, 5, 30, 30);
        cell.deleteButton.frame=CGRectMake(5, 10, 15, 15);
        cell.cellLabel.frame=CGRectMake(70, 10, 150, 30);
        cell.deleteButton.tag=indexPath.row;
        }
        if (selectAll==YES) {
            [cell.deleteButton setSelected:YES];
            [cell.deleteButton setImage:[UIImage imageNamed:@"select_active.png"] forState:UIControlStateSelected];
        }
        else{
            [cell.deleteButton setSelected:NO];
            [cell.deleteButton setImage:[UIImage imageNamed:@"select_normal.png"] forState:UIControlStateSelected];
        }
        
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            cell.cellLabel.frame=CGRectMake(70, 15, 200, 30);
            cell.imgView.frame=CGRectMake(10, 10, 50, 50);
        }
        else{
                cell.cellLabel.frame=CGRectMake(50, 10, 150, 30);
                cell.imgView.frame=CGRectMake(5, 5, 30, 30);
        }
    }
    
//    cell.imgView.image=[UIImage imageNamed:@"imag1.jpg"];
//    cell.cellLabel.text=[nameArr objectAtIndex:indexPath.row];
//    cell.imgView.tag=indexPath.row;
    XMPPUserCoreDataStorageObject *user = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    cell.textLabel.text = user.displayName;
    [self configurePhotoForCell:cell user:user];
    return  cell;
    
}

- (void)configurePhotoForCell:(UITableViewCell *)cell user:(XMPPUserCoreDataStorageObject *)user
{
    // Our xmppRosterStorage will cache photos as they arrive from the xmppvCardAvatarModule.
    // We only need to ask the avatar module for a photo, if the roster doesn't have it.
    
    if (user.photo != nil)
    {
        cell.imageView.image = user.photo;
    }
    else
    {
        NSData *photoData = [[[self appDelegate] xmppvCardAvatarModule] photoDataForJID:user.jid];
        
        if (photoData != nil)
            cell.imageView.image = [UIImage imageWithData:photoData];
        else
            cell.imageView.image = [UIImage imageNamed:@"defaultPerson"];
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editbuttonSelect==NO) {
        XMPPUserCoreDataStorageObject *user = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        
        
       
      if(self.mdVC)
      {
          self.mdVC=nil;
      }
          self.mdVC=[[MessageDetailViewController alloc]initWithNibName:@"MessageDetailViewController" bundle:nil];
    self.mdVC.titleStr= user.displayName;
    //self.mdVC.userId=
    [self.navigationController pushViewController:self.mdVC animated:YES];
    }

    else{
        NSLog(@"Delete is selected");
    }
}



-(void)deleteButtonAction:(id)sender{
    
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSFetchedResultsController
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController == nil)
    {
        NSManagedObjectContext *moc = [[self appDelegate] managedObjectContext_roster];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"XMPPUserCoreDataStorageObject"
                                                  inManagedObjectContext:moc];
        
        NSSortDescriptor *sd1 = [[NSSortDescriptor alloc] initWithKey:@"sectionNum" ascending:YES];
        NSSortDescriptor *sd2 = [[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:YES];
        
        NSArray *sortDescriptors = @[sd1, sd2];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setEntity:entity];
        [fetchRequest setSortDescriptors:sortDescriptors];
        [fetchRequest setFetchBatchSize:10];
        
        fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                       managedObjectContext:moc
                                                                         sectionNameKeyPath:@"sectionNum"
                                                                                  cacheName:nil];
        [fetchedResultsController setDelegate:self];
        
        
        NSError *error = nil;
        if (![fetchedResultsController performFetch:&error])
        {
            DDLogError(@"Error performing fetch: %@", error);
        }
        
    }
    
    return fetchedResultsController;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [ self.messageTable reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}

@end
