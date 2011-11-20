//
//  DetailViewController.h
//  iBountyHunter
//
//  Created by David MacKenzie on 19/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Fugitive.h"
#import "CapturedPhotoViewController.h"

@interface DetailViewController : UIViewController <CLLocationManagerDelegate>
{
@private
    Fugitive* fugitive_;
    UILabel* nameLabel_;
    UILabel* idLabel_;
    UITextView* descriptionTextView_;
    UILabel* bountyLabel_;
    UISegmentedControl* capturedSeg_;
    UILabel* dateLabel_;
    UILabel* caputuredLatLon_;
    
    CLLocationManager* locationManager_;
}

@property (nonatomic, retain) Fugitive* fugitive;
@property (nonatomic, retain) IBOutlet UILabel* nameLabel;
@property (nonatomic, retain) IBOutlet UILabel* idLabel;
@property (nonatomic, retain) IBOutlet UITextView* descriptionTextView;
@property (nonatomic, retain) IBOutlet UILabel* bountyLabel;
@property (nonatomic, retain) IBOutlet UISegmentedControl* capturedSeg;
@property (nonatomic, retain) IBOutlet UILabel* dateLabel;
@property (nonatomic, retain) IBOutlet UILabel* caputuredLatLon;

@property (nonatomic, readonly) CLLocationManager* locationManager;

- (IBAction)capturedToggled:(id)sender;
- (IBAction)showInfoButtonPressed:(id)sender;

- (void) refreshFugitiveInformation;

@end
