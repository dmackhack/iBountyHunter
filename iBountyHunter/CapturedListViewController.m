//
//  CapturedListViewController.m
//  iBountyHunter
//
//  Created by David Mackenzie on 16/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CapturedListViewController.h"


@implementation CapturedListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.captured = YES;
    self.cache = @"captured_list2.cache";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

@end
