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
	
	[self setNumSmokedToday:15];
	
	[self showNumSmokedToday];
	[self showMotivationMessage];
}

- (void)showNumSmokedToday
{
	NSLog(@"showNumSmokedToday called");
//	NSString *str = [NSString stringWithFormat:@"%d", [self numSmokedToday]];
	NSString *str = [NSString stringWithFormat:@"%d", [smokesArray count]];
	[numSmokedLabel setText:str];
}

- (void)showMotivationMessage
{
	NSString *msg;
	if ([self numSmokedToday] < 10) {
		msg = @"You are doing better today.";
	} else {
		msg = @"You've had more today than yesterday.";
	}
	
	[motivationMessageLabel setText:msg];
}

- (void)addSmoke
{
	Smoke *smoke = (Smoke *)[NSEntityDescription insertNewObjectForEntityForName:@"Smoke"
														  inManagedObjectContext:managedObjectContext];
	
	[smoke setTimestamp:[NSDate date]];
	
	NSError *error = nil;
	if (![managedObjectContext save:&error]) {
		// Handle the error.
		NSLog(@"An error occured saving this Smoke.");
	}
	
	NSLog(@"Smokes array before count: %d", [smokesArray count]);
	[smokesArray insertObject:smoke atIndex:0];
	NSLog(@"Smokes array after count: %d", [smokesArray count]);
}

- (IBAction)addAndShow:(id)sender
{
	[self addSmoke];
	[self showNumSmokedToday];
}

- (void)subtractSmoke
{
	if (smokesArray == nil || [smokesArray count] == 0) {
		return;
	}
	
	[smokesArray removeLastObject];

	[self showNumSmokedToday];
}

- (IBAction)subtractAndShow:(id)sender
{
	[self subtractSmoke];
	[self showNumSmokedToday];
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

@synthesize numSmokedToday;
@synthesize smokesArray;
@synthesize managedObjectContext;


@end
