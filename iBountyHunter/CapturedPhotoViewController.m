//
//  CapturedPhotoViewController.m
//  iBountyHunter
//
//  Created by David MacKenzie on 20/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CapturedPhotoViewController.h"

@implementation CapturedPhotoViewController

@synthesize fugitive=fugitive_, fugitiveImage=fugitiveImage_, mapView=mapView_;

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (fugitive_.image != nil)
    {
        NSLog(@"Image found");
        self.fugitiveImage.image = [UIImage imageWithData:fugitive_.image];
    }
    else
    {
        NSLog(@"No Image found");
    }
    
    if (fugitive_.capturedLat != nil)
    {
        [self.mapView addAnnotation:fugitive_];
    }
    
    [self initialiseMapView];
}

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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doneButtonPressed:(id)sender 
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)takePictureButtonPressed:(id)sender
{
    NSLog(@"%@", @"Taking a picture...");
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        NSLog(@"This device has a camera");
        UIActionSheet* photoSourceSheet = [[UIActionSheet alloc] initWithTitle:@"Select Fugitive Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take New Photo", @"Choose Existing Photo", nil];
        [photoSourceSheet showInView:self.view];
        [photoSourceSheet release];
    }
    else
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentModalViewController:picker animated:YES];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    fugitive_.image = UIImagePNGRepresentation([info objectForKey:UIImagePickerControllerEditedImage]);
    [self dismissModalViewControllerAnimated:YES];
    [picker release];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
    [picker release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        NSLog(@"The user canelled adding an image");
        return;
    }
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    switch (buttonIndex) {
        case 0:
            NSLog(@"User wants to take a new picture.");
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        
        case 1:
            NSLog(@"User wants to use an existing picture.");
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
            
        default:
            break;
    }
    [self presentModalViewController:picker animated:YES];
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

- (void)dealloc
{
    [fugitiveImage_ release];
    [fugitive_ release];
    [mapView_ release];
    [super dealloc];
}

@end
