//
//  WA_WinedetailsViewController.m
//  Wine
//
//  Created by experion on 17/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import "WA_WinedetailsViewController.h"
#import "UserCartDTO.h"
#import "UserCart.h"
#import "Utility.h"
#import "Constant.h"

@interface WA_WinedetailsViewController () {
    UIView *quantityListBackgroundView;
    NSMutableArray *quantityArray;
}

@property (nonatomic,retain)IBOutlet UILabel *titleLabel;
@property (nonatomic,retain)IBOutlet UILabel *nameHeaderLabel;
@property (nonatomic,retain)IBOutlet UILabel *scoreHeaderLabel;
@property (nonatomic,retain)IBOutlet UILabel *tastePaleteHeaderLabel;
@property (nonatomic,retain)IBOutlet UILabel *whyYouLikeHeaderLabel;
@property (nonatomic,retain)IBOutlet UILabel *nameLabel;
@property (nonatomic,retain)IBOutlet UILabel *scoreLabel;
@property (nonatomic,retain)IBOutlet UILabel *tastePaleteLabel;
@property (nonatomic,retain)IBOutlet UILabel *whyYouLikeLabel;
@property (nonatomic,retain)IBOutlet UIImageView *wineDetailImageView;
@property (nonatomic,retain)IBOutlet UITextField *quantityTextField;
@property (nonatomic,retain)IBOutlet UILabel *quantityHeaderLabel;
@property (nonatomic,retain)UIPickerView *quantityPickerView;
@property(nonatomic,retain)UIActionSheet *pickerViewPopup;

@end

@implementation WA_WinedetailsViewController

@synthesize  wineListDTO;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self arrangeWineDetailsPage];
}

-(void)arrangeWineDetailsPage {
    
    self.title = @"Wine details";
    [self showNavBar:YES];
    [self.navigationItem setHidesBackButton:NO animated:YES];
    self.titleLabel.text = self.wineListDTO.winename;
    self.wineDetailImageView.contentMode = UIViewContentModeScaleAspectFill;
    if(self.wineListDTO.wineDetailImage == nil){
     self.wineDetailImageView.image = [UIImage imageNamed:@"DefaultImage"];
    }
    else{
        self.wineDetailImageView.image = [UIImage imageWithData:wineListDTO.wineDetailImage];
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%i",self.wineListDTO.score];
    self.whyYouLikeLabel.text  = self.wineListDTO.wineDescription;
    self.tastePaleteLabel.text = self.wineListDTO.tastePalate;
    [self showAddCartButton];
    [self setQuantityArray];
}

-(void)setQuantityArray {
    if(self.wineListDTO.wineQtyRemains == 0){
        self.quantityTextField.hidden = YES;
        self.quantityTextField.text = @"No quantity available now!";
    }
    else{
        self.quantityTextField.hidden = NO;
        self.quantityTextField.text = @"Select quantity";
        quantityArray = [[NSMutableArray alloc]init];
         for (int i = 1; i <= self.wineListDTO.wineQtyRemains; i++) {
            [quantityArray addObject:[NSNumber numberWithInt:i]];
         }
    }
}
-(void)showAddCartButton {
    UIImage *cartImage = [UIImage imageNamed:@"cart_image.png"];
    UIButton *addCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addCartButton addTarget:self action:@selector(addCartButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [addCartButton setImage:cartImage forState:UIControlStateNormal];
    addCartButton.frame = CGRectMake(200.0, 0.0, 30, 30);
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:addCartButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}


#pragma mark - Button Actions
-(void)doneButtonPressed:(id)sender{
    
  if ([Utility currentVersionGreaterOrEqualtoIOS8]) {
        [quantityListBackgroundView removeFromSuperview];
    }
    else
        [self.pickerViewPopup dismissWithClickedButtonIndex:1 animated:YES];
    
}

-(void)cancelButtonPressed:(id)sender{
    if ([Utility currentVersionGreaterOrEqualtoIOS8]) {
        [quantityListBackgroundView removeFromSuperview];
    }
    else
        [self.pickerViewPopup dismissWithClickedButtonIndex:1 animated:YES];
}

-(IBAction)addCartButtonClicked:(id)sender {
    UserCart    *userCart = [[UserCart alloc]init];
    UserCartDTO *cartDto  = [[UserCartDTO alloc]init];
    cartDto.quantity      = [NSNumber numberWithInt:[_quantityTextField.text intValue]];
    cartDto.unitPrice     = [NSNumber numberWithInteger:self.wineListDTO.unitPrice];
    cartDto.name          = self.wineListDTO.winename;
    cartDto.thumbImage    = self.wineListDTO.wineThumbImage;
    cartDto.wineDetailsImage = self.wineListDTO.wineDetailImage;
    [userCart saveUserDetails:cartDto];
}

#pragma mark - UItextfield delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)aTextField{
    if(aTextField.tag == 1){
        [self.view endEditing:YES];
        _pickerViewPopup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
        _quantityPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];

        [_quantityPickerView  setBackgroundColor:[UIColor whiteColor]];
        
        _quantityPickerView.hidden = NO;
        UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        pickerToolbar.barStyle = UIBarStyleBlackOpaque;
        [pickerToolbar sizeToFit];
        pickerToolbar.translucent = YES;
        if([Utility currentVersionGreaterOrEqualtoIOS7])
            pickerToolbar.barTintColor = UIColorFromRGB(0xA4D3EE);
        else
            pickerToolbar.tintColor = UIColorFromRGB(0xA4D3EE);
        NSMutableArray *barItems = [[NSMutableArray alloc] init];
        
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [barItems addObject:flexSpace];
        
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
        [barItems addObject:doneBtn];
        
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)];
        [barItems addObject:cancelBtn];
        
        [pickerToolbar setItems:barItems animated:YES];
        _quantityPickerView.delegate = self;
        _quantityPickerView.dataSource = self;
        if ([Utility currentVersionGreaterOrEqualtoIOS8]) {
            quantityListBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height -200, 320, 246)];
            [quantityListBackgroundView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
            
            [quantityListBackgroundView addSubview:pickerToolbar];
            [quantityListBackgroundView addSubview:_quantityPickerView];
            
            [self.view addSubview:quantityListBackgroundView];
        }
        else {
            [_pickerViewPopup addSubview:pickerToolbar];
            [_pickerViewPopup addSubview:_quantityPickerView];
            [_pickerViewPopup showInView:self.view];
            [_pickerViewPopup setBounds:CGRectMake(0,0,self.view.bounds.size.width, self.view.bounds.size.height)];
           // [_pickerViewPopup setBounds:CGRectMake(0,0,320, 464)];
            
        }
    }
    else{
        [aTextField becomeFirstResponder];
    }
}


#pragma mark uipickerview delegates

-(NSString*) pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%i",[[quantityArray objectAtIndex:row] intValue]];
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _quantityTextField.text = [NSString stringWithFormat:@"%i",[[quantityArray objectAtIndex:row] intValue]];
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
return 1;
    
}

- (NSInteger) pickerView:(UIPickerView *)pickerView  numberOfRowsInComponent:(NSInteger)component
{
    return [quantityArray count];
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
