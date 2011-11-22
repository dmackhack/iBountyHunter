//
//  FugitiveDossierViewController.h
//  iBountyHunter
//
//  Created by David Mackenzie on 23/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FugitiveDossierViewController : UIViewController <UISplitViewControllerDelegate>
{
    UILabel* testLabel_;
    
}


@property (nonatomic, retain) IBOutlet UILabel* testLabel;

- (void) updateDossier;

@end
