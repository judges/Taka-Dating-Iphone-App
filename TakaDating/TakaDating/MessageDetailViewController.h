//
//  MessageDetailViewController.h
//  TakaDating
//
//  Created by Sumit Ghosh on 30/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "ProfileViewController.h"
#import "XMPP.h"
#import "TURNSocket.h"
#import "XMPPFramework.h"
#import "XMPPReconnect.h"
#import "SingletonClass.h"

@interface MessageDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,TURNSocketDelegate,UITextFieldDelegate> {
    
    UITextField		*messageField;
    NSString		*chatWithUser;
    UITableView		*tView;
    NSMutableArray	*messages;
    NSMutableArray *turnSockets;
    UIButton * closeBtn,* saveBtn;
    CGSize    windowSize;
    // XMPPStream *xmppStream;
    XMPPReconnect * xmppReconnect;
    UIScrollView * scrollView;
   
}

//@property (nonatomic,retain) IBOutlet UITextField *messageField;
//@property (nonatomic,retain) NSString *chatWithUser;
//@property (nonatomic,retain) IBOutlet UITableView *tView;

- (id) initWithUser:(NSString *) userName;
- (void) sendMessage;
- (void) closeChat;
-(void)showSecievedMsg;


@property(nonatomic,strong)NSString * titleStr,* userId;
@property(nonatomic)UILabel * titleLabel;
@property(nonatomic)UIButton * cancelButton,*profileButton,*sendButton;
@end
