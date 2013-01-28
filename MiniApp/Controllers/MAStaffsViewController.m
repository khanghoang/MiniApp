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

@interface MAStaffsViewController () <StaffsTableViewCell>

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
    [self getStaffList];
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
                             
                             //do something when success
                             //         NSLog(@"%@", [JSON description]);
                             
                             NSArray* temp = (NSArray*) JSON;
                             
                             self.listStaffs = [NSMutableArray array];
                             // Clear all for refresh
                             [self.listStaffs removeAllObjects];
                             
                             [temp enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                 //for each element;
                                 [self.listStaffs addObject:[MAPerson initWithDictionary:obj]];
                             }];
                             
                             //refresh table
                             /* Animate the table view reload */
                             [UIView transitionWithView: self.tableView
                                               duration: 0.35f
                                                options: UIViewAnimationOptionTransitionCrossDissolve
                                             animations: ^(void)
                                                          {
                                                              [self.tableView reloadData];
                                                          }
                                             completion: ^(BOOL isFinished){}
                              ];
                             
                         }
                         failure:^(NSError *error) {
                             //do something
                             //             NSLog(@"%@", @"Connection Error");
                             UIAlertView* errorConnection = [[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Connect and try again :)" delegate:nil cancelButtonTitle:@"Okie" otherButtonTitles:nil];
                             
                             [errorConnection show];
                         }];
}

- (void)pullToRefresh
{
    __weak MAStaffsViewController *weakSelf = self;
    
    // setup pull-to-refresh
    [self.tableView addPullToRefreshWithActionHandler:^{
        dispatch_queue_t downloadQueue = dispatch_queue_create("refresh", NULL);
        dispatch_async(downloadQueue, ^(void){
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView beginUpdates];
                
                //get data
                [AMDownloader getDataFromURL:STAFF_DETAILS_URL
                                     success:^(id JSON) {
                                         
                                         self.listStaffs = [NSMutableArray array];
                                         // Clear all for refresh
                                         [self.listStaffs removeAllObjects];
                                         
                                         //do something when success
                                         NSArray* temp = (NSArray*) JSON;
                                         
                                         
                                         [temp enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                             //for each element;
                                             [self.listStaffs addObject:[MAPerson initWithDictionary:obj]];
                                         }];
                                         
                                         //refresh table
                                         [self.tableView reloadData];
                                         
                                         //end loading status
                                         [weakSelf.tableView.pullToRefreshView stopAnimating];
                                         
                                     }
                                     failure:^(NSError *error) {
                                         //do something
                                         //                         NSLog(@"%@", @"Connection Error");
                                         UIAlertView* errorConnection = [[UIAlertView alloc]initWithTitle:@"Connection Error" message:@"Connect and try again :)" delegate:nil cancelButtonTitle:@"Okie" otherButtonTitles:nil];
                                         
                                         [errorConnection show];
                                     }];
                
                
                [weakSelf.tableView endUpdates];
                
            });
            
        });
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
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithRed:(CGFloat)1 green:(CGFloat)0.5 blue:(CGFloat)0.2 alpha:(CGFloat)0.1];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MAStaffsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(!cell)
        cell = [[MAStaffsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    cell.delegate = self;
    
    return [cell initStaffTableViewCellWith:[self.listStaffs objectAtIndex:indexPath.row]];
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
        [self increaseHitOf:[[self.listStaffs objectAtIndex:[self.tableView indexPathForSelectedRow].row] name]];
//        NSLog(@"Most famous = %@", [self getNumberOfTheMostFamous]);
        
        [segue.destinationViewController setPerson:[self.listStaffs objectAtIndex:[self.tableView indexPathForSelectedRow].row]];
        
        [self.tableView reloadData];
    }
}

- (MAPerson*)getStaffAtIndex:(NSIndexPath *)index
{
    return (MAPerson*)[self.listStaffs objectAtIndex:index.row];
}

@end
