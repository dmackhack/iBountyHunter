//
//  FugitiveListViewController.h
//  iBountyHunter
//
//  Created by David Mackenzie on 16/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iBountyHunterAppDelegate.h"
#import "Fugitive.h"

@interface FugitiveListViewController : UITableViewController {
    
    NSMutableArray* fugitives_;
}

@property (nonatomic, retain) NSMutableArray* fugitives;

@end
