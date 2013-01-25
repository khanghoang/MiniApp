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
#import "MACustomNavigationBar.h"
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>

@interface MAStaffDetailsViewController () <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

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
    // Return the number of rows in the sec®tion.
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MAStaffDetailsCell *cell;
    
    switch (indexPath.row) {
        case 0:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"Name" forIndexPath:indexPath];
                if (self.person.imageUrl) {
                    [cell.rightImage setImageWithURL:[NSURL URLWithString:self.person.imageUrl] placeholderImage:([UIImage imageNamed:@"images 2.jpeg"])];
                }else{
                    UIImage *image = [UIImage imageNamed:@"images 2.jpeg"];
                    [cell.rightImage setImage:image];
                }
                
                cell.rightImage.layer.cornerRadius = cell.rightImage.frame.size.width / 2;
                cell.rightImage.clipsToBounds = YES;
                cell.leftDetail.text = self.person.role;
            }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Mail" forIndexPath:indexPath];
            cell.leftDetail.text = self.person.mail;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnMail:)];
            [cell.leftDetail addGestureRecognizer:tapGesture];
        }
            break;
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"SMS" forIndexPath:indexPath];
            cell.leftDetail.text = self.person.phone;
        }
            break;
        case 3:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Like" forIndexPath:indexPath];
            cell.leftDetail.text = self.person.like;
            cell.leftDetail.numberOfLines = 0;
            [cell.leftDetail sizeToFit];
            
        }
        case 4:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Dislike" forIndexPath:indexPath];
            cell.leftDetail.text = self.person.dislike;
            
        }
            break;
        default:
            break;
    }
    
    if(!cell.leftDetail.text)
        cell.hidden = YES;
    
    cell.leftDetail.numberOfLines = 0;
    [cell.leftDetail sizeToFit];
    
    
    // Configure the cell...
    
    return cell;
}

-(void)tapOnMail:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        [mailer setSubject: [NSString stringWithFormat:@"Say something to %@", self.person.name]];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:self.person.mail ,nil];
        [mailer setToRecipients:toRecipients];
        
        // Add attach files
//        UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
//        NSData *imageData = UIImagePNGRepresentation(myImage);
//        [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
        
        NSString *emailBody = @"Say blah blah";
        [mailer setMessageBody:emailBody isHTML:NO];
        
        mailer.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:(UIViewController *)mailer animated:YES completion:nil];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
}

// When Cancel or something
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:NO completion:nil];
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellText = @"";
    switch (indexPath.row) {
        case 0:
            {
                cellText = self.person.role;
            }
            break;
        case 1:
            {
                cellText = self.person.mail;
            }
            break;
        case 2:
            {
                cellText = self.person.phone;
            }
            break;
        case 3:
            {
                cellText = self.person.like;
            }
        case 4:
            {
                cellText = self.person.dislike;
            }
            break;
            
        default:
            break;
    }
    
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica" size:14.0];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:NSLineBreakByCharWrapping];
    
    //if it's the Name and Role
    if (indexPath.row == 0 && labelSize.height < 80) {
        return 80;
    }
    
    if( !cellText )
        return 0;
    
    return labelSize.height + 20;
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
