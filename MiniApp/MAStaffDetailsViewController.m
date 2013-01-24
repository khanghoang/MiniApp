//
//  MAStaffDetailsViewController.m
//  MiniApp
//
//  Created by Trieu Khang on 1/23/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import "MAStaffDetailsViewController.h"
#import "AddressBook/AddressBook.h"
#import "MAPerson.h"
#import "MAStaffDetailsCell.h"
#import "AFNetworking.h"
#import <QuartzCore/QuartzCore.h>

@interface MAStaffDetailsViewController ()

@end

@implementation MAStaffDetailsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didTapBackBarItem:(id)sender {
    if(self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Create Back Button
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0,0,44,44); // width=44, height=44
    
    // Set Button Image
    UIImage *backButtonImage = [UIImage imageNamed:@"icon_back.png"];
    [backButton setBackgroundImage:backButtonImage forState:UIControlStateNormal];
    
    // Important: Set Button Action to go back
    [backButton addTarget:self action:@selector(didTapBackBarItem:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem = backBarButtonItem;

    // Create Add Contact Button
    UIButton *addToContactButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addToContactButton.frame = CGRectMake(0, 0, 44, 44);
    
    UIImage *addToContactButtonImage = [UIImage imageNamed:@"icon_add_contact.png"];
    [addToContactButton setBackgroundImage:addToContactButtonImage forState:UIControlStateNormal];
    
    [addToContactButton addTarget:self action:@selector(addedToContact:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addToContactBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addToContactButton];
    
    self.navigationItem.rightBarButtonItem = addToContactBarButtonItem;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete@ method implementation.
    // Return the number of sections.
    return 1;
}

-(void)addedToContact:(id)person
{
    if ([self.person isKindOfClass:[MAPerson class]]) {
        // Do add to address book here
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
//    return [[self.person getPropertiesFromPerson]count];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MAStaffDetailsCell *cell;
    
    switch (indexPath.row) {
        case 0:
            {
            // Is name
                cell = [tableView dequeueReusableCellWithIdentifier:@"Name" forIndexPath:indexPath];
                [cell.rightImage setImageWithURL:[NSURL URLWithString:self.person.imageUrl] placeholderImage:@"image 2.jpeg"];
                
                cell.rightImage.layer.cornerRadius = cell.rightImage.frame.size.width / 2;
                cell.rightImage.clipsToBounds = YES;
                
                cell.leftDetail.text = self.person.role;
                cell.leftDetail.numberOfLines = 0;                
            }
            break;
        default:
            break;
    }
    
    
    // Configure the cell...
    
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

@end
