//
//  EncounterFilterViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 29/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "EncounterFilterViewController.h"
#import "AppDelegate.h"
#import "EncountersViewController.h"
#import  "SingletonClass.h"

@interface EncounterFilterViewController ()
{
    EncountersViewController * encounterVC;
}

@end

@implementation EncounterFilterViewController

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
    if (encounterVC) {
        encounterVC=nil;
    }
    encounterVC=[[EncountersViewController alloc]initWithNibName:@"EncountersViewController" bundle:nil];
                  [super viewDidLoad];
    windowSize=[UIScreen mainScreen].bounds.size;
    selectedIndex=0;
    age1=[NSArray arrayWithObjects:@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35", nil];
    age2=[NSArray arrayWithObjects:@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35", nil];
    
    self.refreshActivityIndicator = [[UIActivityIndicatorView alloc] init];
     self.refreshActivityIndicator.frame=CGRectMake(windowSize.width/2-20, 150, 40, 40);
    
    self.refreshActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    
    self.refreshActivityIndicator.color = [UIColor blackColor];
    
    [self.view addSubview:self.refreshActivityIndicator];
    [self.view bringSubviewToFront:self.refreshActivityIndicator];
    self.refreshActivityIndicator.alpha = 1.0;
  
    
    appdelegate=[UIApplication sharedApplication].delegate;
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, windowSize.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame=CGRectMake(100, 20, windowSize.width-200, 35);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"Filter";
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
    
    self.find = [UIButton buttonWithType:UIButtonTypeCustom];
    self.find.frame = CGRectMake(250, 25, 60, 25);
    [self.find setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.find.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.find setTitle:@"Find" forState:UIControlStateNormal];
    self.find.layer.borderColor = [UIColor redColor].CGColor;
    self.find.layer.borderWidth = 0.7;
    self.find.layer.cornerRadius = 4;
    self.find.clipsToBounds = YES;
    [self.find addTarget:self action:@selector(filterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.find];
    [self selectUserDataForFilter];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        layer.frame = CGRectMake(0, 0, windowSize.width, 75);
        self.refreshActivityIndicator.frame=CGRectMake(windowSize.width/2-20, 150, 80, 80);
        self.titleLabel.frame=CGRectMake(windowSize.width/2-270, 20, windowSize.width-200, 35);
        self.cancelButton.frame = CGRectMake(windowSize.width/2-350, 25, 120, 40);
        self.find.frame = CGRectMake(windowSize.width-150, 25, 120, 40);
        self.find.titleLabel.font = [UIFont systemFontOfSize:20];
        self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        height=75;
        row_hh=80;
        font_size=20;
    }
    else{
        height=55;
        row_hh=40;
        font_size=12;
    }
    
    
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)selectUserDataForFilter{
    NSString *  firstTime=[[NSUserDefaults standardUserDefaults]objectForKey:@"filterFirstTime"];
    
    if (!firstTime) {
        if (encounterVC) {
            encounterVC=nil;
        }
        encounterVC=[[EncountersViewController alloc]initWithNibName:@"EncountersViewController" bundle:nil];
        if ([SingletonClass shareSingleton].sex==0) {
            [SingletonClass shareSingleton].enwithWhom=@"1";
        }
        else{
            [SingletonClass shareSingleton].enwithWhom=@"0";
        }
        if ([SingletonClass shareSingleton].hereFor==0) {
            [SingletonClass shareSingleton].enhereFor =@"0";
        }
        else if ([SingletonClass shareSingleton].hereFor==1)
        {
            [SingletonClass shareSingleton].enhereFor=@"1";
        }
        else{
           [SingletonClass shareSingleton].enhereFor=@"2";
        }

        
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"filterFirstTime"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
}


-(void)createUI{
    if (!self.filterTable) {
        self.filterTable=[[UITableView alloc]init];
        self.filterTable.frame=CGRectMake(0, height, windowSize.width, windowSize.height);
    }
        self.filterTable.delegate=self;
        self.filterTable.dataSource=self;
    
    self.filterTable.hidden=NO;
    [self.view addSubview:self.filterTable];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString * str;
    if (section==0) {
        str=@"I'm here to";
        return str;
    }
    else if(section==1)
    {
        str=@"With who?";
        return str;
    }
    else if(section==2){
        str=@"Age";
        return str;
    }
    if (section==3) {
        str=@"";
        return str;
    }
    return str;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int rows=0;
    if (section==0) {
        rows=3;
        return rows;
    }
    else if(section==1)
    {
        rows=2;
        return rows;
    }
    else if(section==2)
    {
        rows=1;
        return rows;
    }
    if (section==3) {
        rows =0;
        return rows;
    }
    return rows;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==3) {
        return  row_hh+150;
    }
    return row_hh;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.font=[UIFont systemFontOfSize:font_size];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            if ([[SingletonClass shareSingleton].enhereFor isEqualToString:@"1"]) {
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
                [cell setSelected:YES animated:YES];
                 selectedRowOne=(int)indexPath.row;
           }
            cell.textLabel.text=@"make new firends";

        }
        else if (indexPath.row==1)
        {
            if ([[SingletonClass shareSingleton].enhereFor isEqualToString:@"2"]) {
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
                [cell setSelected:YES animated:YES];
                 selectedRowOne=(int)indexPath.row;
            }

            cell.textLabel.text=@"chat";

        }
        else
        {
            if ([[SingletonClass shareSingleton].enhereFor isEqualToString:@"3"]) {
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
                [cell setSelected:YES animated:YES];
                selectedRowOne=(int)indexPath.row;
            }

            cell.textLabel.text=@"date";
        }
        selectedIndex=indexPath;
        return cell;
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            if ([[SingletonClass shareSingleton].enwithWhom isEqualToString:@"0"]) {
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
                [cell setSelected:YES animated:YES];
                selectedRowTwo=(int)indexPath.row;
            }
            cell.textLabel.text=@"with a boy";
        }
        else{
            if ([[SingletonClass shareSingleton].enwithWhom isEqualToString:@"1"]) {
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
                [cell setSelected:YES animated:YES];
                selectedRowTwo=(int)indexPath.row;
            }
            cell.textLabel.text=@"with a girl";
        }
        index2=indexPath;
        return cell;
    }
    if (indexPath.section==2) {
        self.textFiled=[[UITextField alloc]init];
        self.textFiled.frame=CGRectMake(10, 0, windowSize.width, row_hh);
        self.textFiled.delegate=self;
        self.textFiled.font=[UIFont systemFontOfSize:font_size];
        combineStr=[NSString stringWithFormat:@"%@ - %@ years",[SingletonClass shareSingleton].enFromAge,[SingletonClass shareSingleton].enEndAge];
        if (!combineStr) {
             self.textFiled.text=@"";
        }
        else{
                self.textFiled.text=combineStr;
        }
        [cell.contentView addSubview:self.textFiled];
        return cell;
    
    }
    
    return  cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  row_hh;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==1) {
     UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (index2==indexPath)
        {
           // cell.accessoryType = UITableViewCellAccessoryCheckmark;
            return;
        }
        UITableViewCell *old = [tableView cellForRowAtIndexPath:index2];
        old.accessoryType = UITableViewCellAccessoryNone;
        [old setSelected:FALSE animated:TRUE];
        
    
    
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [cell setSelected:TRUE animated:TRUE];
        
    
        index2 = indexPath;
        selectedRowTwo=(int)indexPath.row;
        if (selectedRowTwo==0) {
             [SingletonClass shareSingleton].enwithWhom=@"0";
        }
        else{
            [SingletonClass shareSingleton].enwithWhom=@"1";
        }
    }
    if (indexPath.section==0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (selectedIndex==indexPath)
        {
           // cell.accessoryType = UITableViewCellAccessoryCheckmark;
            return;
        }
        UITableViewCell *old = [tableView cellForRowAtIndexPath:selectedIndex];
        old.accessoryType = UITableViewCellAccessoryNone;
        [old setSelected:FALSE animated:TRUE];
        
        
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [cell setSelected:TRUE animated:TRUE];
        
        
        selectedIndex = indexPath;
        
         selectedRowOne=(int)indexPath.row;
        if (selectedRowOne==0) {
            [SingletonClass shareSingleton].enhereFor=@"0";
        }
        else if (selectedRowOne==1)
        {
            [SingletonClass shareSingleton].enhereFor=@"1";
        }else{
            [SingletonClass shareSingleton].enhereFor=@"2";
        }
    }
    
}

#pragma mark- delegate methods

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    self.filterTable.scrollEnabled=NO;
    self.filterTable.userInteractionEnabled=NO;
    if(!self.pickerBackView)
    {
        self.pickerBackView=[[UIView alloc]initWithFrame:CGRectMake(0.0, windowSize.height-200,windowSize.width,200)];
        self.pickerBackView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:self.pickerBackView];
    }
    self.pickerBackView.hidden=NO;
    if(!pickerView)
    {
        //self.pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-150,self.view.frame.size.width,100)];
        pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.pickerBackView.frame.size.width, 200)];
    }
    pickerView.delegate=self;
    pickerView.dataSource=self;
    [pickerView setShowsSelectionIndicator:NO];
    pickerView.hidden=NO;
    
    [self.pickerBackView addSubview:pickerView];
    
    
    [textField resignFirstResponder];
    return NO;
}

#pragma mark-picker Delegate methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    int rows;
    if (component==0) {
        rows=(int)age1.count;
        return rows;
    }
    if (component==1) {
        rows=(int)age2.count;
        return rows;
    }
    
    
    return rows;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(component==0)
    {
        return  [age1 objectAtIndex:row];
    }
    else if (component==1)
    {
        return [age2 objectAtIndex:row];
    }
    else
    {
        return @"";
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if(component==0)
    {
        heightStr=[age1 objectAtIndex:row];
    }
    if (component==1) {
        weightStr=[age2 objectAtIndex:row];
        
    }
    if (!heightStr) {
        heightStr=@"18";
    }
    if (!weightStr) {
        weightStr=@"80";
    }
    combineStr=[NSString stringWithFormat:@"%@ - %@ years",heightStr,weightStr];
    self.textFiled.text=combineStr;
    [SingletonClass shareSingleton].enFromAge=heightStr;
    [SingletonClass shareSingleton].enEndAge=weightStr;
}
/*
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    
    
    
    UILabel *channelLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, -5, 150, 50)];
    if(sectionVal==0)
    {
        channelLabel.text = [NSString stringWithFormat:@"%@",[self.height objectAtIndex:row] ];
    }
    else{
        channelLabel.text = [NSString stringWithFormat:@"%@",[self.weight objectAtIndex:row] ];
    }
    channelLabel.textAlignment = NSTextAlignmentLeft;
    channelLabel.backgroundColor = [UIColor clearColor];
    
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    tmpView.backgroundColor=[UIColor darkGrayColor];
    
    [tmpView insertSubview:channelLabel atIndex:0];
    
    return  tmpView;
}
*/
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 20;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([touch view] != pickerView)
        pickerView.hidden=YES;
    self.pickerBackView.hidden=YES;
    self.filterTable.userInteractionEnabled=YES;
    self.filterTable.scrollEnabled=YES;
   
}


#pragma mark- Cancel Button

-(void)cancelButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)filterButtonAction:(id)sender{
    dispatch_async(dispatch_get_main_queue(),^{
        [self callWebServiceForEncounter];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)callWebServiceForEncounter{
    NSError * error;
    NSURLResponse * urlResponse;
    int count;
    [self.refreshActivityIndicator startAnimating];
    
    if (selectedRowTwo==0) {
        int boyCount=(int)[[NSUserDefaults standardUserDefaults]integerForKey:@"boyCount"];
        if (!boyCount) {
            boyCount+=1;;
            NSString * boyCnt=[NSString stringWithFormat:@"%d",boyCount];
            [[NSUserDefaults standardUserDefaults]setObject:boyCnt forKey:@"count"];
            [[NSUserDefaults standardUserDefaults]setInteger:boyCount forKey:@"boyCount"];

            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        else{
            boyCount+=1;
            [[NSUserDefaults standardUserDefaults]setInteger:boyCount forKey:@"boyCount"];
            NSString * boyCnt=[NSString stringWithFormat:@"%d",boyCount];
            [[NSUserDefaults standardUserDefaults]setObject:boyCnt forKey:@"count"];
            [[NSUserDefaults standardUserDefaults]synchronize];

        }
    }
    else {
        int girlCount=(int)[[NSUserDefaults standardUserDefaults]integerForKey:@"girlCount"];
        if (!girlCount) {
            girlCount+=1;
            NSString * girlCnt=[NSString stringWithFormat:@"%d",girlCount];
            [[NSUserDefaults standardUserDefaults]setObject:girlCnt forKey:@"count"];
            [[NSUserDefaults standardUserDefaults]setInteger:girlCount forKey:@"girlCount"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        else{
            girlCount+=1;
            [[NSUserDefaults standardUserDefaults]setInteger:girlCount forKey:@"girlCount"];
            
            NSString * girlCnt=[NSString stringWithFormat:@"%d",girlCount];
            [[NSUserDefaults standardUserDefaults]setObject:girlCnt forKey:@"count"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }

    }
    
        NSString * countStr=[[NSUserDefaults standardUserDefaults]objectForKey:@"count"];
        count=[countStr intValue];
        NSLog(@"count %d",count);
      /* NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/mobile/encounters/%@/%@/%@/%@/%@/%d",[SingletonClass shareSingleton].userID,[SingletonClass shareSingleton].enhereFor,[SingletonClass shareSingleton].enwithWhom,[SingletonClass shareSingleton].enFromAge,[SingletonClass shareSingleton].enEndAge,count];
    
    
    
    urlStr =[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];*/
    NSString* urlStr=@"http://23.238.24.26/mobi/encounter";
    NSURL * url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString * body=[NSString stringWithFormat:@"userId=%@&hereto=%@&withwho=%@&startage=%@&endage=%@&count=%d",[SingletonClass shareSingleton].userID,[SingletonClass shareSingleton].enhereFor,[SingletonClass shareSingleton].enwithWhom,[SingletonClass shareSingleton].enFromAge,[SingletonClass shareSingleton].enEndAge,count];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        NSLog(@"No data available");
        return;
    }
    
    id enParse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"parse of encounter %@",enParse);
    
    [[SingletonClass shareSingleton].encounterUsrImages removeAllObjects];
    if ([[enParse objectForKey:@"code"]isEqualToNumber:[NSNumber numberWithInt:200]] ) {
        NSArray * imageArr=[enParse objectForKey:@"userImages"];
        if (imageArr.count>1) {
            return;
        }
        else{
            NSMutableDictionary * imagesDict=[[NSMutableDictionary alloc]init];
            for (int i=0; i<imageArr.count; i++) {
                imagesDict=[imageArr objectAtIndex:i];
               encounterVC.imageId=[imagesDict objectForKey:@"imageId"];
                [[SingletonClass shareSingleton].encounterUsrImages addObject:[NSString stringWithFormat:@"http://taka.dating/%@",[imagesDict objectForKey:@"imageLink"]]];
            }
        }
        
        NSArray * userProfile=[enParse objectForKey:@"userProfile"];
        if (userProfile.count<1||imageArr.count>1) {
            return;
        }
        else{
            NSMutableDictionary * userInfo=[[NSMutableDictionary alloc]init];
            for (int k=0;k<userProfile.count;k++) {
                userInfo=[userProfile objectAtIndex:k];
                [[SingletonClass shareSingleton].encounterUsrImages addObject:[NSString stringWithFormat:@"http://taka.dating/%@",[userInfo objectForKey:@"thumbanailUrl"]]];
                
               encounterVC.sex=[userInfo objectForKey:@"sex"];
                encounterVC.userHereFor=[userInfo objectForKey:@"hereFor"];
             encounterVC.useriId=[userInfo objectForKey:@"userId"];
               encounterVC.displayName=[userInfo objectForKey:@"displayName"];
                encounterVC.about=[userInfo objectForKey:@"about"];
                encounterVC.location=[userInfo objectForKey:@"location"];
                encounterVC.interestedIn=[userInfo objectForKey:@"interestedIn"];
                encounterVC.bodyType=[self getbodyType:[userInfo objectForKey:@"bodyType"]];
                encounterVC.hairColor=[self getHairColor:[userInfo objectForKey:@"hairColor"]];
               encounterVC.eyeColor=[self getEyeColor:[userInfo objectForKey:@"eyeColor"]];
                encounterVC.height=[userInfo objectForKey:@"height"];
                encounterVC.weight=[userInfo objectForKey:@"weight"];
               encounterVC.living=[self getLiving:[userInfo objectForKey:@"living"]];
                encounterVC.kids=[self getKids:[userInfo objectForKey:@"kids"]];
                encounterVC.smoking=[self getSmoking:[userInfo objectForKey:@"smoking"]];
                encounterVC.drinking=[self getDrinking:[userInfo objectForKey:@"drinking"]];
                encounterVC.eduaction=[self getEducation:[userInfo objectForKey:@"education"]];
                encounterVC.income=[self getIncome:[userInfo objectForKey:@"income"]];
                encounterVC.relationship=[self getRelationship:[userInfo objectForKey:@"relationshipStatus"]];
                encounterVC.sexuality=[self getSexuality:[userInfo objectForKey:@"sexuality"]];
                encounterVC.profession=[userInfo objectForKey:@"profession"];
                if ([[userInfo objectForKey:@"languagesKnown"]isEqualToString:@"0"]) {
                    encounterVC.profession=@"";
                }
                else{
                    encounterVC.profession=[userInfo objectForKey:@"languagesKnown"];
                }
                NSArray * intrestArr=[enParse objectForKey:@"userInterests"];
                for (int j=0; j<intrestArr.count; j++) {
                    NSMutableDictionary * intDict=[intrestArr objectAtIndex:j];
                   // intrests=[intDict objectForKey:@"userInterests"];
                    
                    
                }
            }
        }
      
//        NSString * countStr=[[NSUserDefaults standardUserDefaults]objectForKey:@"count"];
//        count=[countStr intValue];
//        count+=1;
//        countStr =[NSString stringWithFormat:@"%d",count];
//        [[NSUserDefaults standardUserDefaults]setObject:countStr forKey:@"count"];
//        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.refreshActivityIndicator stopAnimating];
    }
}

-(NSString * )getSexuality:(NSString *)value
{
    int val=value.intValue;
    NSString * sex=@"";
    if (val==0) {
        sex=@"Unfilled yet";
        
    }
    else if (val==1)
    {
        sex=@"Straight";
        
    }
    else if (val==3)
    {
        sex=@"Bisexual";
    }
    else if(val==2){
        sex=@"Open Minded";
    }
    else if(val==4){
        sex=@"Gay";
    }
    else{
        sex=@"Lesbian";
    }
    return sex;
    
}



-(NSString *)getRelationship:(NSString *)value{
    int val=value.intValue;
    NSString * relation=@"";
    if (val==0) {
        relation=@"Unfilled yet";
        
    }
    else if (val==1)
    {
        relation=@"Single";
        
    }
    else if (val==3)
    {
        relation=@"Taken";
    }
    else{
        relation=@"Open";
    }
    return relation;
}



-(NSString *)getIncome:(NSString *)value{
    int val=value.intValue;
    NSString * income=@"";
    if (val==0) {
        income=@"Unfilled yet";
    }
    else if(val==1)
    {
        income=@"Low";
    }
    else if(val==2)
    {
        income=@"Average";
    }
    else
    {
        income=@"High";
    }
    return  income;
}



-(NSString *)getEducation:(NSString *)value{
    int val=value.intValue;
    NSString * edu=@"";
    if (val==0) {
        edu=@"Unfilled yet";
        
    }
    else if (val==1)
    {
        edu=@"School only";
        
    }
    else if (val==3)
    {
        edu=@"Trade/Technical";
    }
    else if(val==2){
        edu=@"College/University";
    }
    else{
        edu=@"Advanced Degree";
    }
    return edu;
}


-(NSString *)getDrinking:(NSString *)value{
    int val=value.intValue;
    NSString * drinking=@"";
    if (val==0) {
        drinking=@"Unfilled yet";
        
    }
    else if (val==1)
    {
        drinking=@"No";
        
    }
    else if (val==3)
    {
        drinking=@"With Company";
    }
    else if(val==2){
        drinking=@"No, Never";
    }
    else{
        drinking=@"Yes, Please";
    }
    return drinking;
}



-(NSString *)getSmoking:(NSString *)value{
    int val= value.intValue;
    NSString * smoking=@"";
    if (val==0) {
        smoking=@"Unfilled yet";
    }
    else if (val==1){
        smoking=@"No";
    }
    else if (val==2)
    {
        smoking=@"No, Never";
    }
    else if (val==3)
    {
        smoking=@"Yes";
    }
    else if (val==4)
    {
        smoking=@"Social";
    }
    else
    {
        smoking=@"Chain Smoker, Oxygen is overrated";
    }
    
    return smoking;
}



-(NSString *)getKids:(NSString *)value{
    int val= value.intValue;
    NSString * kid=@"";
    if (val==0) {
        kid=@"Unfilled yet";
    }
    else if(val==1)
    {
        kid=@"No, Never";
    }
    else if(val==2)
    {
        kid=@"Someday";
    }
    else if(val==3)
    {
        kid=@"Already Have";
    }
    else
    {
        kid=@"Empty nest";
    }
    return kid;
}




-(NSString *)getLiving:(NSString *)value{
    NSString * living=@"";
    int val= value.intValue;
    if (val==0) {
        living=@"Unfilled yet";
    }
    else if(val==1)
    {
        living=@"With Parents";
    }
    else if(val==2)
    {
        living=@"With Roomates";
    }
    else if(val==3)
    {
        living=@"Student Residence";
    }
    else if(val==4)
    {
        living=@"With Partner";
    }
    else{
        living=@"Alone";
    }
    return  living;
}


-(NSString *)getEyeColor:(NSString *)value{
    NSString * str=@"";
    
    int val= value.intValue;
    if (val==0) {
        str=@"others";
    }
    else if(val==1)
    {
        str=@"Brown";
    }
    else if(val==2)
    {
        str=@"Grey";
    }
    else if(val==3)
    {
        str=@"Green";
    }
    else if(val==4)
    {
        str=@"Blue";
    }
    else if(val==5)
    {
        str=@"Hazel";
    }
    else
    {
        str=@"Other";
    }
    
    return str;
    
}



-(NSString *)getHairColor:(NSString *)value{
    NSString * str=@"";
    
    int val= value.intValue;
    if (val==0) {
        str=@"Unfilled yet";
    }
    else if(val==1)
    {
        str=@"Black";
    }
    else if(val==2)
    {
        str=@"Brown";
    }
    else if(val==3)
    {
        str=@"Red";
    }
    else if(val==4)
    {
        str=@"Grey";
    }
    else if(val==5)
    {
        str=@"White";
    }
    else if(val==6)
    {
        str=@"Shaved";
    }
    else if(val==7)
    {
        str=@"Dyed";
    }
    else
    {
        str=@"Bald";
    }
    
    
    return str;
    
}



-(NSString *)getbodyType:(NSString *)bodytype{
    NSString * str=@"";
    if ([bodytype isEqualToString:@"0"]) {
        str=@"Unfilled yet";
    }
    else if([bodytype isEqualToString:@"1"])
    {
        str=@"Average";
    }
    else if([bodytype isEqualToString:@"2"])
    {
        str=@"A few extra pounds";
    }
    else if([bodytype isEqualToString:@"3"])
    {
        str=@"Slim";
    }
    else if([bodytype isEqualToString:@"4"])
    {
        str=@"Athletic";
    }
    else if([bodytype isEqualToString:@"5"])
    {
        str=@"Muscular";
    }
    else{
        str=@"Big and beautiful";
        
    }
    return  str;
}



@end
