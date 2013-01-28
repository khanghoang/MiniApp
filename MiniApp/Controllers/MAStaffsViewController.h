//
//  MAStaffsViewController.h
//  MiniApp
//
//  Created by Trieu Khang on 1/21/13.
//  Copyright (c) 2013 Hoang Trieu Khang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAStaffsViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray* listStaffs;

@end
