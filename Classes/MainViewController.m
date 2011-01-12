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

const NSTimeInterval kNSTimeIntervalOneDay = 86400;

- (void)viewDidLoad {
	NSLog(@"viewDidLoad called.");
	[super viewDidLoad];

	NSDate *today = [NSDate date];
	[self setActiveDate:today];
	[self showViewForDay:0];	// Offset 0 = today.
}

- (int)numSmoked
{
	return [smokesArray count];
}

- (void)showNumSmoked
{
	NSLog(@"showNumSmokedToday called (%d)", [self numSmoked]);
	NSString *str = [NSString stringWithFormat:@"%d", [self numSmoked]];
	[numSmokedLabel setText:str];
}

- (NSArray *)getTotalSmokesFor:(NSDate *)date
{
	NSCalendar *cal = [NSCalendar currentCalendar];

	// (date) at midnight, e.g.: this morning @ 12:00a local.
	NSDateComponents *fromComps = [cal components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit
									fromDate:date];
	NSDate *fromDate = [cal dateFromComponents:fromComps]; // (date) at midnight, e.g.: this morning @ 12:00a.

	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *toTimeComps = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date]];

	[toTimeComps setHour:24];
	[toTimeComps setMinute:0];
	[toTimeComps setSecond:0];

	NSDate *toDate = [gregorian dateByAddingComponents:toTimeComps toDate:fromDate options:0];

	NSArray *results = [self smokesForDateRange:fromDate toDate:toDate];
	NSLog(@"Found %d total smokes for date %@", [results count], date);

	[gregorian release];

	return results;
}

- (NSArray *)getSmokesForDateToCurrentTime:(NSDate *)date
{
	NSCalendar *cal = [NSCalendar currentCalendar];

	// (date) at midnight, e.g.: this morning @ 12:00a local.
	NSDateComponents *fromComps = [cal components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit
										 fromDate:date];
	NSDate *fromDate = [cal dateFromComponents:fromComps]; // (date) at midnight, e.g.: this morning @ 12:00a.

	// (date) @ current time, e.g.: today @ 4.58p.
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *toDateComps = [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit | NSYearCalendarUnit) fromDate:fromDate];
	NSDateComponents *toTimeComps = [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:[NSDate date]];

	[toDateComps setHour:[toTimeComps hour]];
	[toDateComps setMinute:[toTimeComps minute]];
	[toDateComps setSecond:[toTimeComps second]];

	NSDate *toDate = [gregorian dateFromComponents:toDateComps];

	NSArray *results = [self smokesForDateRange:fromDate toDate:toDate];
	NSLog(@"Found %d for date to current time from %@ to %@", [results count], fromDate, toDate);

	[gregorian release];

	return results;
}

- (NSArray *)smokesForDateRange:(NSDate *)fromDate toDate:(NSDate *)toDate
{
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(timestamp >= %@) and (timestamp <= %@)", fromDate, toDate];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:[NSEntityDescription entityForName:@"Smoke" inManagedObjectContext:managedObjectContext]];
	[request setPredicate:predicate];

	// Sort descending by timestamp
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];

	NSError *error = nil;
	NSMutableArray *results = [[[managedObjectContext executeFetchRequest:request error:&error] mutableCopy] autorelease];

	[sortDescriptors release];
	[sortDescriptor release];

	return results;
}

- (void)showMotivationMessage
{
	NSDate *priorDay = [activeDate dateByAddingTimeInterval:-kNSTimeIntervalOneDay];
	NSArray *smokesPriorDayArray;
	if ([self activeDateIsToday]) {
		smokesPriorDayArray = [self getSmokesForDateToCurrentTime:priorDay];
	} else {
		smokesPriorDayArray = [self getTotalSmokesFor:priorDay];
	}

	NSLog(@"Num smoked %@: %d, %@: %d.", priorDay, [smokesPriorDayArray count], activeDate, [self numSmoked]);

	NSString *msg;
	if ([smokesPriorDayArray count] >= [self numSmoked]) {
		if ([self activeDateIsToday]) {
			msg = @"You are doing better today.";
		} else {
			msg = @"You did better than the day before.";
		}
	} else {
		if ([self activeDateIsToday]) {
			msg = @"You've had more today than yesterday.";
		} else {
			msg = @"You had more than the day before.";
		}
	}

	[motivationMessageLabel setText:msg];
}

- (void)showActiveDate
{
	NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
	[fmt setDateStyle:NSDateFormatterMediumStyle];

	NSLocale *locale = [NSLocale currentLocale];
	[fmt setLocale:locale];

	NSString *str = [fmt stringFromDate:[self activeDate]];
	NSLog(@"Active date: %s", str);
	[activeDateLabel setText:str];

	[fmt release];
}

- (BOOL)activeDateIsToday
{
	NSCalendar *cal = [NSCalendar currentCalendar];
	NSDateComponents *comps = [cal components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:activeDate];
	NSDate *activeDateNormalized = [cal dateFromComponents:comps];
	comps = [cal components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
	NSDate *todayNormalized = [cal dateFromComponents:comps];

	BOOL isToday = [todayNormalized isEqualToDate:activeDateNormalized];

	return isToday;
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
	[self showNumSmoked];
	[self showMotivationMessage];
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
	[self showNumSmoked];
	[self showMotivationMessage];
}

- (IBAction)showPreviousDay:(id)sender
{
	[self showViewForDay:-1];
}

- (IBAction)showNextDay:(id)sender
{
	[self showViewForDay:1];
}

// Offset is from activeDate. e.g. is activeDate is today,
// then -1 = yesterday, 0 = today, 1 = tomorrow
- (void)showViewForDay:(int)offset
{
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];

	[offsetComponents setDay:offset];
	NSDate *newDay = [gregorian dateByAddingComponents:offsetComponents toDate:activeDate options:0];

	[self setActiveDate:newDay];
	[self showActiveDate];

	[self setSmokesArray:[self getTotalSmokesFor:[self activeDate]]];
	[self showNumSmoked];
	[self showMotivationMessage];

	[gregorian release];
	[offsetComponents release];
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
