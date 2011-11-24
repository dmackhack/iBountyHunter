//
//  FugitiveDossierViewController.m
//  iBountyHunter
//
//  Created by David Mackenzie on 23/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FugitiveDossierViewController.h"

#import <QuartzCore/CoreAnimation.h>

#define NO_FUGITIVE_SELECTED_HTML @"<html><link rel=\"stylesheet\" type=\"text/css\" href=\"fugitive.css\" /><body><dl class=\"dossier\"><dt>No fugitive selected.</dt><dd></dd></dl></body></html>";

#define NO_KNOWN_LOCATION_HTML @"<html><link rel=\"stylesheet\" type=\"text/css\" href=\"fugitive.css\" /><body><dl class=\"dossier\"><dt>No last known location.</dt><dd></dd></dl></body></html>";


@interface FugitiveDossierViewController ()
- (void)initialiseMapView;
- (NSString*) prepareFugitiveDescription;
- (NSString*) prepareMapDescription;
@end

@implementation FugitiveDossierViewController

@synthesize fugitive=fugitive_, photoView=photoView_, mapOverlay=mapOverlay_, mapView=mapView_, descriptionView=descriptionView_, sightingsView=sightingsView_, popOver=popOver_, latView=latView_, lonView=lonView_;


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
    [latView_ release];
    [lonView_ release];
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
    
    UIImage *backgroundTexture = [UIImage imageNamed:@"corkboard.png"];
    UIColor *backgroundColor = [UIColor colorWithPatternImage:backgroundTexture];
    [self.view setBackgroundColor:backgroundColor];
    
    [descriptionView_ setBackgroundColor:[UIColor clearColor]];
    [sightingsView_ setBackgroundColor:[UIColor clearColor]];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [descriptionView_ loadHTMLString:[self prepareFugitiveDescription] baseURL:baseURL];
    [sightingsView_ loadHTMLString:[self prepareMapDescription] baseURL:baseURL];
    
    self.photoView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.photoView.layer.shadowOpacity = 0.75;
    
    self.mapOverlay.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.mapOverlay.layer.shadowOpacity = 0.75;
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
    
    if (fugitive_.image != nil) {
        self.photoView.image = [UIImage imageWithData:fugitive_.image];
    }
    else {
        self.photoView.image = [UIImage imageNamed:@"silhouette.png"];
    }
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [descriptionView_ loadHTMLString:[self prepareFugitiveDescription] baseURL:baseURL];
    [sightingsView_ loadHTMLString:[self prepareMapDescription] baseURL:baseURL];
    
    self.latView.text = [fugitive_.lastSeenLat stringValue];
    self.lonView.text = [fugitive_.lastSeenLon stringValue];
    
    if (fugitive_.lastSeenLat != nil) {
        [self initialiseMapView];
    }
    else {
        self.mapOverlay.hidden = NO;
    }
    
    if (popOver_ != nil) {
        [popOver_ dismissPopoverAnimated:YES];
    }
    
}

- (IBAction)latValueChanged:(id)sender 
{
    NSLog(@"Setting Lat: %@", latView_.text);
    fugitive_.lastSeenLat = [NSNumber numberWithDouble:[latView_.text doubleValue]];
}

- (IBAction)lonValueChanged:(id)sender 
{
    NSLog(@"Setting Lon: %@", latView_.text);
    fugitive_.lastSeenLon = [NSNumber numberWithDouble:[lonView_.text doubleValue]];
}

- (void)initialiseMapView
{
    if (fugitive_.lastSeenLat != nil)
    {
        CLLocationCoordinate2D mapCenter = CLLocationCoordinate2DMake([fugitive_.lastSeenLat doubleValue], [fugitive_.lastSeenLon doubleValue]);
        MKCoordinateSpan mapSpan = MKCoordinateSpanMake(0.005, 0.005);
        MKCoordinateRegion mapRegion = MKCoordinateRegionMake(mapCenter, mapSpan);
        
        self.mapView.region = mapRegion;
        self.mapView.mapType = MKMapTypeHybrid;
        
        self.mapOverlay.hidden = YES;
    }
}

- (NSString *) prepareFugitiveDescription {
    NSString *response = nil;
    
    if (self.fugitive) {
        response = [NSString stringWithFormat: @"<html><link rel=\"stylesheet\" type=\"text/css\" href=\"fugitive.css\" /><body><dl class=\"dossier\"><dt>Name:</dt><dd>%@</dd><dt>ID:</dt><dd>%@</dd><dt>Bounty:</dt><dd>%@</dd><dt>Description:</dt><dd>%@</dd></dl></body></html>",
                    fugitive_.name,
                    [fugitive_.fugitiveID stringValue],
                    [fugitive_.bounty stringValue],
                    fugitive_.desc];
    }
    else {
        response = NO_FUGITIVE_SELECTED_HTML;
    }
    return response;
}

- (NSString *) prepareMapDescription {
    NSString *response = nil;
    if (self.fugitive && self.fugitive.lastSeenDesc) {
        response = [NSString stringWithFormat: @"<html><link rel=\"stylesheet\" type=\"text/css\" href=\"fugitive.css\" /><body><dl class=\"dossier\"><dt>Last Seen:</dt><dd>%6.3f, %6.3f</dd><dt>Description:</dt><dd>%@</dd></dl></body></html>",
                    [fugitive_.lastSeenLat doubleValue],
                    [fugitive_.lastSeenLon doubleValue],
                    fugitive_.lastSeenDesc];
    }
    else if (self.fugitive) {
        response = NO_KNOWN_LOCATION_HTML;
    }
    else {
        response = NO_FUGITIVE_SELECTED_HTML;
    }
    
    return response;
}


@end
