//
//  FugitiveDossierViewController.h
//  iBountyHunter
//
//  Created by David Mackenzie on 23/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Fugitive.h"

@interface FugitiveDossierViewController : UIViewController <UISplitViewControllerDelegate>
{
    Fugitive* fugitive_;
    UIImageView* photoView_;
    MKMapView* mapView_;
    UIWebView* descriptionView_;
    UIWebView* sightingsView_;
    UIPopoverController* popOver_;

}

@property (nonatomic, retain) Fugitive* fugitive;
@property (nonatomic, retain) IBOutlet UIImageView* photoView;
@property (nonatomic, retain) IBOutlet MKMapView* mapView;
@property (nonatomic, retain) IBOutlet UIWebView* descriptionView;
@property (nonatomic, retain) IBOutlet UIWebView* sightingsView;
@property (nonatomic, retain) UIPopoverController* popOver;

- (void) updateDossier: (Fugitive*) fugitive;

@end
