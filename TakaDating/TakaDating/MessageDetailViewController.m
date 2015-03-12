//
//  MessageDetailViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 30/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "ProfileViewController.h"
#import "UserProfileViewController.h"
#import "AppDelegate.h"
#import "PTSMessagingCell.h"

@interface MessageDetailViewController ()
@property(nonatomic,strong)UserProfileViewController * profileVC;

@end

@implementation MessageDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (XMPPStream *)xmppStream {
    return [[self appDelegate] xmppStream];
}

- (id) initWithUser:(NSString *) userName {
    
    if (self = [super init]) {
        
        chatWithUser = userName; // @ missing
        turnSockets = [[NSMutableArray alloc] init];
    }
    
    return self;
    
}
-(void)showSecievedMsg{
    [tView reloadData];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad
{
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showSecievedMsg) name:@"recievedMsg" object:nil];
    [super viewDidLoad];
    NSString * name=[NSString stringWithFormat:@"%@",chatWithUser];
    XMPPJID *jid = [XMPPJID jidWithString:name];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)turnSocket:(TURNSocket *)sender didSucceed:(GCDAsyncSocket *)socket {
    
    NSLog(@"TURN Connection succeeded!");
    NSLog(@"You now have a socket that you can use to send/receive data to/from the other person.");
    
    [turnSockets removeObject:sender];
}

- (void)turnSocketDidFail:(TURNSocket *)sender {
    
    NSLog(@"TURN Connection failed!");
    [turnSockets removeObject:sender];
    
}


-(void)createUI{
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, self.view.frame.size.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, self.view.frame.size.width-200, 35)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = self.titleStr;
    [self.view addSubview:self.titleLabel];
    //Add Cancel BUTTON
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake(15, 25, 60, 25);
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelButton.layer.borderColor = [UIColor redColor].CGColor;
    self.cancelButton.layer.borderWidth = 0.7;
    self.cancelButton.layer.cornerRadius = 4;
    self.cancelButton.clipsToBounds = YES;
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
    
    self.profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.profileButton.frame = CGRectMake(250, 25, 60, 25);
    [self.profileButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.profileButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.profileButton setTitle:@"Profile" forState:UIControlStateNormal];
    self.profileButton.layer.borderColor = [UIColor redColor].CGColor;
    self.profileButton.layer.borderWidth = 0.7;
    self.profileButton.layer.cornerRadius = 4;
    self.profileButton.clipsToBounds = YES;
    [self.profileButton addTarget:self action:@selector(profileButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.profileButton];
    
    tView =[[UITableView alloc]init];
    CGSize windowSize=[UIScreen mainScreen].bounds.size;
    tView.frame=CGRectMake(0, 55,windowSize.width , windowSize.height-55);
    tView.delegate=self;
    [self.view addSubview:tView];


}


#pragma mark- send message
- (void)sendMessage {
    
    NSString *messageStr = messageField.text;
    
    if([messageStr length] > 0) {
        
        /* NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
         [body setStringValue:messageStr];
         
         NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
         [message addAttributeWithName:@"type" stringValue:@"chat"];
         [message addAttributeWithName:@"to" stringValue:chatWithUser];
         [message addChild:body];
         
         [self.xmppStream sendElement:message];*/
        
        
        
        
        
        XMPPMessage *msg = [XMPPMessage message];
        [msg addAttributeWithName:@"type" stringValue:@"chat"];
        [msg addAttributeWithName:@"to" stringValue:chatWithUser];
        NSXMLElement *body = [NSXMLElement elementWithName:@"body" stringValue:messageStr];
        [msg addChild:body];
        //[[self xmppStream] sendElement:msg];
        [[self appDelegate].xmppStream sendElement:msg];
        
        messageField.text = @"";
        
        
        NSMutableDictionary *m = [[NSMutableDictionary alloc] init];
        [m setObject:messageStr forKey:@"msg"];
        [m setObject:@"you" forKey:@"sender"];
        //  [m setObject:[NSString getCurrentTime] forKey:@"time"];
        
        [[SingletonClass shareSingleton].messages addObject:m];
        [tView reloadData];
        [messageField endEditing:YES];
        // [m release];
        
    }
    
    //    NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:messages.count-1
    //                                                   inSection:0];
    
    NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:[SingletonClass shareSingleton].messages.count-1                                                               inSection:0];
    
    [tView scrollToRowAtIndexPath:topIndexPath
                 atScrollPosition:UITableViewScrollPositionMiddle
                         animated:YES];
}



-(void)profileButtonAction:(id)sender{
    if(self.profileVC)
        
    {
        self.profileVC=nil;
    }
    self.profileVC=[[UserProfileViewController alloc]initWithNibName:@"UserProfileViewController" bundle:nil];
    [self.navigationController pushViewController:self.profileVC animated:YES];
   // [self presentViewController:self.profileVC animated:YES completion:nil];
}

-(void)cancelButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -Chat UI
#pragma mark Table Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"message count %d",[[SingletonClass shareSingleton].messages count]);
    return [[SingletonClass shareSingleton].messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*This method sets up the table-view.*/
    
    static NSString* cellIdentifier = @"messagingCell";
    
    PTSMessagingCell * cell = (PTSMessagingCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[PTSMessagingCell alloc] initMessagingCellWithReuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor=[UIColor clearColor];
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = nil;
    dict=[[SingletonClass shareSingleton].messages objectAtIndex:indexPath.row];
    NSLog(@"message %@",[SingletonClass shareSingleton].messages);
    CGSize messageSize = [PTSMessagingCell messageSize:[dict objectForKey:@"msg"]];
    NSLog(@"message height %f",messageSize.height);
    return messageSize.height + 2*[PTSMessagingCell textMarginVertical] + 20.0f;
}

-(void)configureCell:(id)cell atIndexPath:(NSIndexPath *)indexPath
{
    PTSMessagingCell* ccell = (PTSMessagingCell*)cell;
    //History messages
    NSDictionary *dict = nil;
    dict=[[SingletonClass shareSingleton].messages objectAtIndex:indexPath.row];
    //    if([self.historyMessages count]>indexPath.row)
    //    {
    //        NSLog(@"%lu",(unsigned long)[self.historyMessages count]);
    //    QBChatAbstractMessage * msg=[self.historyMessages objectAtIndex:indexPath.row];
    //    NSLog(@"Messages: %@ id %lu", msg.text,(unsigned long)msg.recipientID);
    //
    //    if([[SingletonClass sharedSingleton].quickBloxId intValue]==msg.senderID)
    //    {
    //        ccell.sent=YES;
    //        ccell.avatarImageView.image=[SingletonClass sharedSingleton].imageUser;
    //        ccell.ballonImageName=@"balloon_selected_left.png";
    //    }
    //    else
    //    {
    //        ccell.sent=NO;
    //        ccell.avatarImageView.image=self.opponenetImage;
    //        ccell.ballonImageName=@"balloon_read_right.png";
    //    }
    //        ccell.messageLabel.text = [_messages objectAtIndex:indexPath.row];
    //    }
    //    //Normal messages
    //    else
    //    {
    ccell.messageLabel.text =[dict objectForKey:@"msg"];
    if(![[dict objectForKey:@"sender"] isEqualToString:@"you"])
    {
        ccell.sent=YES;
    }
    else
    {
        ccell.sent=NO;
    }
    
    if(ccell.sent)
    {
        //ccell.avatarImageView.image=self.opponenetImage;
        ccell.ballonImageName=@"balloon_read_right.png";
        
    }
    else
    {
        //ccell.avatarImageView.image=[SingletonClass sharedSingleton].imageUser;
        ccell.ballonImageName=@"balloon_unread_left.png";
    }
    
    //}
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
