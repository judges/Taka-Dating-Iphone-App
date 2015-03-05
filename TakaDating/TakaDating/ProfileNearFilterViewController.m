//
//  ProfileNearFilterViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 04/12/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "ProfileNearFilterViewController.h"
#import "SingletonClass.h"

@interface ProfileNearFilterViewController ()

@end

@implementation ProfileNearFilterViewController

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
    windowSize=[UIScreen mainScreen].bounds.size;
    [super viewDidLoad];
    searchRslt=NO;
   
    selectedIndex=0;
    age1=[NSArray arrayWithObjects:@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29", nil];
    age2=[NSArray arrayWithObjects:@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29", nil];
    
    distancearr=[NSArray arrayWithObjects:@"5",@"10",@"50",@"100",@"140",@"150",nil];
    
    
    appdelegate=[UIApplication sharedApplication].delegate;
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, windowSize.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame=CGRectMake(windowSize.width/2-60, 20, windowSize.width-200, 35);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"Filter";
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
    
    self.find = [UIButton buttonWithType:UIButtonTypeCustom];
    self.find.frame = CGRectMake(windowSize.width-70, 25, 60, 25);
    [self.find setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.find.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.find setTitle:@"Find" forState:UIControlStateNormal];
    self.find.layer.borderColor = [UIColor redColor].CGColor;
    self.find.layer.borderWidth = 0.7;
    self.find.layer.cornerRadius = 4;
    self.find.clipsToBounds = YES;
    [self.find addTarget:self action:@selector(findPeopleNearby) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.find];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        layer.frame = CGRectMake(0, 0, windowSize.width, 75);
        self.titleLabel.frame=CGRectMake(windowSize.width/2-270, 25, windowSize.width-200, 40);

        self.cancelButton.frame = CGRectMake(windowSize.width/2-350, 25, 120, 40);
        self.find.frame = CGRectMake(windowSize.width-150, 25, 120, 40);
        self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.find.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        row_hh=80;
        height=75;
        font_size=20;
    }
    else{
        row_hh=40;
        height=55;
        font_size=12;
    }
    
    
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)createUI{
    if (!self.filterTable) {
        self.filterTable=[[UITableView alloc]init];
        }
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        self.filterTable.frame=CGRectMake(0, height, windowSize.width, windowSize.height-80);
    }
    else{
        self.filterTable.frame=CGRectMake(0, height, windowSize.width, windowSize.height-55);
    }
    self.filterTable.delegate=self;
    self.filterTable.dataSource=self;
    self.filterTable.backgroundColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    self.filterTable.separatorColor=[UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    self.filterTable.hidden=NO;
    [self.view addSubview:self.filterTable];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (searchRslt==YES) {
        return 6;
    }
    return 5;
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
        str=@"Distance";
        return str;
    }
    if (section==4) {
        str=@"Place";
    }
    if (searchRslt==YES) {
        if (section==5) {
            str=@"Choose";
        }
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
    if (section==3||section==4) {
        rows =1;
        return rows;
    }
    if (searchRslt==YES) {
        if (section==5) {
            rows=(int)self.placeName.count;
        }
    }
    return rows;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section==3) {
//        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
//            return 250;
//        }
//        return  150;
//    }
    return row_hh-10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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
            if ([SingletonClass shareSingleton].hereFor==0) {
                
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
                [cell setSelected:TRUE animated:TRUE];
            }
//            else{
//                cell.accessoryType=UITableViewCellAccessoryNone;
//            }
             cell.textLabel.text=@"make new firends";
           selectedIndex=indexPath;
            selectedRowSecOne=(int)indexPath.row;
            
        }
        else if (indexPath.row==1)
        {
            if ([SingletonClass shareSingleton].hereFor==1) {
               
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
                [cell setSelected:TRUE animated:TRUE];
            }
//            else{
//               
//                cell.accessoryType=UITableViewCellAccessoryNone;
//            }
            
            cell.textLabel.text=@"chat";
            selectedIndex=indexPath;
            selectedRowSecOne=(int)indexPath.row;

        }
        else
        {
            if ([SingletonClass shareSingleton].hereFor==2) {
                
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
                 [cell setSelected:TRUE animated:TRUE];
            }
//            else{
//                
//                cell.accessoryType=UITableViewCellAccessoryNone;
//            }
             cell.textLabel.text=@"date";
            selectedIndex=indexPath;
            selectedRowSecOne=(int)indexPath.row;
           
        }
        //return cell;
    }
    if (indexPath.section==1) {
       
        if (indexPath.row==0) {
            if ([SingletonClass shareSingleton].sex==0) {
                

                cell.accessoryType=UITableViewCellAccessoryCheckmark;
                 [cell setSelected:TRUE animated:TRUE];
            }
//            else{
//
//                cell.accessoryType=UITableViewCellAccessoryNone;
//            }
            index2=indexPath;
            selectedRowSecTwo=(int)indexPath.row;
            
            cell.textLabel.text=@"with a boy";
        }
        else{
            if ([SingletonClass shareSingleton].sex==1) {
                
                cell.accessoryType=UITableViewCellAccessoryCheckmark;
            }
//            else{
//                
//                cell.accessoryType=UITableViewCellAccessoryNone;
//                
//            }
            index2=indexPath;
            selectedRowSecTwo=(int)indexPath.row;
            
            cell.textLabel.text=@"with a girl";
           
            
        }
       // return cell;
    }
    if (indexPath.section==2) {
        self.textFiled=[[UITextField alloc]init];
        self.textFiled.frame=CGRectMake(10, 0, windowSize.width, row_hh);
        self.textFiled.delegate=self;
        self.textFiled.font=[UIFont systemFontOfSize:font_size];
        if (combineStr) {
            self.textFiled.text=combineStr;
        }
        [cell.contentView addSubview:self.textFiled];
       // return cell;
        
    }
    if (indexPath.section==3) {
        self.distanceTxtField =[[UITextField alloc]init];
        self.distanceTxtField.frame=CGRectMake(10, 0, windowSize.width, row_hh);
        self.distanceTxtField.delegate=self;
        self.distanceTxtField.font=[UIFont systemFontOfSize:font_size];
        if (distance) {
            self.distanceTxtField.text=distance;
        }
        [cell.contentView addSubview:self.distanceTxtField];
        //return  cell;

    }
    if (indexPath.section==4) {
        self.placeTextFiled =[[UITextField alloc]init];
        self.placeTextFiled.frame=CGRectMake(10, 0, windowSize.width, row_hh);
        self.placeTextFiled.delegate=self;
        self.placeTextFiled.font=[UIFont systemFontOfSize:font_size];
        if(self.placeName.count>0){
            NSLog(@"%@",[self.placeName objectAtIndex:selectedRow]);
            self.placeTextFiled.text=[self.placeName objectAtIndex:selectedRow];
        }
            
        [cell.contentView addSubview:self.placeTextFiled];
        //return  cell;
    }
    if (indexPath.section==5) {
        cell.textLabel.text=[self.placeName objectAtIndex:indexPath.row];
    }
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==1) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (index2==indexPath)
        {
            
            return;
        }
        UITableViewCell *old = [tableView cellForRowAtIndexPath:index2];
        old.accessoryType = UITableViewCellAccessoryNone;
        [old setSelected:FALSE animated:TRUE];
        
        
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [cell setSelected:TRUE animated:TRUE];
        
        
        index2 = indexPath;
       selectedRowSecTwo=(int)indexPath.row;
         }
    if (indexPath.section==0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (selectedIndex==indexPath)
        {
            return;
        }
        UITableViewCell *old = [tableView cellForRowAtIndexPath:selectedIndex];
        old.accessoryType = UITableViewCellAccessoryNone;
        [old setSelected:FALSE animated:TRUE];
        
        
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [cell setSelected:TRUE animated:TRUE];
        selectedIndex = indexPath;
         selectedRowSecOne=(int)indexPath.row;
    }
    if (indexPath.section==5) {
        self.placeTextFiled.text=[self.placeName objectAtIndex:indexPath.row];
        selectedRow=(int)indexPath.row;
        searchRslt=NO;
        [self.filterTable reloadData];
    }
   
    
   
    
}

#pragma mark- delegate methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==self.placeTextFiled) {
        if ([UIScreen mainScreen].bounds.size.height>500) {
             self.filterTable.frame=CGRectMake(0, height, windowSize.width, windowSize.height-80);
        }
        else{
             self.filterTable.frame=CGRectMake(0, height, windowSize.width, windowSize.height-55);
        }
       
        [textField resignFirstResponder];
        
        [NSThread detachNewThreadSelector:@selector(getEnteredLocation:) toTarget:self withObject:self.placeTextFiled.text];
        return YES;
    }
    return NO;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField==self.placeTextFiled) {
        self.filterTable.frame=CGRectMake(0, height, windowSize.width, windowSize.height/2-100);
        return  YES;
    }
    else{
        if (textField==self.textFiled) {
            numberofComp=2;
        }
        else{
            numberofComp=1;
        }
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
    
}

#pragma mark-picker Delegate methods

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return numberofComp;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    int rows;
    if (numberofComp==1) {
        return distancearr.count;
    }
    else{
    if (component==0) {
        rows=(int)age1.count;
        return rows;
    }
    if (component==1) {
        rows=(int)age2.count;
        return rows;
    }
}
    
    return rows;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (numberofComp==1) {
        return [distancearr objectAtIndex:row];
    }
    else{
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
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (numberofComp==1) {
        self.distanceTxtField.text=[distancearr objectAtIndex:row];
        distance=[distancearr objectAtIndex:row];
    }
    else{
    if(component==0)
    {
        heightStr=[age1 objectAtIndex:row];
    }
    if (component==1) {
        weightStr=[age2 objectAtIndex:row];
        
    }
    combineStr=[NSString stringWithFormat:@"%@ - %@ years",heightStr,weightStr];
    self.textFiled.text=combineStr;
        
    }
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


#pragma mark-getEnteredLocation
-(void)getEnteredLocation:(NSString *)place{
    NSError * error;
    NSURLResponse * urlResponse;
    
    NSString * urlStr=[NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?address=\"%@\"&sensor=false",place];
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        NSLog(@"no data available ");
        return;
    }
    
    id parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    self.placeName=[[NSMutableArray alloc]init];
    self.logAndLat=[[NSMutableArray alloc]init];
    dict=[[NSMutableDictionary alloc]init];
    geoDict=[[NSMutableDictionary alloc]init];
    NSMutableArray * allPlaces=[parse objectForKey:@"results"];
      dispatch_async(dispatch_get_main_queue(), ^{
            for (int i=0;i<allPlaces.count; i++) {
                    dict=[allPlaces objectAtIndex:i];
                    [self.placeName addObject:[dict objectForKey:@"formatted_address"]];
                    geoDict=[dict objectForKey:@"geometry"];
                    locationDict=[geoDict objectForKey:@"location"];
                     log=[locationDict objectForKey:@"lng"];
                     lat=[locationDict objectForKey:@"lat"];
                [self.logAndLat addObject:[NSString stringWithFormat:@"%@/%@",lat,log]];
            }
          searchRslt=YES;
          [self.filterTable reloadData];
      });
    
}

#pragma mark- find people near by

-(void)findPeopleNearby{
    NSError * error;
    NSURLResponse * urlResponse;
   
    findPressed=YES;
    
    
    
   // NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/user/nearby/%d/%d/%@/%d/%@/%@/%@/%@/%@/%@/%@/%@",selectedRowSecOne,selectedRowSecTwo,self.placeTextFiled.text,0,heightStr,weightStr,distance,lat,log,[SingletonClass shareSingleton].userID,@"1",@"0"];
   // urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * url=[NSURL URLWithString:@"http://23.238.24.26/user/people"];
    
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    

    NSString * body=[NSString stringWithFormat:@"gen=%d&hereFor=%d&location=%@&interestedIn=%d&start_age=%@&end_age=%@&radius=%@&lat=%@&lag=%@&userId=%@&count=%@&status=%d",selectedRowSecOne,selectedRowSecTwo,self.placeTextFiled.text,0,heightStr,weightStr,distance,lat,log,[SingletonClass shareSingleton].userID,@"0",1];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        NSLog(@"no data available ");
        return;
    }
    
    NSMutableArray * parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@" find location in filter %@",parse);
    if (parse.count>1) {
        [[SingletonClass shareSingleton].viewerName removeAllObjects];
        [[SingletonClass shareSingleton].imgCount removeAllObjects];
        [[SingletonClass shareSingleton].isOnline removeAllObjects];
        [[SingletonClass shareSingleton].viewerImage removeAllObjects];
        [[SingletonClass shareSingleton].viewerID removeAllObjects];

    }
    
    NSMutableDictionary * dictFilter=[[NSMutableDictionary alloc]init];
    for (int i=0; i<parse.count; i++) {
        dictFilter=[parse objectAtIndex:i];
        [ [SingletonClass shareSingleton].viewerName addObject:[dictFilter objectForKey:@"displayName"]];
        [[SingletonClass shareSingleton].imgCount addObject:[dictFilter objectForKey:@"imagecount"]];
        [[SingletonClass shareSingleton].isOnline addObject:[dictFilter objectForKey:@"isOnline"]];
        [[SingletonClass shareSingleton].viewerImage addObject:[dictFilter objectForKey:@"thumbanailUrl"]];
        [[SingletonClass shareSingleton].viewerID addObject:[dictFilter objectForKey:@"userId"]];
    }


}

#pragma mark- Cancel Button

-(void)cancelButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    if (findPressed==YES) {
         [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadCollectionView" object:nil];
        findPressed=NO;
    }
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
