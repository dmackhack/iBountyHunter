//
//  FugitiveListViewController.h
//  iBountyHunter
//
//  Created by David Mackenzie on 16/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FugitiveDossierViewController;

@interface FugitiveListViewController : UITableViewController <NSFetchedResultsControllerDelegate> 
{
    
    //NSMutableArray* fugitives_;
    NSFetchedResultsController* resultsController_;
    BOOL captured_;
    NSString* cache_;
    
    FugitiveDossierViewController* dossierView_;
}

@property (nonatomic, retain) IBOutlet FugitiveDossierViewController* dossierView;
@property (nonatomic, readonly) NSFetchedResultsController* resultsController;
@property BOOL captured;
@property (nonatomic, retain) NSString* cache;

@end
