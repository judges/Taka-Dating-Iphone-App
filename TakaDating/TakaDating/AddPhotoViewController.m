//
//  AddPhotoViewController.m
//  TakaDating
//
//  Created by Sumit Ghosh on 10/11/14.
//  Copyright (c) 2014 Sumit Ghosh. All rights reserved.
//

#import "AddPhotoViewController.h"
#import "SignUpViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SingletonClass.h"

@interface AddPhotoViewController ()
@property(nonatomic,strong)SignUpViewController * signUp;

@end

@implementation AddPhotoViewController

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
    
    self.view.backgroundColor = [UIColor colorWithRed:(CGFloat)251/255 green:(CGFloat)177/255 blue:(CGFloat)176/255 alpha:1.0];
    
    CAGradientLayer * layer=[[CAGradientLayer alloc]init];
    layer.frame=CGRectMake(0, 0, self.view.frame.size.width, 55);
    UIColor * firstColor=[UIColor colorWithRed:(CGFloat)207/255 green:(CGFloat)42/255 blue:(CGFloat)43/255 alpha:1.0];
    UIColor  * secondColor= [UIColor colorWithRed:121.0/255.0 green:2.0/255.0 blue:(CGFloat)0.0/255.0 alpha:1.0];
    layer.colors=[NSArray arrayWithObjects:(id)[firstColor CGColor ] ,(id)[secondColor CGColor] , nil];
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(110, 20, self.view.frame.size.width, 30)];
    [self.titleLabel setText:@"Add Photos"];
    self.titleLabel.font=[UIFont boldSystemFontOfSize:20];
    self.titleLabel.textColor=[UIColor whiteColor];
    [self.view addSubview:self.titleLabel];
    
    self.cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelButton.frame=CGRectMake(15, 25, 65, 25);
    self.cancelButton.layer.borderWidth=0.7;
    self.cancelButton.layer.borderColor=[[UIColor redColor]CGColor];
    self.cancelButton.clipsToBounds=YES;
    self.cancelButton.layer.cornerRadius=4;
    self.cancelButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
    
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)createUI{
    

    
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(25, 100, 110, 110)];
    self.imageView.backgroundColor=[UIColor whiteColor];
    self.imageView.layer.borderWidth=0.7;
    self.imageView.layer.cornerRadius=4;
    self.imageView.clipsToBounds=YES;
    self.imageView.image=[UIImage imageNamed:@"profile_female.png"];
    self.imageView.layer.borderColor=[[UIColor whiteColor]CGColor];
    [self.view addSubview:self.imageView];
    
    if ([self.signUp.radioButtonGirl isSelected]==YES) {
        self.imageView.image=[UIImage imageNamed:@"profile_female.png"];
    }
    else{
        self.imageView.image=[UIImage imageNamed:@"profile_male.png"];
    }
    
    UILabel * bottomLabel=[[UILabel alloc]initWithFrame:CGRectMake(50,self.view.frame.size.height-170 , self.view.frame.size.width-85,  60)];
    bottomLabel.text=@"'Photo of you' must have only you in them,identify you easily and show your face clearly. Please respect our rules. Note that all photos are moderated.";
    bottomLabel.lineBreakMode=NSLineBreakByWordWrapping;
    bottomLabel.numberOfLines=0;
    bottomLabel.font=[UIFont systemFontOfSize:11];
    [self.view addSubview: bottomLabel];
    
    UILabel * topLabel=[[UILabel alloc]initWithFrame:CGRectMake(160, 130, 150, 50)];
    topLabel.text=@"Please add a photo of yourself to play Encounters-others wants to see you!";
    topLabel.lineBreakMode=NSLineBreakByWordWrapping;
    topLabel.numberOfLines=0;
    topLabel.font=[UIFont systemFontOfSize:11];
    [self.view addSubview:topLabel];
    
    //Adding  image selection View
    
    UIView * imageSelectionView=[[UIView alloc]initWithFrame:CGRectMake(25, 240, 282, 136)];
    imageSelectionView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"add_photo_option_bg.png"]];
    [self.view addSubview:imageSelectionView];
    
    UIButton * facebookBtn=[[UIButton alloc]initWithFrame:CGRectMake(15, 7, 180, 25)];
    [facebookBtn setTitle:@"Add from Facebook" forState:UIControlStateNormal];
    facebookBtn.titleLabel.font =[UIFont systemFontOfSize:12];
    [facebookBtn setTitleColor:[UIColor colorWithRed:65.0/255.0 green:63.0/255.0 blue:64.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [facebookBtn addTarget:self action:@selector(fetchPhotoFromFacebook) forControlEvents:UIControlEventTouchDragInside];
    [imageSelectionView addSubview:facebookBtn];
    
    UIButton * instagramBtn=[[UIButton alloc]initWithFrame:CGRectMake(15, 40, 180, 25)];
    [instagramBtn setTitle:@"Add from Instagram" forState:UIControlStateNormal];
    instagramBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [instagramBtn setTitleColor:[UIColor colorWithRed:65.0/255.0 green:63.0/255.0 blue:64.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [imageSelectionView addSubview:instagramBtn];
    
    UIButton * libraryPhotoBtn=[[UIButton alloc]initWithFrame:CGRectMake(15, 70, 200, 25)];
    [libraryPhotoBtn setTitle:@"Add from existing photo" forState:UIControlStateNormal];
    libraryPhotoBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [libraryPhotoBtn setTitleColor:[UIColor colorWithRed:65.0/255.0 green:63.0/255.0 blue:64.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [libraryPhotoBtn addTarget:self action:@selector(addingPhotofromLibrary:) forControlEvents:UIControlEventTouchUpInside];
    [imageSelectionView addSubview:libraryPhotoBtn];
    
    UIButton * newphotoBtn=[[UIButton alloc]initWithFrame:CGRectMake(15, 105, 160, 25)];
    [newphotoBtn setTitle:@"Take a new photo" forState:UIControlStateNormal];
    newphotoBtn.titleLabel.textAlignment=NSTextAlignmentLeft;
    newphotoBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [newphotoBtn setTitleColor:[UIColor colorWithRed:65.0/255.0 green:63.0/255.0 blue:64.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [newphotoBtn addTarget:self action:@selector(takePhotoFromCamera:) forControlEvents:UIControlEventTouchUpInside];
    [imageSelectionView addSubview:newphotoBtn];
    
    UIImageView * facebookImgView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 25, 25)];
    facebookImgView.image=[UIImage imageNamed:@"fb_icon.png"];
    [imageSelectionView addSubview:facebookImgView];
    
    UIImageView * instagramImgView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 40, 25, 25)];
    instagramImgView.image=[UIImage imageNamed:@"instagram_icon.png"];
    [imageSelectionView addSubview:instagramImgView];
    
    
    UIImageView * libraryPhotoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 70, 25, 25)];
    libraryPhotoImageView.image=[UIImage imageNamed:@"gallery_icon.png"];
    [imageSelectionView addSubview:libraryPhotoImageView];
    
    UIImageView * newphotoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 105, 25, 25)];
    newphotoImageView.image=[UIImage imageNamed:@"camera_icon.png"];
    [imageSelectionView addSubview:newphotoImageView];

}

-(void)addingPhotofromLibrary:(id)sender{
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

-(void)takePhotoFromCamera:(id)sender{
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

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage * chosenImage=info[UIImagePickerControllerEditedImage];
    self.imageView.image=chosenImage;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)cancelButtonAction:(id)sender{
    //self.imageView.image=nil;
   // self.imageView.image=[UIImage imageNamed:@"profile_female.png"];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
