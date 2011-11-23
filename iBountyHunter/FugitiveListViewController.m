//
//  FugitiveListViewController.m
//  iBountyHunter
//
//  Created by David Mackenzie on 16/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FugitiveListViewController.h"

#import "iBountyHunterAppDelegate.h"
#import "Fugitive.h"
#import "DetailViewController.h"
#import "FugitiveDossierViewController.h"

@implementation FugitiveListViewController

@synthesize captured=captured_, cache=cache_, dossierView=dossierView_;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    
    return self;
}

- (void)dealloc
{
    [dossierView_ release];
    [resultsController_ release];
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

    self.captured = NO;
    self.cache = @"uncaptured_list.cache";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
}

- (NSFetchedResultsController *) resultsController
{
    if (resultsController_ != nil)
    {
        return resultsController_;
    }
    
    iBountyHunterAppDelegate* appDelegate = (iBountyHunterAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    NSFetchRequest* fetchFugitives = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* fugitiveEntityDescription = [NSEntityDescription entityForName:@"Fugitive" inManagedObjectContext:context];
    [fetchFugitives setEntity:fugitiveEntityDescription];
    
    // no predicate required. we are fetching everything
    
    //NSLog(@"Captured: %i", [self captured]);
    //NSLog(@"Cache: %@", [self cache]);
    
    NSPredicate* fugitivesPredicate = [NSPredicate predicateWithFormat:@"captured == %i", captured_];
    [fetchFugitives setPredicate:fugitivesPredicate];                                             
    
    NSSortDescriptor* fugitiveSD = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [fetchFugitives setSortDescriptors:[NSArray arrayWithObject:fugitiveSD]];
    
    resultsController_ = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchFugitives managedObjectContext:context sectionNameKeyPath:nil cacheName:[self cache]];
    
    resultsController_.delegate = self;
    
    NSError* error;
    BOOL success = [resultsController_ performFetch:&error];
    
    if (!success)
    {
        NSLog(@"Error fetching results");
    }
    [fetchFugitives release];
    return resultsController_;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
    {
        return YES;
    }
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[self.resultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[self.resultsController sections] objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Fugitive* fugitive = [self.resultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = fugitive.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
     
    
     // Pass the selected object to the new view controller.
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        NSLog(@"IPad detected calling update dossier");
        [self.dossierView updateDossier:[self.resultsController objectAtIndexPath:indexPath]];
    }
    else
    {
        DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
        [detailViewController setFugitive:[self.resultsController objectAtIndexPath:indexPath]];
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController release];
    }
     
}

- (void) controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}

@end
