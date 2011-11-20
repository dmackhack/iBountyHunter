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
#import "DetailViewController.h"

@interface FugitiveListViewController : UITableViewController <NSFetchedResultsControllerDelegate> 
{
    
    //NSMutableArray* fugitives_;
    NSFetchedResultsController* resultsController_;
    BOOL captured_;
    NSString* cache_;
}

@property (nonatomic, readonly) NSFetchedResultsController* resultsController;
@property BOOL captured;
@property (nonatomic, retain) NSString* cache;

@end
