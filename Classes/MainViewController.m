//
//  MainViewController.m
//  Quitter
//
//  Created by James Childers on 1/1/11.
//  Copyright 2011 Green Bar Consulting, LLC. All rights reserved.
//

#import "MainViewController.h"
#import "Smoke.h"

@implementation MainViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	NSDate *today = [NSDate date];
	[self setUsingDate:today];
	[self setSmokesArray:[self getSmokesFor:[self usingDate]]];

	[self snowNumSmoked];
	[self showMotivationMessage];
	
	NSDate *yesterday = [today dateByAddingTimeInterval:-86400.0];
	NSArray *smokesYestArray = [self getSmokesFor:yesterday];
	NSLog(@"# of smokes yesterday: %d", [smokesYestArray count]);
}

- (int)numSmoked
{
	return [smokesArray count];
}

- (void)snowNumSmoked
{
	NSLog(@"showNumSmokedToday called");
	NSString *str = [NSString stringWithFormat:@"%d", [self numSmoked]];
	[numSmokedLabel setText:str];
}

- (NSArray *)getSmokesFor:(NSDate *)date
{
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSDateComponents *comp = [cal components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit 
									fromDate:date];
	NSDateComponents *oneDay = [[NSDateComponents alloc] init];
	oneDay.day = 1;
	
	// from & to
	NSDate *fromDate = [cal dateFromComponents:comp]; // Today at midnight
	NSDate *toDate = [cal dateByAddingComponents:oneDay toDate:fromDate options:0]; // Tomorrow at midnight
	
	// CoreData expressions 
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(timestamp >= %@) and (timestamp <= %@)", fromDate, toDate];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:[NSEntityDescription entityForName:@"Smoke" inManagedObjectContext:managedObjectContext]];
	[request setPredicate:predicate];
	
	// Sort descending by timestamp
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];	
	
	NSError *error = nil;
	NSMutableArray *results = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	
	[sortDescriptors release];
	[sortDescriptor release];
	[oneDay release];
	
	return results;
}

- (void)showMotivationMessage
{
	NSString *msg;
	if ([smokesArray count] < 10) {
		msg = @"You are doing better today.";
	} else {
		msg = @"You've had more today than yesterday.";
	}
	
	[motivationMessageLabel setText:msg];
}

- (void)addSmoke
{
	NSLog(@"addSmoke called");
	Smoke *smoke = (Smoke *)[NSEntityDescription insertNewObjectForEntityForName:@"Smoke"
														  inManagedObjectContext:managedObjectContext];
	
	[smoke setTimestamp:[NSDate date]];
	
	NSError *error = nil;
	if (![managedObjectContext save:&error]) {
		// Handle the error.
		NSLog(@"An error occured saving this Smoke.");
	}

	[smokesArray addObject:smoke];
}

- (IBAction)addAndShow:(id)sender
{
	[self addSmoke];
	[self snowNumSmoked];
	[self showMotivationMessage];
}

- (void)subtractSmoke
{
	if (smokesArray == nil || [smokesArray count] == 0) {
		return;
	}
	
	// Delete the managed object at the given index path.
	NSManagedObject *smokeToDelete = [smokesArray lastObject];
	[managedObjectContext deleteObject:smokeToDelete];
	
	[smokesArray removeLastObject];

	// Commit the change.
	NSError *error = nil;
	if (![managedObjectContext save:&error]) {
		NSLog(@"Error deleting Smoke.");
	}
	
	[self snowNumSmoked];
}

- (IBAction)subtractAndShow:(id)sender
{
	[self subtractSmoke];
	[self snowNumSmoked];
	[self showMotivationMessage];
}

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction)showInfo:(id)sender {    
	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	self.smokesArray = nil;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)dealloc {
	[managedObjectContext release];
	[smokesArray release];
	
    [super dealloc];
}

@synthesize usingDate;
@synthesize smokesArray;
@synthesize managedObjectContext;


@end
