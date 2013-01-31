//
//  MAStaffDetailsController.m
//  MiniApp
//
//  Created by Trieu Khang on 1/29/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import "MAStaffDetailsController.h"
#import "AddressBook/AddressBook.h"
#import "MAPerson.h"
#import "AFNetworking.h"
#import "MACustomNavigationBar.h"
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>
#import <AddressBook/AddressBook.h>

@interface MAStaffDetailsController () <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblRole;
@property (weak, nonatomic) IBOutlet UILabel *lblMail;
@property (weak, nonatomic) IBOutlet UILabel *lblSMS;
@property (weak, nonatomic) IBOutlet UILabel *lblLike;
@property (weak, nonatomic) IBOutlet UILabel *lblDislike;
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;

@property (strong, nonatomic) IBOutlet UIScrollView *staffDetailsScrollView;

@end

@implementation MAStaffDetailsController

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
	// Do any additional setup after loading the view.
    
    [self addLeftAndRightButtonOfNavigation];
    
    [self addContentsAndGesturesToLabels];
    
    [self calculatePositionOfLabels];
    
}

- (void)addLeftAndRightButtonOfNavigation
{
    // Create Back Button
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0,0,44,44);
    [backButton setBackgroundImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(didTapBackBarItem:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    // Create Add Contact Button
    UIButton *addToContactButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addToContactButton.frame = CGRectMake(0, 0, 44, 44);
    [addToContactButton setBackgroundImage:[UIImage imageNamed:@"icon_add_contact.png"] forState:UIControlStateNormal];
    [addToContactButton addTarget:self action:@selector(addedToContact:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addToContactButton];;
}

- (void)addContentsAndGesturesToLabels
{
    [self.imgAvatar setImageWithURL:[NSURL URLWithString:self.person.imageUrl] placeholderImage:[UIImage imageNamed:@"icon_profile.png"]];
    self.imgAvatar.layer.cornerRadius = self.imgAvatar.frame.size.width / 2;
    self.imgAvatar.clipsToBounds = YES;
    self.lblRole.text = self.person.role;
    
    self.lblMail.text = self.person.mail;
    UITapGestureRecognizer* tapForMail = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnMail:)];
    [self.lblMail addGestureRecognizer:tapForMail];
    
    self.lblSMS.text = self.person.phone;
    UITapGestureRecognizer* tapForSMS = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnSMS:)];
    [self.lblSMS addGestureRecognizer:tapForSMS];
    
    self.lblLike.text = self.person.like;
    self.lblDislike.text = self.person.dislike;
}

-(void)calculatePositionOfLabels
{
    __block int originY = 0;
    int padding = 20;
    
    [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([obj isKindOfClass:[UIView class]])
        {
            UIView* viewWrapper = (UIView*)obj;
            
            if( [[viewWrapper subviews]count] > 0 && [[[viewWrapper subviews]objectAtIndex:0] isKindOfClass:[UILabel class]])
            {
                UILabel* labelDetails = [[(UILabel*)viewWrapper subviews]objectAtIndex:0];
                UIImageView* imgLeft = [[(UIImageView*)viewWrapper subviews]objectAtIndex:1];
                
                labelDetails.numberOfLines = 0;
                [labelDetails sizeToFit];
                
                NSString *theText = labelDetails.text;
                CGFloat width = labelDetails.frame.size.width ;
                CGSize theSize = [theText sizeWithFont:labelDetails.font constrainedToSize:CGSizeMake(width,MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                CGRect frame = CGRectMake(viewWrapper.frame.origin.x, originY, viewWrapper.frame.size.width, (theSize.height > 0 ? MAX(theSize.height, imgLeft.frame.size.height) + padding : 0));
                
                viewWrapper.frame = frame;
                
                originY += viewWrapper.frame.size.height;
            }
            
        }
    }];
    
    self.staffDetailsScrollView.contentSize = CGSizeMake(self.staffDetailsScrollView.contentSize.width, originY);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didTapBackBarItem:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString *buttonTilte = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([buttonTilte isEqualToString:@"cancel"] && alertView.tag != 1)
        return;

    ABRecordRef aRecord = ABPersonCreate();
    CFErrorRef  anError = NULL;
    
    ABRecordSetValue(aRecord, kABPersonFirstNameProperty, (__bridge CFTypeRef)(self.person.name), &anError);
    ABRecordSetValue(aRecord, kABPersonLastNameProperty, (__bridge CFTypeRef)(self.person.name), &anError);
    
    // Add mail
    if(self.person.mail)
    {
        ABMutableMultiValueRef multiemail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(multiemail, (__bridge CFStringRef)self.person.mail, kABWorkLabel, NULL);
        ABRecordSetValue(aRecord, kABPersonEmailProperty, multiemail, &anError);
    }
    
    // Add phone
    if(self.person.phone)
    {
        ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(multi, (__bridge CFStringRef)self.person.phone, kABWorkLabel, NULL);
        ABRecordSetValue(aRecord, kABPersonPhoneProperty, multi, &anError);
    }
    
    if (anError != NULL) {
        NSLog(@"error while creating..");
    }
    
    CFStringRef firstName, lastName;
    firstName = ABRecordCopyValue(aRecord, kABPersonFirstNameProperty);
    lastName  = ABRecordCopyValue(aRecord, kABPersonLastNameProperty);
    
    ABAddressBookRef addressBook;
    CFErrorRef error = NULL;
    
    addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    
    ABAddressBookAddRecord (addressBook, aRecord, &error);

    if (error != NULL) {
        NSLog(@"ABAddressBookAddRecord %@", error);
    }
    error = NULL;
    
    ABAddressBookSave (addressBook, &error);
    
    if (error != NULL) {
        NSLog(@"ABAddressBookSave %@", error);
    }
    // Success
    else
    {
        UIAlertView* successAlert = [[UIAlertView alloc] initWithTitle:@"Added !" message:@"Contact added successfully" delegate:nil cancelButtonTitle:@"Okie" otherButtonTitles: nil];
        
        [successAlert show];
    }
    
}

-(void)addedToContact:(id)person
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are you sure ?"
                                                    message:[NSString stringWithFormat: @"Are you sure to add %@ to Address Book.", self.person.name]
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Ok", nil];
    alert.tag = 1;
    [alert show];
    
}

// Action when User tap on SMS
-(void)tapOnSMS:(id)sender
{
    NSLog(@"Tap on SMS");
    // Set delegate
    MFMessageComposeViewController* sms = [[MFMessageComposeViewController alloc]init];
    sms.messageComposeDelegate = self;
    
    // If devices can send text
    if([MFMessageComposeViewController canSendText])
    {
        NSLog(@"Devices can send text");
    }
}

// Action when User tap on mail address
-(void)tapOnMail:(id)sender
{
    NSLog(@"Tap on Mail");
    
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
        [self presentViewController:(UIViewController *)mailer animated:YES completion:^(void){
            NSLog(@"Complete mail");
        }];
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
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [controller dismissViewControllerAnimated:YES completion:nil];
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    
}

@end
