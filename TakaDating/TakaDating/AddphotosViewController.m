//
//  AddphotosViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 29/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "AddphotosViewController.h"
#import "SingletonClass.h"
#import "AppDelegate.h"
#import "FBPhotoPickerViewController.h"


@interface AddphotosViewController ()
@property(nonatomic,strong)FBPhotoPickerViewController * photopicker;
@end

@implementation AddphotosViewController

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
    count=0;
    [super viewDidLoad];
    
    windowSize=[UIScreen mainScreen].bounds.size;
    
    
    urlParts=[[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moveToFBPickerClass) name:@"fetchFbPhoto" object:nil];
    
    photoarr=[NSArray arrayWithObjects:@"fb_icon.png",@"instagram_icon.png",@"gallery_icon.png",@"camera_icon.png", nil];
    photoPathArr=[NSArray arrayWithObjects:@"Add from Facebook",@"Add from Instagram",@"Add from existing photo",@"Take a new photo", nil];
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, windowSize.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.titleLabel = [[UILabel alloc] init ];
    self.titleLabel.frame=CGRectMake(windowSize.width/2-60, 20, windowSize.width-200, 35);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"Add photo";
    [self.view addSubview:self.titleLabel];
    //Add Cancel BUTTON
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake(windowSize.width/2-145, 25, 60, 25);
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelButton.layer.borderColor = [UIColor redColor].CGColor;
    self.cancelButton.layer.borderWidth = 0.7;
    self.cancelButton.layer.cornerRadius = 4;
    self.cancelButton.clipsToBounds = YES;
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
    // Do any additional setup after loading the view from its nib.
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
         layer.frame = CGRectMake(0, 0, windowSize.width, 75);
        self.titleLabel.frame=CGRectMake(windowSize.width/2-270, 25, windowSize.width-200, 40);
        self.cancelButton.frame = CGRectMake(windowSize.width/2-350, 25, 120, 40);
        self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:20];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        height=75;
        font_size=20;
        row_hh=80;
    }
    else{
        row_hh=40;
        font_size=13;
        height=55;
    }
    
    [self createUI];
}

-(void)createUI{
    if(!self.addPhotoTable)
    {
        self.addPhotoTable=[[UITableView alloc]init];
        //if ([UIScreen mainScreen].bounds.size.height>500) {
            self.addPhotoTable.frame=CGRectMake(0, height, windowSize.width, windowSize.height-50);
       // }
       // else{
       // self.addPhotoTable.frame=CGRectMake(0, 55, self.view.frame.size.width, self.view.frame.size.height-50);
        //}
        self.addPhotoTable.delegate=self;
        self.addPhotoTable.dataSource=self;
        [self.addPhotoTable setShowsVerticalScrollIndicator:NO];
        self.addPhotoTable.scrollEnabled=NO;
        self.addPhotoTable.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
        self.addPhotoTable.separatorColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)165/255 blue:(CGFloat)165/255 alpha:1.0];

        [self.view addSubview:self.addPhotoTable];
        self.addPhotoTable.hidden=NO;
    }
}

#pragma mark- table delegate mathods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return photoarr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.imageView.frame=CGRectMake(5, 10, 10, 10);
    cell.textLabel.font=[UIFont boldSystemFontOfSize:font_size];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.textLabel.text=[photoPathArr objectAtIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed:[photoarr objectAtIndex:indexPath.row]];
    
    
    return  cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return row_hh-10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 250.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row==0) {
        [self fetchPhotoFromFacebook];
    }
    if (indexPath.row==1) {
        [self fetchPhotoFromInstagram];
    }
    if (indexPath.row==2) {
        [self addingPhotofromLibrary];
    }
    if (indexPath.row==3) {
        [self takePhotoFromCamera];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return row_hh;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UILabel * label=[[UILabel alloc]init];
    label.frame=CGRectMake(30, 10, 260, 50);
    label.textAlignment=NSTextAlignmentCenter;
    label.lineBreakMode=NSLineBreakByCharWrapping;
    label.font=[UIFont systemFontOfSize:font_size];
    label.numberOfLines=0;
    label.backgroundColor=[UIColor clearColor];
    label.text=@"'Photo of you' must have only in them, identify you easily and show your face clearly. Please respect our rules. Note that all photos are moderated.";
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        label.frame=CGRectMake(50, 10, 400, 50);
    }
    return  label;
}

#pragma mark-add photo

-(void)addingPhotofromLibrary{
    if(self.imagePicker)
    {
        self.imagePicker=nil;
    }
    self.imagePicker=[[UIImagePickerController alloc]init];
    self.imagePicker.delegate=self;
    self.imagePicker.allowsEditing=YES;
    self.imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

-(void)takePhotoFromCamera{
    if(UIImagePickerControllerSourceTypeCamera==NO)
    {
        return;
    }
    if(self.imagePicker)
    {
        self.imagePicker=nil;
    }
    self.imagePicker=[[UIImagePickerController alloc]init];
    self.imagePicker.delegate=self;
    self.imagePicker.allowsEditing=YES;
    self.imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
}


- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo
{
   img = image;
    [self dismissModalViewControllerAnimated:YES];
    [self uploadPhoto:image];
    
}

-(void)uploadPhoto:(UIImage *)image{
 
  
   // NSData * imageData=[NSData dataWithContentsOfURL:url];
    // NSLog(@"nsdata of image %@",imageData);
    NSMutableDictionary * dictParm=[[NSMutableDictionary alloc]init];
    [dictParm setValue:[SingletonClass shareSingleton].userID forKey:@"id"];

    //NSString * postUrl=@"http://taka.dating/mobile/uploadImage/";
    NSString * postUrl=@"http://23.238.24.26/mobi/upload-mobile";
    AFNHelper * afn=[[AFNHelper alloc]init];
   
    
    [afn getDataFromPath:postUrl withParamDataImage:dictParm andImage:image withBlock:^(id response, NSError *error) {
        if (error) {
            NSLog(@"Fail");
        }else{
        
            NSLog(@"Upload Successfull");
            NSLog(@"responsible %@",response);

        }
    }];
}


#pragma mark- Fecth photo from facebook
-(void)fetchPhotoFromFacebook{
    [SingletonClass shareSingleton].photosOfUser  = [[NSMutableArray alloc]init];
    NSString * accessToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    if (!accessToken) {
        AppDelegate * appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        [SingletonClass shareSingleton].fetchFBPhoto=YES;
        [appdelegate openSessionWithAllowLoginUI:1];
    }
    else{
            [self moveToFBPickerClass];
    }
}

-(void)moveToFBPickerClass{
    NSString * accessToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    NSDictionary *queryParam = @{@"access_token":accessToken};
    
    [FBRequestConnection startWithGraphPath:@"me/photos/uploaded" parameters:queryParam HTTPMethod:@"GET" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        NSArray * resultArr=(NSArray*)result[@"data"];
        // NSLog(@" facebook photos %@",result[@"data"]);
       
        
        NSArray * imagesArrCount=[[NSArray alloc]init];
        
        for (int i=0; i<resultArr.count; i++) {
            NSMutableDictionary * images=[resultArr objectAtIndex:i];
            //  NSLog(@"images21 %@",[images objectForKey:@"images"]);
            NSMutableArray * imagesArr=(NSMutableArray *)[images objectForKey:@"images"];
            
            for (int k=0; k<imagesArr.count; k++) {
                // NSLog(@"Sources %@ ",[[imagesArr objectAtIndex:k]objectForKey:@"source"]);
                [[SingletonClass shareSingleton].photosOfUser addObject:[[imagesArr objectAtIndex:k]objectForKey:@"source"]];
                
            }
            
            
        }
        if ([SingletonClass shareSingleton].fetchFBPhoto==YES) {
             [FBSession.activeSession closeAndClearTokenInformation];
            [SingletonClass shareSingleton].fetchFBPhoto=NO;

        }
       
        //[[SingletonClass shareSingleton].photosOfUser addObjectsFromArray:imagesArrCount];
        // NSLog(@" singleTon%@",[SingletonClass shareSingleton].photosOfUser);
        if ([SingletonClass shareSingleton].photosOfUser.count>0) {
            
            if (self.photopicker) {
                self.photopicker=nil;
            }
            self.photopicker=[[FBPhotoPickerViewController alloc]initWithNibName:@"FBPhotoPickerViewController" bundle:nil];
            [self.navigationController pushViewController:self.photopicker animated:YES];
        }
        else{
            UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"No photos are there." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
        
    }];
}
#pragma mark- instagram photo fetch

-(void)fetchPhotoFromInstagram{
    [SingletonClass shareSingleton].photosOfUser  = [[NSMutableArray alloc]init];
   /* NSURL * instagramUrl=[NSURL URLWithString:@"instagram://media?id=1"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramUrl]) {
        [[UIApplication sharedApplication] openURL:instagramUrl];
    }*/
    NSString * client_id = @"ae273bad2ab543b789f5be827a6a1e29";
    NSString * redirectUri=@"http://23.238.24.26/instagram-images/";
   // NSString * redirectUri=@"https://www.google.com/";
    NSString * url=[NSString stringWithFormat:@"https://instagram.com/oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=token",client_id,redirectUri];
    NSURL * instagramUrl=[NSURL URLWithString:url];
    NSURLRequest *req = [[NSURLRequest alloc]initWithURL:instagramUrl];
    webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, height, self.view.frame.size.width, self.view.frame.size.height-50)];
    webView.delegate=self;
    [webView loadRequest:req];
    [self.view addSubview:webView];
    
}
#pragma mark- delegate method of webView

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
     NSString * redirectUrl=@"http://taka.dating/instagram-images/";
    NSString * urlStr=[[request URL]absoluteString];
    NSLog(@"WebView URL %@",urlStr);
    NSArray *UrlParts =[NSArray arrayWithArray:[urlStr componentsSeparatedByString:[NSString stringWithFormat:@"%@/", redirectUrl]]];
    int i=0;
    [urlParts addObject:[urlStr componentsSeparatedByString:[NSString stringWithFormat:@"%@/", redirectUrl]]];
    if ([urlParts count]>1)
    {
        NSArray * urlArr1 = [urlParts objectAtIndex:i];
        NSString * checkString  =[urlArr1 objectAtIndex:i];
        
        i++;
   
    
    NSLog(@"urlParts Count %d",urlParts.count);
    if ([UrlParts count] >1||[urlStr rangeOfString:@"#access_token="].location!=NSNotFound)
    {
        // do any of the following here
      // NSArray * urlArr = [urlParts objectAtIndex:1];
        urlStr =[UrlParts objectAtIndex:0];
        NSRange accessToken = [urlStr rangeOfString: @"#access_token="];
        if (accessToken.location != NSNotFound) {
            NSString* strAccessToken = [urlStr substringFromIndex: NSMaxRange(accessToken)];
            // Save access token to user defaults for later use.
            [[NSUserDefaults standardUserDefaults] setValue:strAccessToken forKey:@"access_token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"AccessToken = %@ ",strAccessToken);
            [self loadRequestForMediaData];
        }
        return NO;
    }
    }
    
    return YES;
    
}



-(void)loadRequestForMediaData {
 //NSString * mediaURl=   @"https://api.instagram.com/v1/users/";
    NSString * accessToken=[[ NSUserDefaults standardUserDefaults]                                                                                                                                               valueForKey:@"access_token"];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.instagram.com/v1/users/self/media/recent/?access_token=%@",accessToken]]];
    // Here you can handle response as well
    NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"Response : %@",dictResponse);
  //  NSMutableArray * finalArrList=[[NSMutableArray alloc]init];
    NSArray * resultArr=(NSArray*)[dictResponse objectForKey:@"data"];
    NSLog(@"Result arr %@ ==--%d",resultArr,resultArr.count);
    for (int i=0; i<resultArr.count; i++) {
        NSMutableDictionary * dict=[resultArr objectAtIndex:i];
        NSMutableDictionary * imageDic=[dict objectForKey:@"images"];
        NSMutableDictionary * standardResolutionDic=[imageDic objectForKey:@"standard_resolution"];
        NSString * imageUrl=[standardResolutionDic objectForKey:@"url"];
        [[SingletonClass shareSingleton].photosOfUser addObject:imageUrl];
    }
    NSLog(@"Final array of images --===-- %@",[SingletonClass shareSingleton].photosOfUser);
    [webView removeFromSuperview];
    
    if ([SingletonClass shareSingleton].photosOfUser.count>0) {
        
        if (self.photopicker) {
            self.photopicker=nil;
        }
        self.photopicker=[[FBPhotoPickerViewController alloc]initWithNibName:@"FBPhotoPickerViewController" bundle:nil];
        [self.navigationController pushViewController:self.photopicker animated:YES];
    }
    else{
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"No photos are there." message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
}

#pragma  mark- cancel button

-(void)cancelButtonAction:(id)sender{
    //[[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
