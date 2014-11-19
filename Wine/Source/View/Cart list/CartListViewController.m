//
//  CartListViewController.m
//  Wine
//
//  Created by experion on 17/11/14.
//  Copyright (c) 2014 Wine. All rights reserved.
//

#import "CartListViewController.h"
#import "WA_WineListViewController.h"
#import "CartListTableViewCell.h"
#import "UserCartDTO.h"
#import "UserCart.h"
#import  "WineRepository.h"

@interface CartListViewController (){
    
}

@property (nonatomic,retain)IBOutlet UITableView *cartItemsTableview;
@property (nonatomic,retain)IBOutlet UILabel *noItemsLabel;
@property (nonatomic,retain)IBOutlet UILabel *totalPrice;
@property (nonatomic,retain)NSMutableArray *cartArray;
@end

#define CELL_HEIGHT 100



@implementation CartListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
     
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [self arrangePage];
}

-(void)arrangePage{
     self.title = @"Cart";
    UserCart *userCartRepo = [[UserCart alloc]init];
    self.cartArray = [userCartRepo fetchCartValuesFromTable];
    [self arrangetblView];
    [self addHomeButton];
}
- (void)addHomeButton{
    
    UIImage *homeImage = [UIImage imageNamed:@"home_yellow.png"];
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeButton addTarget:self action:@selector(homeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [homeButton setImage:homeImage forState:UIControlStateNormal];
    homeButton.frame = CGRectMake(200.0, 0.0, 30, 30);
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:homeButton];
    self.navigationItem.leftBarButtonItem = customBarItem;
    
}
-(void)removefromCart:(UserCartDTO *)userDto{
    
    UserCart *cartRepo = [[UserCart alloc]init];
    [cartRepo deleteAnItemfromCart:userDto];
    [self arrangetblView];
}
-(void)arrangetblView{
    self.cartItemsTableview.frame = CGRectMake(self.cartItemsTableview.frame.origin.x, self.cartItemsTableview.frame.origin.y, self.cartItemsTableview.frame.size.width, self.cartArray.count*CELL_HEIGHT);
    if(self.cartArray.count > 0){
        self.noItemsLabel.hidden = YES;
        self.cartItemsTableview.hidden = NO;
        [self.cartItemsTableview reloadData];
    }
    else{
        self.noItemsLabel.hidden = NO;
        self.cartItemsTableview.hidden = YES;
    }
    [self calculateTotalprice];
}

-(void)calculateTotalprice{
    int totalPrice = 0;
    for (UserCartDTO *cartDto in self.cartArray) {
        totalPrice = totalPrice + ([cartDto.unitPrice intValue]*[cartDto.quantity intValue]);
    }
    self.totalPrice.text = [NSString stringWithFormat:@"Total price: $ %d",totalPrice];
}
#pragma mark - button Actions
- (void)backButtonClicked :(id)sender{
    WineRepository *wineRepo = [[WineRepository alloc]init];
    for (UserCartDTO *userCartDto in self.cartArray) {
        [wineRepo getRemainingWineQuantityFromServer:userCartDto.wineId andQuantity:userCartDto.quantity isSubstract:NO WithResponseBlock:^(WineStatus wineStatus){
            if (wineStatus == wineStatus_Success) {
                //[self navigateToCartpage];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }];
    }
    
}

- (void)homeButtonClicked :(id)sender{

    WA_WineListViewController *wineListView = (WA_WineListViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"WA_WineListViewController"];
    [self.navigationController pushViewController:wineListView animated:YES];
}
#pragma mark - UItableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cartArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      NSString *MyIdentifier = @"CartListTableViewCell";
      CartListTableViewCell *cell = (CartListTableViewCell *)[tableView dequeueReusableCellWithIdentifier: MyIdentifier];
        if(cell == nil)
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CartListTableViewCell"
                                                                     owner:self
                                                                   options:nil];
            for (id currentObject in topLevelObjects)
            {
                if ([currentObject isKindOfClass:[UITableViewCell class]])
                {
                    cell =  (CartListTableViewCell *) currentObject;
                    break;
                }
            }
        
        }
    UserCartDTO *cartDto = [self.cartArray objectAtIndex:indexPath.row];
    cell.wineImageView.image = [UIImage imageWithData:cartDto.thumbImage];
    cell.wineName.text       = cartDto.name;
    cell.winePrice.text      = [NSString stringWithFormat:@"$ %@",[cartDto.unitPrice stringValue]];
    cell.wineQty.text        = [cartDto.quantity stringValue];
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [tableView deleteRowsAtIndexPaths: @[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
        UserCartDTO *userDTO = [self.cartArray objectAtIndex:indexPath.row];
        [self.cartArray objectAtIndex:indexPath.row];
        [self removefromCart:userDTO];
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
