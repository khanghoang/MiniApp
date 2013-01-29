    //
//  MAStaffsViewController.m
//  MiniApp
//
//  Created by Trieu Khang on 1/21/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import "MAStaffsViewController.h"
#import "AMDownloader.h"
#import "MAPerson.h"
#import "MAStaffsTableViewCell.h"
#import "SVPullToRefresh.h"
#import "MAStaffDetailsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIScrollView+SVPullToRefresh.h"

@interface MAStaffsViewController () <StaffsTableViewCell>

@property (strong, nonatomic) IBOutlet UITableView *staffsTableView;

@property (strong, nonatomic) NSMutableArray* listStaffs;

@end

@implementation MAStaffsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self displayStaffList];
}

- (void)displayStaffList
{
    [self getStaffList];
    [self pullToRefresh];
}
- (void)getStaffList
{
    //get data
    [AMDownloader getDataFromURL:STAFF_DETAILS_URL
                         success:^(id JSON) {
                             NSArray* temp = (NSArray*) JSON;
                             
                             self.listStaffs = [NSMutableArray array];
                             [self.listStaffs removeAllObjects];
                             
                             [temp enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                 [self.listStaffs addObject:[MAPerson initWithDictionary:obj]];
                             }];
                             
                             //refresh table
                             [UIView transitionWithView: self.staffsTableView
                                               duration: 0.35f
                                                options: UIViewAnimationOptionTransitionCrossDissolve
                                             animations: ^(void)
                                                          {
                                                              [self.staffsTableView reloadData];
                                                              [self.staffsTableView.pullToRefreshView stopAnimating];
                                                          }
                                             completion: ^(BOOL isFinished){}
                              ];
                             
                         }
                         failure:^(NSError *error) {
                             UIAlertView* errorConnection = [[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Connect and try again :)" delegate:nil cancelButtonTitle:@"Okie" otherButtonTitles:nil];
                             
                             [errorConnection show];
                         }];
}

- (void)pullToRefresh
{
    __weak MAStaffsViewController *weakSelf = self;
    
    // setup pull-to-refresh
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf.staffsTableView beginUpdates];
        [weakSelf getStaffList];
        [weakSelf.staffsTableView endUpdates];
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.listStaffs.count;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //change background color
//    if (indexPath.row % 2 == 0) {
//        cell.backgroundColor = [UIColor colorWithRed:(CGFloat)1 green:(CGFloat)0.5 blue:(CGFloat)0.2 alpha:(CGFloat)0.1];
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MAStaffsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(!cell)
        cell = [[MAStaffsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    cell.delegate = self;
    
    return [cell initStaffTableViewCellWith:[self.listStaffs objectAtIndex:indexPath.row] isOdd:(indexPath.row % 2 == 0 ? YES : NO)];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)increaseHitOf:(NSString*)personName
{
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    
    NSData *temp = [data objectForKey:@"Top Hit"];
    
    //unarchived
    NSMutableDictionary *topHit = [NSKeyedUnarchiver unarchiveObjectWithData:temp];
    
    //get hit value for person
    NSNumber *i = [topHit valueForKey:personName];
    
    //set hit value for person
    [topHit setValue:[NSString stringWithFormat:@"%g", [i doubleValue] + 1] forKey:personName];
    
    //archived
    NSData *archived = [NSKeyedArchiver archivedDataWithRootObject:topHit];
    
    //set back to data
    [data setObject:archived forKey:@"Top Hit"];
    
//    NSLog(@"Hit count of %@ = %@", personName, [topHit objectForKey:personName]);
    
    [data synchronize];
    
//    [self.tableView reloadData];
}

- (NSNumber*)getNumberOfTheMostFamous
{
    
    NSNumber* top = 0;
    
    __block int intTop = [top integerValue];
    
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    
    NSData *temp = [data objectForKey:@"Top Hit"];
    
    //unarchived
    NSMutableDictionary *topHit = [NSKeyedUnarchiver unarchiveObjectWithData:temp];
    
    [topHit enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if([obj integerValue] > intTop)
            intTop = [obj integerValue];
    }];
    
    return [NSNumber numberWithInt:intTop];
}

- (NSNumber*)getNumberOfName:(NSString*)name
{
    NSUserDefaults *data = [NSUserDefaults standardUserDefaults];
    
    NSData *temp = [data objectForKey:@"Top Hit"];
    
    //unarchived
    NSMutableDictionary *topHit = [NSKeyedUnarchiver unarchiveObjectWithData:temp];
    
    //get hit value for person
    return [topHit valueForKey:name];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Show staff details"])
    {
        [self increaseHitOf:[[self.listStaffs objectAtIndex:[self.staffsTableView indexPathForSelectedRow].row] name]];
//        NSLog(@"Most famous = %@", [self getNumberOfTheMostFamous]);
        
        [segue.destinationViewController setPerson:[self.listStaffs objectAtIndex:[self.tableView indexPathForSelectedRow].row]];
        
        [self.staffsTableView reloadData];
    }
}

- (MAPerson*)getStaffAtIndex:(NSIndexPath *)index
{
    return (MAPerson*)[self.listStaffs objectAtIndex:index.row];
}

@end
