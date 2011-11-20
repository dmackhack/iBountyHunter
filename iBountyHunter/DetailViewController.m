//
//  DetailViewController.m
//  iBountyHunter
//
//  Created by David MacKenzie on 19/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

@synthesize fugitive=fugitive_, nameLabel=nameLabel_, idLabel=idLabel_, descriptionTextView=descriptionTextView_, bountyLabel=bountyLabel_, capturedSeg=capturedSeg_, dateLabel=dateLabel_, caputuredLatLon=caputuredLatLon_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshFugitiveInformation];
    
    [self.locationManager startUpdatingLocation];
    self.capturedSeg.enabled = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSLog(@"Shutting down location service");
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Core Location claims to have a position");
    self.capturedSeg.enabled = YES;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Core location can't get a fix. Disabling capture toggle.");
    self.capturedSeg.enabled = NO;
}

- (void) refreshFugitiveInformation
{
    if (fugitive_ != nil)
    {
        idLabel_.text = [fugitive_.fugitiveID stringValue];
        nameLabel_.text = fugitive_.name;
        descriptionTextView_.text = fugitive_.desc;
        bountyLabel_.text = [NSString stringWithFormat:@"%d", fugitive_.bounty];
        capturedSeg_.selectedSegmentIndex = [fugitive_.captured boolValue] ? 0 : 1;
        dateLabel_.text = [fugitive_.captdate description];
        
        if (self.fugitive.capturedLat != nil)
        {
            caputuredLatLon_.text = [NSString stringWithFormat:@"%.3f, %.3f", [fugitive_.capturedLat doubleValue], [fugitive_.capturedLon doubleValue]];
        }
        else
        {
            caputuredLatLon_.text = @"";
        }
    }
}

- (CLLocationManager *) locationManager 
{
    if (locationManager_ == nil)
    {
        locationManager_ = [[CLLocationManager alloc] init];
        locationManager_.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        locationManager_.delegate = self;
    }
    return locationManager_;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) dealloc
{
    [fugitive_ release];
    [idLabel_ release];
    [nameLabel_ release];
    [descriptionTextView_ release];
    [bountyLabel_ release];
    [capturedSeg_ release];
    [dateLabel_ release];
    [caputuredLatLon_ release];
    [locationManager_ release];
    [super dealloc];
}

- (IBAction)capturedToggled:(id)sender 
{
    NSLog(@"Toggling capture");
    if (capturedSeg_.selectedSegmentIndex == 0)
    {
        fugitive_.captured = [NSNumber numberWithBool:YES];
        fugitive_.captdate = [NSDate date];
        
        CLLocation* curPos = self.locationManager.location;
        fugitive_.capturedLat = [NSNumber numberWithDouble:curPos.coordinate.latitude];
        fugitive_.capturedLon = [NSNumber numberWithDouble:curPos.coordinate.longitude];
    }
    else
    {
        fugitive_.captured = [NSNumber numberWithBool:NO];
        fugitive_.captdate = nil;
        fugitive_.capturedLat = nil;
        fugitive_.capturedLon = nil;
    }
    [self refreshFugitiveInformation];
}

- (IBAction)showInfoButtonPressed:(id)sender 
{
    CapturedPhotoViewController* capturedPhotoView = [[CapturedPhotoViewController alloc] initWithNibName:@"CapturedPhotoViewController" bundle:nil];
    capturedPhotoView.fugitive = self.fugitive;
    
    capturedPhotoView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:capturedPhotoView animated:YES];
    [capturedPhotoView release];
}
@end
