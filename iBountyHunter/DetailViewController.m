//
//  DetailViewController.m
//  iBountyHunter
//
//  Created by David MacKenzie on 19/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

@synthesize fugitive=fugitive_, nameLabel=nameLabel_, idLabel=idLabel_, descriptionTextView=descriptionTextView_, bountyLabel=bountyLabel_, capturedSeg=capturedSeg_, dateLabel=dateLabel_;

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
    if (fugitive_ != nil)
    {
        idLabel_.text = [fugitive_.fugitiveID stringValue];
        nameLabel_.text = fugitive_.name;
        descriptionTextView_.text = fugitive_.desc;
        bountyLabel_.text = [NSString stringWithFormat:@"%d", fugitive_.bounty];
        capturedSeg_.selectedSegmentIndex = [fugitive_.captured boolValue] ? 0 : 1;
        dateLabel_.text = [fugitive_.captdate description];
    }
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

- (void) dealloc
{
    [fugitive_ release];
    [idLabel_ release];
    [nameLabel_ release];
    [descriptionTextView_ release];
    [bountyLabel_ release];
    [capturedSeg_ release];
    [dateLabel_ release];
    [super dealloc];
}

- (IBAction)capturedToggled:(id)sender 
{
    NSLog(@"Toggling capture");
    if (capturedSeg_.selectedSegmentIndex == 0)
    {
        fugitive_.captured = [NSNumber numberWithBool:YES];
        fugitive_.captdate = [NSDate date];
    }
    else
    {
        fugitive_.captured = [NSNumber numberWithBool:NO];
        fugitive_.captdate = nil;
    }
    dateLabel_.text = [fugitive_.captdate description];
}
@end