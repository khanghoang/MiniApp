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

@interface MAStaffsViewController ()

@end

@implementation MAStaffsViewController

-(NSMutableArray*)listStaffs
{
    if(!_listStaffs)
        _listStaffs = [[NSMutableArray alloc]init];
    return _listStaffs;
}

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //get data
    [AMDownloader getDataFromURL:STAFF_DETAILS_URL
         success:^(id JSON) {
             
             //do something when success
             //         NSLog(@"%@", [JSON description]);
             
             NSArray* temp = (NSArray*) JSON;
             
             [temp enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                 //for each element;
                 [self.listStaffs addObject:[MAPerson initWithDictionary:obj]];
                 //             NSLog(@"%@", [[MAPerson initWithDictionary:obj] name]);
             }];
             
             //refresh table
             [self.tableView reloadData];
             
         }
         failure:^(NSError *error) {
             //do something
             NSLog(@"%@", @"Connection Error");
         }];
    
    
    __weak MAStaffsViewController *weakSelf = self;
    
    // setup pull-to-refresh
    [self.tableView addPullToRefreshWithActionHandler:^{
        
        int64_t delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [weakSelf.tableView beginUpdates];
            
            //get data
            [AMDownloader getDataFromURL:STAFF_DETAILS_URL
                 success:^(id JSON) {
                     
                     //do something when success
                     //         NSLog(@"%@", [JSON description]);
                     
                     NSArray* temp = (NSArray*) JSON;
                     
                     [temp enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                         //for each element;
                         [self.listStaffs addObject:[MAPerson initWithDictionary:obj]];
                         //             NSLog(@"%@", [[MAPerson initWithDictionary:obj] name]);
                     }];
                     
                     //refresh table
                     [self.tableView reloadData];
                     
                 }
                 failure:^(NSError *error) {
                     //do something
                     NSLog(@"%@", @"Connection Error");
                 }];
            
            
            [weakSelf.tableView endUpdates];
            
            [weakSelf.tableView.pullToRefreshView stopAnimating];
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
//        UIView* bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        //        bgview.opaque = YES;
        cell.backgroundColor = [UIColor colorWithRed:(CGFloat)1 green:(CGFloat)0.5 blue:(CGFloat)0.2 alpha:(CGFloat)0.1];
//        [cell setBackgroundView:bgview];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MAStaffsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(!cell)
        cell = [[MAStaffsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell.textName.text = [[self.listStaffs objectAtIndex:indexPath.row] name];
    cell.textName.textColor = [UIColor blackColor];
    cell.textRole.text = [[self.listStaffs objectAtIndex:indexPath.row] role];
    
    cell.starImage.hidden = YES;
    
    if([[self getNumberOfTheMostFamous] integerValue] == [[self getNumberOfName:[[self.listStaffs objectAtIndex:indexPath.row] name]] integerValue])
    {
        NSLog(@"%d", [[self getNumberOfTheMostFamous] integerValue]);
        NSLog(@"%d", [[self getNumberOfName:[[self.listStaffs objectAtIndex:indexPath.row] name]] integerValue]);
        cell.textName.textColor = [UIColor orangeColor];
        
        cell.starImage.hidden = NO;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
    
    NSLog(@"Hit count of %@ = %@", personName, [topHit objectForKey:personName]);
    
    [data synchronize];
    
    [self.tableView reloadData];
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
    [self increaseHitOf:[[self.listStaffs objectAtIndex:[self.tableView indexPathForSelectedRow].row] name]];
    NSLog(@"Most famous = %@", [self getNumberOfTheMostFamous]);
}

@end
