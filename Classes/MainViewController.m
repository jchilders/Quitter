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
	[self setActiveDate:today];
	[self setSmokesArray:[self getSmokesFor:[self activeDate]]];

	[self snowNumSmoked];
	[self showMotivationMessage];
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
	
	[self showMotivationMessage];
}

- (NSArray *)getSmokesFor:(NSDate *)date
{
	NSCalendar *cal = [NSCalendar currentCalendar];
	
	// (date) at midnight, e.g.: this morning @ 12:00a.
	NSDateComponents *fromComps = [cal components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit 
									fromDate:date];
	NSDate *fromDate = [cal dateFromComponents:fromComps]; // (date) at midnight, e.g.: this morning @ 12:00a.

	// (date) @ current time, e.g.: today @ 4.58p.
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *toDateComps = [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:fromDate];
	NSDateComponents *toTimeComps = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date]];
	
	[toDateComps setHour:[toTimeComps hour]];
	[toDateComps setMinute:[toTimeComps minute]];
	[toDateComps setSecond:[toTimeComps second]];
	
	NSDate *toDate = [gregorian dateFromComponents:toDateComps];
	
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
	
	[gregorian release];
	[sortDescriptors release];
	[sortDescriptor release];
	
	return results;
}

- (void)showMotivationMessage
{
	NSDate *priorDay = [activeDate dateByAddingTimeInterval:-86400.0];
	NSArray *smokesPriorDayArray = [self getSmokesFor:priorDay];
	
	NSString *msg;
	if ([smokesPriorDayArray count] < [smokesArray count]) {
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
	
	[smoke setTimestamp:activeDate];
	
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
}

- (void)subtractSmoke
{
	NSLog(@"subtractSmoke called");
	if (smokesArray == nil || [smokesArray count] == 0) {
		return;
	}
	
	// Delete the managed object at the given index path.
	NSManagedObject *smokeToDelete = [smokesArray lastObject];
	[managedObjectContext deleteObject:smokeToDelete];

	// Commit the change.
	NSError *error = nil;
	if (![managedObjectContext save:&error]) {
		NSLog(@"Error deleting Smoke.");
	}
	
	[smokesArray removeLastObject];
}

- (IBAction)subtractAndShow:(id)sender
{
	[self subtractSmoke];
	[self snowNumSmoked];
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

@synthesize activeDate;
@synthesize smokesArray;
@synthesize managedObjectContext;


@end
