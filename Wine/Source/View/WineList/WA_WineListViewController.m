//
//  WineListViewController.m
//  Wine
//
//  Created by Vishnu on 11/13/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import "WA_WineListViewController.h"
#import "WA_WinedetailsViewController.h"
#import "Utility.h"
#import "Constant.h"
#import "WineRepository.h"
#import "FontUtility.h"
#import "WineListDTO.h"

@interface WA_WineListViewController (){
    NSMutableArray *wineListArray;
    
}
@property (nonatomic,retain)IBOutlet UITableView *tblView;
@property (nonatomic,retain)IBOutlet UILabel *noWineLabel;
@end

@implementation WA_WineListViewController

#define CELL_WHEIGHT 80

#pragma mark - ViewCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self arrangePage];
    // Do any additional setup after loading the view.
}


#pragma mark - Custome Methods
-(void)arrangePage{
    self.title = @"Wine list";
    [self showNavBar:YES];
    _tblView.hidden = YES;
    _noWineLabel.hidden = YES;
    [self.navigationItem setHidesBackButton:YES animated:YES];
   // wineListArray = [[NSMutableArray alloc]initWithObjects:@"Red",@"White",@"Bubbly",nil];
   [self showSignOutButton];
   // [_tblView setFrame:CGRectMake(_tblView.frame.origin.x, _tblView.frame.origin.y, _tblView.frame.size.width,(CELL_WHEIGHT*([wineListArray count])))];
    if([Utility currentVersionGreaterOrEqualtoIOS7]){
        [_tblView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if([Utility checkForInternetConnection]){
        [self showProgressIndicator:@"Loading..."];
        WineRepository *wineRepo = [[WineRepository alloc]init];
        [wineRepo getWineStatusWithResponseBlock:^(NSMutableArray *wineDetailsArray,WineStatus wineStatus){
         [self hideModalProgressIndicator];
            switch (wineStatus) {
                case wineStatus_Success:
                    wineListArray = wineDetailsArray;
                    _tblView.hidden = NO;
                    _noWineLabel.hidden = YES;
                    [_tblView reloadData];
                    break;
                case wineStatus_Error:
                    _tblView.hidden = NO;
                    _noWineLabel.hidden = YES;
                    [self showAlertWithTitle:@"Whoops!" message:@"Unspecified error occured,please try again later!"];
                    break;
                 case wineStatus_NoWineExists:
                    _tblView.hidden = YES;
                    _noWineLabel.hidden = NO;
                    [self showAlertWithTitle:@"Whoops!" message:@"Unspecified error occured,please try again later!"];break;
                default:
                    break;
            }
            
        }];
    }
    else{
        [self showAlertWithTitle:@"Whoops!" message:@"Please check your internt connection"];
        return;
    }
}

-(void)navigateToWineDetailsViewWith:(WineListDTO *)wineListDto {
    
    WA_WinedetailsViewController *wineDetailsView = (WA_WinedetailsViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"WA_WinedetailsViewController"];
    wineDetailsView.wineListDTO = wineListDto;
  [self.navigationController pushViewController:wineDetailsView animated:YES];
    
}
#pragma mark - UitableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_WHEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [wineListArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.backgroundColor = UIColorFromRGB(0xD8A848);
    cell.textLabel.font = [FontUtility fontForFontTypeEnum:FMediumLightCopy];
    WineListDTO *wineListDTO = [wineListArray objectAtIndex:indexPath.row];
    cell.textLabel.text = wineListDTO.winename;
    if(wineListDTO.wineThumbImage == nil)
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"category%ld",indexPath.row+1]];
    else
        cell.imageView.image = [UIImage imageWithData:wineListDTO.wineThumbImage];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    [self navigateToWineDetailsViewWith:[wineListArray objectAtIndex:indexPath.row]];
    
}


#pragma mark -Memory Warning
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
