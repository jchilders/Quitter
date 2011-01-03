//
//  MainViewController.m
//  Quitter
//
//  Created by James Childers on 1/1/11.
//  Copyright 2011 Green Bar Consulting, LLC. All rights reserved.
//

#import "MainViewController.h"


@implementation MainViewController


- (void)showNumSmokedToday
{
	NSString *str = [NSString stringWithFormat:@"%d", [self numSmoked]];
	[numSmokedLabel setText:str];
}

- (void)showMotivationMessage
{
	NSString *msg;
	if ([self numSmoked] < 10) {
		msg = @"You are doing better today.";
	} else {
		msg = @"You've had more today than yesterday.";
	}
	
	[motivationMessageLabel setText:msg];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	NSLog(@"In viewDidLoad.");
	
	[self setNumSmoked:15];
	
	[self showNumSmokedToday];
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
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)dealloc {
    [super dealloc];
}

@synthesize numSmoked;

@end
