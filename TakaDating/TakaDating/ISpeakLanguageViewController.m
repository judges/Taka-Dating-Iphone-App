//
//  ISpeakLanguageViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 12/01/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "ISpeakLanguageViewController.h"
#import "SingletonClass.h"

@interface ISpeakLanguageViewController ()

@end

@implementation ISpeakLanguageViewController

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
    [super viewDidLoad];
    if ([SingletonClass shareSingleton].languages!=nil) {
        [self seperateAllLanguages];
    }
    self.selectedArray = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    languageArray=[NSArray arrayWithObjects:@"English",@"German",@"French",@"Spanish",@"Italian",@"Portuguese",@"Russian",@"Chinese",@"Afrikaans",@"Indonesian",@"Bosnain",@"Catalan",@"Czech",@"Creole",@"Welsh",@"Danish",@"Estonian",@"Esperanto",@"Basque", nil];
    
    win=[UIScreen mainScreen].bounds.size;
    
   // self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)148/255 blue:(CGFloat)214/255 alpha:1.0];
    
   /* self.headerView=[[UIView alloc]init];
    self.headerView.frame=CGRectMake(0, 0, win.width, 55);
    
    [self.view addSubview:self.headerView];*/
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, win.width, 55);
   // UIColor *firstColor = [UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
   // UIColor *secColor = [UIColor colorWithRed:(CGFloat)121/255 green:(CGFloat)2/255 blue:(CGFloat)0/255 alpha:1.0];
    UIColor *firstColor = [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)88/255 blue:(CGFloat)211/255 alpha:1.0];
    UIColor *secColor = [UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)0/255 blue:(CGFloat)155/255 alpha:1.0];    layer.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor],(id)[secColor CGColor], nil];
    [self.view.layer insertSublayer:layer atIndex:0];
   /* [self.headerView.layer insertSublayer:layer atIndex:0];
    self.headerView.layer.shadowRadius = 5.0;
    self.headerView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.headerView.layer.shadowOpacity = 0.6;
    self.headerView.layer.shadowOffset = CGSizeMake(0.0f,5.0f);
    self.headerView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.headerView.bounds].CGPath;*/
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame=CGRectMake(win.width/2-60, 25, win.width-200, 25);
   // self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.text = @"Languages";
    [self.view addSubview:self.titleLabel];
    //Add Cancel BUTTON
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake(win.width/2-145, 25, 60, 25);
    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelButton.layer.borderColor = [UIColor redColor].CGColor;
    self.cancelButton.layer.borderWidth = 0.7;
    self.cancelButton.layer.cornerRadius = 4;
    self.cancelButton.clipsToBounds = YES;
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveButton.frame = CGRectMake(win.width-70, 25, 60, 25);
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
    self.saveButton.layer.borderColor = [UIColor redColor].CGColor;
    self.saveButton.layer.borderWidth = 0.7;
    self.saveButton.layer.cornerRadius = 4;
    self.saveButton.clipsToBounds = YES;
    [self.saveButton addTarget:self action:@selector(langaugseSaveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveButton];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
         //self.headerView.frame=CGRectMake(0, 0, win.width, 75);
         layer.frame = CGRectMake(0, 0, win.width, 75);;
        
        self.titleLabel.frame=CGRectMake(win.width/2-100, 25, win.width-200, 40);
         self.cancelButton.frame = CGRectMake(win.width/2-350, 25, 120, 40);
        self.saveButton.frame = CGRectMake(win.width-150, 25, 120, 40);
        
        self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        self.cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        self.saveButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        height=75;
        row_hh=80;
        table_hh=win.height-80;
        font_size=30;
    }
    else{
        height=55;
        row_hh=40;
        table_hh=win.height-50;
        font_size=12;
    }
    
    
    [self createUI];
    
}

#pragma mark- createUI
-(void)createUI{
    if (selectLanguageTbale) {
        selectLanguageTbale=nil;
    }
    selectLanguageTbale=[[UITableView alloc]init];
    selectLanguageTbale.frame=CGRectMake(0, height, win.width, table_hh);
    selectLanguageTbale.dataSource=self;
    selectLanguageTbale.delegate=self;
    [selectLanguageTbale setSeparatorColor:[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)148/255 blue:(CGFloat)214/255 alpha:1.0]];
    selectLanguageTbale.backgroundColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)148/255 blue:(CGFloat)214/255 alpha:1.0];
    [self.view addSubview:selectLanguageTbale];
}

#pragma  mark- Delegate Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  languageArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return row_hh+10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return row_hh;
}

/*-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * label=[[UILabel alloc]init];
    label.frame=CGRectMake(50, 20, 220, 30);
    label.font=[UIFont systemFontOfSize:15];
    label.textColor=[UIColor blackColor];
    label.numberOfLines=0;
    label.lineBreakMode=NSLineBreakByCharWrapping;
    
    UIView * view=[[UIView alloc]init];
    
    [view addSubview:label];
    return view;
}*/
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectClassCell * cell=(SelectClassCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[SelectClassCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        cell.cellLabel.frame=CGRectMake(80,20, 200, 30);
        cell.leftbutton.frame=CGRectMake(10, 15, 43, 43);
        select_image=@"select_normal_ipad.png";
        select_image_act=@"select_ipad.png";
    }
    else{
            select_image=@"select_normal.png";
            select_image_act=@"select.png";
            cell.cellLabel.frame=CGRectMake(40, 5, 100, 30);
            cell.leftbutton.frame=CGRectMake(5, 10, 20, 20);
    }
    cell.cellLabel.text=[languageArray objectAtIndex:indexPath.row];
   
    for (int i=0; i<self.names.count; i++) {
        if ( [cell.cellLabel.text isEqualToString:[self.names objectAtIndex:i]]) {
            [cell.leftbutton setImage:[UIImage imageNamed:select_image_act]forState:UIControlStateSelected];
            [cell.leftbutton setSelected:YES];
            [self.selectedArray addObject:indexPath];
        }
    }
    //cell.leftbutton.tag=indexPath.row;
    @try {
        if ([self.selectedArray containsObject:indexPath]) {
            [cell.leftbutton setImage:[UIImage imageNamed:select_image_act]forState:UIControlStateSelected];
            [cell.leftbutton setSelected:YES];
        }
        else
        {
           
            [cell.leftbutton setImage:[UIImage imageNamed:select_image]forState:UIControlStateNormal];
            [cell.leftbutton setSelected:NO];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception %@",[exception name]);
    }
   
    
    return  cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        SelectClassCell * cell=(SelectClassCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        cell.leftbutton.frame=CGRectMake(10, 15, 43, 43);
            }
    else{
       
        cell.leftbutton.frame=CGRectMake(5, 10, 20, 20);
    }
        //cell.leftbutton.frame=CGRectMake(5, 10, 20, 20);
       // cell.rightButton.frame=CGRectMake(200, 10,80,20);
    

    if ([cell.leftbutton isSelected]==YES) {
        [cell.leftbutton setImage:[UIImage imageNamed:select_image]forState:UIControlStateNormal];
        [cell.leftbutton setSelected:NO];
        [self.selectedArray removeObject:indexPath];
    }
    else{
        [cell.leftbutton setImage:[UIImage imageNamed:select_image_act]forState:UIControlStateSelected];
        [cell.leftbutton setSelected:YES];
            [self.selectedArray addObject:indexPath];
       
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


#pragma mark- seperateAllLanguages
-(void)seperateAllLanguages{
    self.names=[[NSMutableArray alloc]init];
   langName=[[SingletonClass shareSingleton].languages componentsSeparatedByString:@","];
    for (int i=0;i<langName.count;  i++) {
        NSString * lang=[NSString stringWithString:[langName objectAtIndex:i]];
        lang =[lang stringByReplacingOccurrencesOfString:@"," withString:@""];
        [self.names addObject:lang];
       
       
    }
}

#pragma mark- cancelButtonAction

-(void)cancelButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
   // [[[[[UIApplication sharedApplication]keyWindow]subviews]lastObject]removeFromSuperview];
}

-(void)langaugseSaveButtonAction:(id)sender{
    language=[[NSMutableString alloc]init];
    for (int i=0; i<self.selectedArray.count; i++)
    {
        NSIndexPath * indexPath=[self.selectedArray objectAtIndex:i];
        if(i==0)
        {
           [language appendString:[NSString stringWithString:[languageArray objectAtIndex:indexPath.row]]];
        }
         else
         {
             [language appendFormat:[NSString stringWithFormat:@",%@",[languageArray objectAtIndex:indexPath.row]]];
         }
    }
    
    [SingletonClass shareSingleton].languages=[NSString stringWithString:language];
    
    NSError * error=nil;
    NSURLResponse * urlResponse=nil;
    
    /*NSString * urlStr=[NSString stringWithFormat:@"http://taka.dating/languages-update/mobile/%@/%@",[SingletonClass shareSingleton].userID,language];
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];*/
    
    NSString * postUrl=@"http://23.238.24.26/mobi/languages-update";
    
    NSURL * url=[NSURL URLWithString:postUrl];
    
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50];
    
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    NSString * body=[NSString stringWithFormat:@"userId=%@&languages=%@",[SingletonClass shareSingleton].userID,language];
    [request setHTTPBody:[body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    if (data==nil) {
        NSLog(@"Data is not available");
        return;
    }
    
    id parse=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if ([[parse objectForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        NSLog(@"Successfull");
    }
    else{
        NSLog(@"Unsuccessfull");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
