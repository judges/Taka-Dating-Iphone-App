//
//  RefillCreditsViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 05/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "RefillCreditsViewController.h"
#import "SingletonClass.h"

@interface RefillCreditsViewController ()

@end

@implementation RefillCreditsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    windowSize=[UIScreen mainScreen].bounds.size;
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    CAGradientLayer * layer=[CAGradientLayer layer];
    layer.frame=CGRectMake(0, 0, windowSize.width ,55);
    
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    
    self.titleLabel=[[UILabel alloc]init];
    self.titleLabel.frame=CGRectMake(windowSize.width/2-20, 25, 120, 25);
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    self.titleLabel.text=@"Credits";
    self.titleLabel.font=[UIFont boldSystemFontOfSize:20];
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
    
    
    self.payPalConfig = [[PayPalConfiguration alloc] init];
    self.payPalConfig.merchantName = @"Ultramagnetic Omega Supreme";
    self.payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.omega.supreme.example/privacy"];
   self.payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.omega.supreme.example/user_agreement"];
    
    dispatch_async(dispatch_get_global_queue(0, 0),^{
        continent=[self findContinent];
        dispatch_async(dispatch_get_main_queue(),^{
            [self createUI];
        });
    });
    
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark- instance method

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
   [PayPalMobile preconnectWithEnvironment:PayPalEnvironmentSandbox];
}

#pragma mark -
#pragma mark PayPal InstaceMethod
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.payPalConfig = [[PayPalConfiguration alloc] init];
        
        
        // See PayPalConfiguration.h for details and default values.
        // Should you wish to change any of the values, you can do so here.
        // For example, if you wish to accept PayPal but not payment card payments, then add:
        self.acceptCreditCards=YES;
        self.payPalConfig.acceptCreditCards = YES;
        // Or if you wish to have the user choose a Shipping Address from those already
        // associated with the user's PayPal account, then add:
        self.payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
        self.payPalConfig.merchantName = @"Ultramagnetic Omega Supreme";
       self.payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.omega.supreme.example/privacy"];
       self.payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.omega.supreme.example/user_agreement"];
        
        
    }
    return self;
}

- (instancetype)initWithConfiguration:(PayPalConfiguration *)configuration
                             delegate:(id<PayPalFuturePaymentDelegate>)delegate{
    self.payPalConfig = [[PayPalConfiguration alloc] init];
    
    self.payPalConfig.merchantName = @"Ultramagnetic Omega Supreme";
    self.payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.omega.supreme.example/privacy"];
   self.payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.omega.supreme.example/user_agreement"];
    
    
    return  self;
}


#pragma mark- find continent
-(NSString*)findContinent{
    NSError * error=nil;
    NSURLResponse * urlResponse=nil;
    
    NSString * urlStr=@"http://www.geoplugin.net/json.gp";
    
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        return nil;
    }
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"json for continent %@",json );
    if ([[json objectForKey:@"geoplugin_continentCode"]isEqualToString:@"AS"]) {
        return  [json objectForKey:@"geoplugin_continentCode"];
    }
    else if ([[json objectForKey:@"geoplugin_continentCode"]isEqualToString:@"AF"]) {
        return  [json objectForKey:@"geoplugin_continentCode"];
    }
    else if ([[json objectForKey:@"geoplugin_continentCode"]isEqualToString:@"AM"]) {
        return  [json objectForKey:@"geoplugin_continentCode"];
    }
    else if ([[json objectForKey:@"geoplugin_continentCode"]isEqualToString:@"EU"]) {
        return  [json objectForKey:@"geoplugin_continentCode"];
    }
    else if ([[json objectForKey:@"geoplugin_continentCode"]isEqualToString:@"AUS"]) {
        return  [json objectForKey:@"geoplugin_continentCode"];
    }
    else if ([[json objectForKey:@"geoplugin_continentCode"]isEqualToString:@"SAM"]) {
        return  [json objectForKey:@"geoplugin_continentCode"];
    }
    else{
        return @"";
    }
    
}
#pragma mark- create UI
-(void)createUI{
    UIScrollView * scroll=[[UIScrollView alloc]init];
    scroll.frame=CGRectMake(0, 55, windowSize.width, windowSize.height);
    scroll.backgroundColor=[UIColor clearColor];
    
    [self.view addSubview:scroll];
     scroll.contentSize=CGSizeMake(windowSize.width, windowSize.height+50);
    
    UILabel * instructionLbl=[[UILabel alloc]init];
    instructionLbl.frame=CGRectMake(windowSize.width/2-150, 50, windowSize.width-20, 30);
    instructionLbl.text=@"Select the package that suits you the best";
    instructionLbl.font=[UIFont boldSystemFontOfSize:15];
    instructionLbl.textColor=[UIColor blackColor];
    [scroll addSubview:instructionLbl];
    
    
    
   
    
    UIView * creditsView=[[UIView alloc]init];
    creditsView.frame=CGRectMake(3, 100, windowSize.width-6, 350);
    creditsView.backgroundColor=[UIColor whiteColor];
    creditsView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    creditsView.layer.borderWidth=0.5;
    creditsView.clipsToBounds=YES;
    creditsView.layer.cornerRadius=4;
    [scroll addSubview:creditsView];
    
  self.creditsLabel=[[UILabel alloc]init];
    self.creditsLabel.frame=CGRectMake(creditsView.frame.size.width/2-120, 10, creditsView.frame.size.width-40, 50);
    self.creditsLabel.font=[UIFont boldSystemFontOfSize:15];
    self.creditsLabel.numberOfLines=0;
    self.creditsLabel.lineBreakMode=NSLineBreakByCharWrapping;
    [creditsView addSubview:self.creditsLabel];
    NSString * credit=[[NSUserDefaults standardUserDefaults] objectForKey:@"credit"];
    NSString * balance;
    if (!credit) {
        balance=[NSString stringWithFormat:@"Your current balance is 0"];
    }
    else{
        balance=[NSString stringWithFormat:@"%@",credit];
    }
    
    self.creditsLabel.text=balance;
   NSString* image= @"setting_btn_bg.png";
    CGFloat fontSize=13;
    //Three months
   self.threeMonths=[UIButton buttonWithType:UIButtonTypeCustom];
    
    self.threeMonths.layer.cornerRadius=5;
    self.threeMonths.clipsToBounds=YES;
    [self.threeMonths setTitle:@"3 months at 450.00 INR/month" forState:UIControlStateNormal];
    [self.threeMonths setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.threeMonths setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:image]]];
    self.threeMonths.titleLabel.font=[UIFont systemFontOfSize:fontSize];
   
    
    [creditsView addSubview:self.threeMonths];
    
    UIButton * threeMonthBtn=[[UIButton alloc]init];
    
    [threeMonthBtn setTitle:@"Save 18%" forState:UIControlStateNormal];
    threeMonthBtn.layer.borderColor=[UIColor blackColor].CGColor;
    threeMonthBtn.layer.borderWidth=0.3;
    threeMonthBtn.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    [threeMonthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    threeMonthBtn.clipsToBounds=YES;
    threeMonthBtn.layer.cornerRadius=4;
    threeMonthBtn.backgroundColor=[UIColor lightGrayColor];
    [creditsView addSubview:threeMonthBtn];
    
    UILabel * threeMonthsLbl=[[UILabel alloc]init];
    
    threeMonthsLbl.font=[UIFont systemFontOfSize:fontSize];
    threeMonthsLbl.text=@"1,35.00 INR in total";
    [creditsView addSubview:threeMonthsLbl];
    
    //One month
   self.oneMonths=[UIButton buttonWithType:UIButtonTypeCustom];
    
    self.oneMonths.layer.cornerRadius=5;
    self.oneMonths.clipsToBounds=YES;
    [self.oneMonths setTitle:@"100 credits" forState:UIControlStateNormal];
    [self.oneMonths setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.oneMonths setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:image]]];
    self.oneMonths.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    [self.oneMonths addTarget:self action:@selector(callPayPalPaymentMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.oneMonths.tag=100;
    [creditsView addSubview:self.oneMonths];
    
    UILabel * oneMonthLbl=[[UILabel alloc]init];
    
    oneMonthLbl.font=[UIFont systemFontOfSize:fontSize];
    oneMonthLbl.text=@"550.00 INR in total";
    [creditsView addSubview:oneMonthLbl];
    
    
    //Six month
    
    self.sixMonths=[UIButton buttonWithType:UIButtonTypeCustom];
    
    self.sixMonths.layer.cornerRadius=5;
    self.sixMonths.clipsToBounds=YES;
    [self.sixMonths setTitle:@"600 credits" forState:UIControlStateNormal];
    [self.sixMonths setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sixMonths setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:image]]];
    self.sixMonths.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    [self.sixMonths addTarget:self action:@selector(callPayPalPaymentMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.sixMonths.tag=600;
    [creditsView addSubview:self.sixMonths];
    
    UIButton * sixMonthBtn=[[UIButton alloc]init];
    
    [sixMonthBtn setTitle:@"Save 38%" forState:UIControlStateNormal];
    sixMonthBtn.layer.borderColor=[UIColor blackColor].CGColor;
    sixMonthBtn.layer.borderWidth=0.3;
    sixMonthBtn.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    [sixMonthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sixMonthBtn.clipsToBounds=YES;
    sixMonthBtn.layer.cornerRadius=4;
    sixMonthBtn.backgroundColor=[UIColor lightGrayColor];
    
    //[creditsView addSubview:sixMonthBtn];
    
    UILabel * sixMonthLbl=[[UILabel alloc]init];
    
    sixMonthLbl.font=[UIFont systemFontOfSize:fontSize];
    sixMonthLbl.text=@"2050.00 INR in total";
    [creditsView addSubview:sixMonthLbl];
    
    
    //One Year
    self.oneYear=[UIButton buttonWithType:UIButtonTypeCustom];
    
    self.oneYear.layer.cornerRadius=5;
    self.oneYear.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    self.oneYear.clipsToBounds=YES;
    [self.oneYear setTitle:@"1500 credits" forState:UIControlStateNormal];
    [self.oneYear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.oneYear setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:image]]];
    
    [self.oneYear addTarget:self action:@selector(callPayPalPaymentMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.oneYear.tag=1500;
    [creditsView addSubview:self.oneYear];
    
    
    UIButton * oneYearBtn=[[UIButton alloc]init];
    
    [oneYearBtn setTitle:@"Save 48%" forState:UIControlStateNormal];
    oneYearBtn.layer.borderColor=[UIColor blackColor].CGColor;
    oneYearBtn.layer.borderWidth=0.3;
    oneYearBtn.titleLabel.font=[UIFont systemFontOfSize:fontSize];
    [oneYearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    oneYearBtn.clipsToBounds=YES;
    oneYearBtn.layer.cornerRadius=4;
    oneYearBtn.backgroundColor=[UIColor lightGrayColor];
   // [creditsView addSubview:oneYearBtn];
    
    
    UILabel * oneYearLbl=[[UILabel alloc]init];
    
    oneYearLbl.font=[UIFont systemFontOfSize:fontSize];
    oneYearLbl.text=@"3400.00 INR in total";
    [creditsView addSubview:oneYearLbl];

   // self.threeMonths.frame=CGRectMake(creditsView.frame.size.width/2-80, 70, 168, 31);
   // threeMonthBtn.frame=CGRectMake(creditsView.frame.size.width/2-80, 110, 70, 10);
   // threeMonthsLbl.frame=CGRectMake(creditsView.frame.size.width/2, 110, 200, 10);
    self.oneMonths.frame=CGRectMake(creditsView.frame.size.width/2-80, 140,168, 31);
    oneMonthLbl.frame=CGRectMake(creditsView.frame.size.width/2-20, 180, 200, 10);
    self.sixMonths.frame=CGRectMake(creditsView.frame.size.width/2-80, 205,168, 31);
    sixMonthBtn.frame=CGRectMake(creditsView.frame.size.width/2-80, 250, 70, 10);
    sixMonthLbl.frame=CGRectMake(creditsView.frame.size.width/2, 250, 200, 10);
    self.oneYear.frame=CGRectMake(creditsView.frame.size.width/2-80, 270, 168, 31);
    oneYearBtn.frame=CGRectMake(creditsView.frame.size.width/2-80, 310, 70, 10);
    oneYearLbl.frame=CGRectMake(creditsView.frame.size.width/2, 310, 200, 10);
}

#pragma mark-Cancel button action
-(void)cancelButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma  check for continent
-(void)checkForContinent:(int)tag{
    if (tag==100) {
        if ([continent isEqualToString:@"AS"]) {
            description=@"AS1";
        }
        else if([continent isEqualToString:@"AF"]){
            description=@"AF1";
        }
        else if ([continent isEqualToString:@"AM"]){
            description=@"AM1";
        }
        else if ([continent isEqualToString:@"AUS"]){
            description=@"AUS1";
        }
        else if ([continent isEqualToString:@"SAM"]){
            description=@"SAM1";
        }
        else if ([continent isEqualToString:@"EU"]){
            description=@"EU1";
        }
    }
    else if(tag==600){
        if ([continent isEqualToString:@"AS"]) {
            description=@"AS";
        }
        else if([continent isEqualToString:@"AF"]){
            description=@"AF1";
        }
        else if ([continent isEqualToString:@"AM"]){
            description=@"AM1";
        }
        else if ([continent isEqualToString:@"AUS"]){
            description=@"AUS1";
        }
        else if ([continent isEqualToString:@"SAM"]){
            description=@"SAM1";
        }
        else if ([continent isEqualToString:@"EU"]){
            description=@"EU1";
        }
    }
    else{
        if ([continent isEqualToString:@"AS"]) {
            description=@"AS1";
        }
        else if([continent isEqualToString:@"AF"]){
            description=@"AF1";
        }
        else if ([continent isEqualToString:@"AM"]){
            description=@"AM1";
        }
        else if ([continent isEqualToString:@"AUS"]){
            description=@"AUS1";
        }
        else if ([continent isEqualToString:@"SAM"]){
            description=@"SAM1";
        }
        else if ([continent isEqualToString:@"EU"]){
            description=@"EU1";
        }
    }
}*/

#pragma mark- callPayPalPaymentMethod
-(void)callPayPalPaymentMethod:(UIButton*)sender{
   
    NSString * description;
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    if ([sender tag]==100) {
        total=[NSNumber numberWithDouble:2.09];
        description=@"100 Points Credit";
        desc=@"100";
       // [self checkForContinent:100];
        
    }
    else if ([sender tag]==600)
    {
        total=[NSNumber numberWithDouble:8.83];
        description=@"600 Points Credit";
        desc=@"600";
       // [self checkForContinent:600];
    }
    else{
        total=[NSNumber numberWithDouble: 20.99 ];
        description=@"1500 Points Credit";
        desc=@"1500";
        //[self checkForContinent:1500];
    }
    payment.amount = (NSDecimalNumber*)total;
    payment.currencyCode = @"USD";
    payment.shortDescription =description;
   // payment.items = items;  // if not including multiple items, then leave payment.items as nil
    //payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
    
    if (!payment.processable) {
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here.
    }
    
    // Update payPalConfig re accepting credit cards.
    self.payPalConfig.acceptCreditCards = YES;
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:self.payPalConfig
                                                                                                     delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
  //  self.resultText = [completedPayment description];
    [self showSuccess];
    
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
   // self.resultText = nil;
    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Helpers

- (void)showSuccess {
    self.successView.hidden = NO;
    self.successView.alpha = 1.0f;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:2.0];
    self.successView.alpha = 0.0f;
    [UIView commitAnimations];
}

#pragma mark Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
    NSMutableDictionary * dict=[NSMutableDictionary dictionary];
    dict=[completedPayment.confirmation objectForKey:@"response"];
    if ([[dict objectForKey:@"state"]  isEqualToString:@"approved"]) {
        self.creditsLabel.text=[NSString stringWithFormat:@"Your current balance is %@",total];
        [[NSUserDefaults standardUserDefaults]setObject:self.creditsLabel.text forKey:@"credit"];
        [[NSUserDefaults standardUserDefaults]synchronize];
       
        NSError * error=nil;
        NSURLResponse * urlResponse=nil;
        
        NSURL * postUrl=[NSURL URLWithString:@"http://23.238.24.26/payment/insert-payment-detail"];
         NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:postUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
        [request setHTTPMethod:@"POST"];
        [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];

        NSString * body=[NSString stringWithFormat:@"userid=%@&txn_id=%@&paypal_id=%@&created_at=%@&discription=%@&amount=%@&status=%@",[SingletonClass shareSingleton].userID,[dict objectForKey:@"id"],[dict objectForKey:@"id"],[dict objectForKey:@"create_time"],desc,[NSString stringWithFormat:@"%@",total],@"Success"];
      
        [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
        
        NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        if (data==nil) {
            return;
        }
        id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
