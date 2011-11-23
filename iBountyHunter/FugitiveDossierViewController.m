//
//  FugitiveDossierViewController.m
//  iBountyHunter
//
//  Created by David Mackenzie on 23/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FugitiveDossierViewController.h"


@interface FugitiveDossierViewController ()
    - (void)initialiseMapView;
@end

@implementation FugitiveDossierViewController

@synthesize fugitive=fugitive_, photoView=photoView_, mapView=mapView_, descriptionView=descriptionView_, sightingsView=sightingsView_, popOver=popOver_;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [fugitive_ release];
    [photoView_ release];
    [mapView_ release];
    [descriptionView_ release];
    [sightingsView_ release];
    [popOver_ release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


#pragma mark - UISplitViewControllerDelegate methods

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc {
    barButtonItem.title = @"Fugitives";
    
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.popOver = pc;
}

- (void) splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.popOver = nil;
}

#pragma mark - Interface instance methods

- (void) updateDossier: (Fugitive*) fugitive
{
    NSLog(@"Updating Dossier");
    self.fugitive = fugitive;
    
    if (fugitive_.image != nil)
    {
        self.photoView.image = [UIImage imageWithData:fugitive_.image];
    }
    
    [self initialiseMapView];
    
}

- (void)initialiseMapView
{
    if ([fugitive_.captured boolValue])
    {
        CLLocationCoordinate2D mapCenter = CLLocationCoordinate2DMake([fugitive_.capturedLat doubleValue], [fugitive_.capturedLon doubleValue]);
        MKCoordinateSpan mapSpan = MKCoordinateSpanMake(0.005, 0.005);
        MKCoordinateRegion mapRegion = MKCoordinateRegionMake(mapCenter, mapSpan);
        
        self.mapView.region = mapRegion;
        self.mapView.mapType = MKMapTypeHybrid;
    }
}

@end
