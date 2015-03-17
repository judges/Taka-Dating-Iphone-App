//
//  ApperrenceViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 27/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "ApperrenceViewController.h"
#import "AppDelegate.h"
#import  "SingletonClass.h"

@interface ApperrenceViewController ()

@end

@implementation ApperrenceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"titleAppearence" object:nil];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
  

    
    
    selectedArray=[[NSMutableArray alloc]init];
    
    self.bodyType=[NSArray arrayWithObjects:@"Unfilled yet",@"Average",@"A few extra pounds",@"Slim",@"Atheletic",@"Muscular",@"Big and bold", nil];
    self.eyeColor=[NSArray arrayWithObjects:@"others",@"Brown",@"Grey",@"Green",@"Blue",@"Hazel",@"Other", nil];
    self.hairColor=[NSArray arrayWithObjects:@"Unfilled yet",@"Black",@"Brown",@"Red",@"Blonde",@"Grey",@"White",@"Shaved",@"Dyed",@"Bald", nil];
    self.height=[NSArray arrayWithObjects:@"No answer",@"less than  140 cm (4'7)",@"142 cm (4'8)",@"145 cm (4'9)",@" 147 cm (4'10)",@" 150 cm (4'11)",@"152 cm (5'0)",@"155 cm (5'1)",@"157 cm (5'2)",@"160 cm (5'3)",@"163 cm (5'4)",@"165 cm (5'5)",@"168 cm (5'6)", @" 170 cm (5'7)",@"173 cm (5'8)",@"175 cm (5'9)",@"178 cm (5'10)",@"180 cm (5'11)",@"183 cm (6'0)",@"185 cm (6'1)",@"188 cm (6'2)",@"191 cm (6'3)",@" 193 cm (6'4)",@"196 cm (6'5)",@"198 cm (6'6)", @" 201 cm (6'7)",@" 203 cm (6'8)",@" 205 cm (6'9)",@"208 cm (6'10)",@"210 cm (6'11)",@"213 sm (7'0)",@"215 cm (7'1)",@"218 cm (7'2)",@"220 cm (7'3)",@"more than 223 cm (7'3)",nil];
    
    self.weight=[NSArray arrayWithObjects:@"No answer",@"40 kg",@"41 kg",@"42 kg",@"43 kg",@"44 kg",@"45 kg",@"46 kg",@"47 kg",@"48 kg",@"49 kg",@"50 kg",@"51 kg",@"52 kg",@"53 kg",@"54 kg",@"55 kg",@"56 kg",@"57 kg",@"58 kg",@"59 kg",@"60 kg",@"61 kg",@"62 kg@",@"63 kg@",@"64 kg",@"65 kg",@"66 kg",@"67 kg",@"68 kg",@"69 kg",@"70 kg",@"71 kg",@"72 kg",@"73 kg",@"74 kg",@"75 kg",@"76 kg",@"77 kg",@"78 kg",@"79 kg",@"80 kg",@"81 kg",@"82 kg",@"83 kg",@"84 kg",@"85 kg",@"86 kg",@"87 kg",@"88 kg",@"89 kg",@"90 kg",@"91 kg",@"92 kg",@"93 kg",@"94 kg",@"95 kg",@"96 kg",@"97 kg",@"98 kg",@"99 kg",@"100 kg",@"101 kg",@"102 kg",@"103 kg",@"104 kg",@"105 kg",@"106 kg",@"107 kg",@"108 kg",@"109 kg",@"110 kg",@"111 kg",@"112 kg",@"113 kg",@"114 kg",@"115 kg",@"116 kg",@"117 kg",@"118 kg",@"119 kg",@"120 kg",@"121 kg",@"122 kg",@"123 kg",@"124 kg",@"125 kg",@"126 kg",@"127 kg",@"128 kg",@"129 kg",@"130 kg",@"131 kg",@"132 kg",@"133 kg",@"134 kg",@"135 kg",@"136 kg",@"137 kg",@"138 kg",@"140 kg",@"141 kg",@"142 kg",@"143 kg",@"144 kg",@"145 kg",@"146 kg",@"147 kg",@"148 kg",@"149 kg",@"more than 150 kg", nil];
        [self naviHeader];
        [self createUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)naviHeader
{
    windowSize=[UIScreen mainScreen].bounds.size;
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    self.headerView=[[UIView alloc]init];
    self.headerView.frame=CGRectMake(0, 0, windowSize.width, 55);
   
    [self.view addSubview:self.headerView];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, self.view.frame.size.width, 55);
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.headerView.layer insertSublayer:layer atIndex:0];
    self.headerView.layer.shadowRadius = 5.0;
    self.headerView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.headerView.layer.shadowOpacity = 0.6;
    self.headerView.layer.shadowOffset = CGSizeMake(0.0f,5.0f);
    self.headerView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.headerView.bounds].CGPath;
    
    self.titleLabel = [[UILabel alloc] init];
     self.titleLabel.frame= CGRectMake(windowSize.width/2-60, 20, windowSize.width-200, 35);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"Appearance";
    [self.headerView addSubview:self.titleLabel];
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
    [self.headerView addSubview:self.cancelButton];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveButton.frame = CGRectMake(windowSize.width-70, 25, 60, 25);
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    self.saveButton.layer.borderColor = [UIColor redColor].CGColor;
    self.saveButton.layer.borderWidth = 0.7;
    self.saveButton.layer.cornerRadius = 4;
    self.saveButton.clipsToBounds = YES;
    [self.saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.saveButton];
    
    if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
        self.headerView.frame=CGRectMake(0, 0, windowSize.width, 75);
        layer.frame = CGRectMake(0, 0, windowSize.width, 75);
        self.titleLabel.frame= CGRectMake(100, 20, windowSize.width-200, 35);
         self.cancelButton.frame = CGRectMake(15, 25, 120, 40);
        self.saveButton.frame = CGRectMake(windowSize.width-150, 25, 120, 40);
        
        self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
         self.saveButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        height=75;
        row_hh=85;
        font_size=20;
    }
    else{
        font_size=12;
        row_hh=45;
        height=55;
    }
    

    
    
    // Do any additional setup after loading the view from its nib.
    }
-(void)createUI{
    
    
    if(!self.appearenceTable)
    {
        self.appearenceTable=[[UITableView alloc]init];
        if (UIUserInterfaceIdiomPad==UI_USER_INTERFACE_IDIOM()) {
             self.appearenceTable.frame=CGRectMake(0, height, windowSize.width, windowSize.height-55);
        }
        else{
        if([UIScreen mainScreen].bounds.size.height>500)
        {
            self.appearenceTable.frame=CGRectMake(0, height, windowSize.width, windowSize.height-50);
        }
        else{
            self.appearenceTable.frame=CGRectMake(0, height, windowSize.width, windowSize.height-145);
        }
        }
        self.appearenceTable.delegate=self;
        self.appearenceTable.dataSource=self;
        [self.view addSubview:self.appearenceTable];
    }
    
}

#pragma mark- Table View delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int rows;
    if(section==0||section==1)
    {
        rows=1;
        return  rows;
    }
    if(section==2)
    {
        rows=(int)self.bodyType.count;
        return rows;
    }
    if (section==3) {
        rows=(int)self.eyeColor.count;
        return  rows;
    }
    if(section==4)
    {
        rows=(int)self.hairColor.count;
        return rows;
    }
    return rows;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString * title;
    if (section==0) {
        title=@"Height";
        return title;
    }
    else if (section==1)
    {
        title=@"Weight";
        return title;
    }
    else if (section==2)
    {
        title=@"Body Type";
        return title;
    }
    else if(section==3)
    {
        title=@"Eye color";
        return title;
    }
    else
    {
        title=@"Hair color";
        return title;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return row_hh-20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return row_hh;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    //UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checkmark_ipad.png"]];
    }
     cell.textLabel.font=[UIFont boldSystemFontOfSize:font_size];
    if(indexPath.section==0)
    {
        if (indexPath.row==0) {
            
        

         
            self.heightText=[[UITextField alloc]init];
            self.heightText.frame=CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
            
            
            self.heightText.font=[UIFont systemFontOfSize:font_size];
          
            self.heightText.delegate=self;
            [cell.contentView addSubview:self.heightText];
       
            NSString * height1=[[SingletonClass shareSingleton].height stringByReplacingOccurrencesOfString:@"Height:" withString:@""];
            height1=[height1 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            

            
            
            if (height1) {
                self.heightText.text=height1;
            }
//            if (heightStr) {
//            self.heightText.text=heightStr;
//        }
            
        self.heightText.hidden=NO;
    }
        return cell;
    }
    else if (indexPath.section==1)
    {
        if (indexPath.row==0) {
        

            
            self.weightText=[[UITextField alloc]init];
            self.weightText.frame=CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
           ;
             self.weightText.font=[UIFont systemFontOfSize:font_size];
            
            self.weightText.delegate=self;
            [cell.contentView addSubview:self.weightText];
            NSString * weight=[[SingletonClass shareSingleton].weight stringByReplacingOccurrencesOfString:@"Weight:" withString:@""];
            weight=[weight stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            if (weight) {
                self.weightText.text=weight;
            }
//        if (weightStr) {
//            self.weightText.text=weightStr;
//        }
        self.weightText.hidden=NO;
        }
        return  cell;
    }
    else if (indexPath.section==2)
    {
        NSString * sexuality=[[SingletonClass shareSingleton].bodyType stringByReplacingOccurrencesOfString:@"BodyType:" withString:@""];
        sexuality=[sexuality stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        cell.textLabel.text=[self.bodyType objectAtIndex:indexPath.row];
        if ([sexuality isEqualToString:cell.textLabel.text]) {
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                cell.accessoryView=imgView;
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }return cell;
    }
    else if (indexPath.section==3)
    {
        cell.textLabel.text=[self.eyeColor objectAtIndex:indexPath.row];
        
        NSString * sexuality=[[SingletonClass shareSingleton].eyeColor stringByReplacingOccurrencesOfString:@"EyeColor:" withString:@""];
        sexuality=[sexuality stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        if ([sexuality isEqualToString:cell.textLabel.text]) {
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                cell.accessoryView=imgView;
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
     
        }
        return cell;
    }
    else{
        cell.textLabel.text=[self.hairColor objectAtIndex:indexPath.row];
        
        NSString * sexuality=[[SingletonClass shareSingleton].hairColor stringByReplacingOccurrencesOfString:@"HairColor:" withString:@""];
        sexuality=[sexuality stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        if ([sexuality isEqualToString:cell.textLabel.text]) {
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                cell.accessoryView=imgView;
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
           
        }
        return cell;
    }
    
        return  cell;

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  //NSString * body,* hair,* eye;
    if([SingletonClass shareSingleton].bodyType )
    {
        
    }
        
    if (indexPath.section==2) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (selectedIndex==indexPath)
        {
            return;
        }
        
        UITableViewCell *old = [tableView cellForRowAtIndexPath:selectedIndex];
        old.accessoryType = UITableViewCellAccessoryNone;
        [old setSelected:FALSE animated:TRUE];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checkmark_ipad.png"]];
            old.accessoryView=nil;
        }
        else{
            old.accessoryType = UITableViewCellAccessoryNone;
        }
        
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [cell setSelected:TRUE animated:TRUE];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checkmark_ipad.png"]];
            cell.accessoryView=imgView;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
        selectedIndex = indexPath;
        
         [SingletonClass shareSingleton].bodyType=[NSString stringWithFormat:@"BodyType : %@",[self.bodyType objectAtIndex:selectedIndex.row]];
    }
    if (indexPath.section==3) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (selected2==indexPath)
        {
            return;
        }
        
        UITableViewCell *old = [tableView cellForRowAtIndexPath:selected2];
        old.accessoryType = UITableViewCellAccessoryNone;
        [old setSelected:FALSE animated:TRUE];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checkmark_ipad.png"]];
            old.accessoryView=nil;
        }
        else{
            old.accessoryType = UITableViewCellAccessoryNone;
        }

        
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [cell setSelected:TRUE animated:TRUE];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checkmark_ipad.png"]];
            cell.accessoryView=imgView;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
        selected2 = indexPath;
          [SingletonClass shareSingleton].eyeColor=[NSString stringWithFormat:@" EyeColor : %@",[self.eyeColor objectAtIndex:selected2.row]];
    }
    if (indexPath.section==4) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (selected3==indexPath)
        {
            return;
        }
        
        UITableViewCell *old = [tableView cellForRowAtIndexPath:selected3];
        old.accessoryType = UITableViewCellAccessoryNone;
        [old setSelected:FALSE animated:TRUE];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checkmark_ipad.png"]];
            old.accessoryView=nil;
        }
        else{
            old.accessoryType = UITableViewCellAccessoryNone;
        }
        
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [cell setSelected:TRUE animated:TRUE];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checkmark_ipad.png"]];
            cell.accessoryView=imgView;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        
        selected3 = indexPath;
         [SingletonClass shareSingleton].hairColor=[NSString stringWithFormat:@" HairColor : %@",[self.hairColor objectAtIndex:selected3.row]];
    }
    [SingletonClass shareSingleton].appearance=[NSString stringWithFormat:@" %@ %@ %@",[SingletonClass shareSingleton].bodyType,[SingletonClass shareSingleton].eyeColor,[SingletonClass shareSingleton].hairColor ];
}

#pragma mark-PickerView Delegate methods

-(void)createUIForPicker:(int)section{
    self.appearenceTable.scrollEnabled=NO;
    self.appearenceTable.userInteractionEnabled=NO;
   if(!self.pickerBackView)
    {
        self.pickerBackView=[[UIView alloc]initWithFrame:CGRectMake(0.0, self.view.frame.size.height-200,self.view.frame.size.width,200)];
        self.pickerBackView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:self.pickerBackView];
    }
    self.pickerBackView.hidden=NO;
    
    if(!self.pickerView)
    {
        //self.pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-150,self.view.frame.size.width,100)];
        self.pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.pickerBackView.frame.size.width, 200)];
    }
    self.pickerView.delegate=self;
    self.pickerView.dataSource=self;
    [self.pickerView setShowsSelectionIndicator:NO];
    self.pickerView.hidden=NO;
    
    [self.pickerBackView addSubview:self.pickerView];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    int rows;
    if (sectionVal==0) {
        rows=(int)self.height.count;
        return rows;
    }
    if (sectionVal==1) {
        rows=(int)self.weight.count;
        return rows;
    }

    
    return rows;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(sectionVal==0)
    {
        return  [self.height objectAtIndex:row];
    }
    else if (sectionVal==1)
    {
        return [self.weight objectAtIndex:row];
    }
    else
    {
        return @"";
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if(sectionVal==0)
    {
        heightStr=[self.height objectAtIndex:row];
        self.heightText.text=heightStr;
        [SingletonClass shareSingleton].height=heightStr;
    }
    else{
        weightStr=[self.weight objectAtIndex:row];
        self.weightText.text=weightStr;
        [SingletonClass shareSingleton].weight=weightStr;
    }
}
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

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([touch view] != self.pickerView)
        self.pickerView.hidden=YES;
    self.pickerBackView.hidden=YES;
    self.appearenceTable.userInteractionEnabled=YES;
    self.appearenceTable.scrollEnabled=YES;
        //[self.AddView endEditing:YES];
}

#pragma mark-TextField Delegate methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField==self.heightText) {
        sectionVal=0;
    }
    if (textField==self.weightText) {
        sectionVal=1;
    }
    
    [textField resignFirstResponder];
    [self createUIForPicker:sectionVal];
    return NO;
   
}

#pragma mark-cancelButton

-(void)cancelButtonAction:(id)sender{
     [[NSNotificationCenter defaultCenter]postNotificationName:@"AboutMe" object:nil];
    //[[[[[UIApplication sharedApplication] keyWindow] subviews] lastObject] removeFromSuperview];
    
    [self.navigationController popViewControllerAnimated:YES];

   
}

-(void)saveButtonAction:(id)sender{
    [SingletonClass shareSingleton].appearance=[NSString stringWithFormat:@"%@ %@ %@ %@ %@",[SingletonClass shareSingleton].height,[SingletonClass shareSingleton].weight,[SingletonClass shareSingleton].bodyType,[SingletonClass shareSingleton].eyeColor,[SingletonClass shareSingleton].hairColor ];
    
    NSError * error;
    NSURLResponse * urlResponse=nil;
    
    NSString * urlStr=@"http://23.238.24.26/mobi/appearance-update";
    NSURL * url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString * body=[NSString stringWithFormat:@"userId=%@&height=%@&weight=%@&bodytype=%@&eyeColor=%@&hairColor=%@",[SingletonClass shareSingleton].userID,[SingletonClass shareSingleton].height,[SingletonClass shareSingleton].weight,[SingletonClass shareSingleton].bodyType,[SingletonClass shareSingleton].eyeColor,[SingletonClass shareSingleton].hairColor];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        NSLog(@"Data is not available");
        return;
    }
    id parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    //Not completed yet
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
