//
//  WineListViewController.m
//  Wine
//
//  Created by Vishnu on 11/13/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import "WA_WineListViewController.h"
#import "Utility.h"
#import "Constant.h"
#import "FontUtility.h"

@interface WA_WineListViewController (){
    NSMutableArray *wineListArray;
    
}
@property (nonatomic,retain)IBOutlet UITableView *tblView;
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
    [self.navigationItem setHidesBackButton:YES animated:YES];
    wineListArray = [[NSMutableArray alloc]initWithObjects:@"Red",@"White",@"Bubbly",nil];
   // [_tblView setFrame:CGRectMake(_tblView.frame.origin.x, _tblView.frame.origin.y, _tblView.frame.size.width,(CELL_WHEIGHT*([wineListArray count])))];
    if([Utility currentVersionGreaterOrEqualtoIOS7]){
        [_tblView setSeparatorInset:UIEdgeInsetsZero];
    }
    //_tblView.backgroundColor = UIColorFromRGB(0xD8A848);
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
    cell.textLabel.text = [wineListArray objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"category%ld",indexPath.row+1]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
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
