//
//  QuitterViewController.m
//  Quitter
//
//  Created by James Childers on 10/22/09.
//  Copyright Green Bar Consulting, LLC 2009. All rights reserved.
//

#import "QuitterViewController.h"

@implementation QuitterViewController

@synthesize numCurrDayLabel;
@synthesize numPrevDayLabel;
@synthesize numNextDayLabel;
@synthesize currDayLabel;

- (IBAction)addSmoke {
	// Copy the existing label
	UILabel *newLabel = [[UILabel alloc] initWithFrame:numCurrDayLabel.frame];
	newLabel.font = numCurrDayLabel.font;
	newLabel.alpha = 1.0f;
	
	// Update the value of the existing frame
	int numSmoked = [numCurrDayLabel.text intValue];
	numSmoked++;
	if (numSmoked >= 100) {
		numSmoked = 99;
	}
	NSString *newValStr = [NSString stringWithFormat:@"%d", numSmoked];
	newLabel.text = newValStr;
	

	// Animate the old val so that it fades and explodes 
	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:1.0f];
	
	// Fade out
	[numCurrDayLabel setAlpha:0.0f];
	
	// Increase frame size by 525%
	CGRect currFrame = numCurrDayLabel.frame;
	CGRect newFrame = CGRectInset(currFrame, -5.25, -5.25);
	[numCurrDayLabel setFrame:newFrame];
	
	// Increase font size by 125%
	UIFont *currFont = numCurrDayLabel.font;
	UIFont *newFont = [currFont fontWithSize:(currFont.pointSize * 1.25)];
	[numCurrDayLabel setFont:newFont];

	[UIView commitAnimations];
	
	// Show the label containing the new value
	NSLog(@"Old alpha: %f, text: %@", numCurrDayLabel.alpha, numCurrDayLabel.text);
	numCurrDayLabel = newLabel;
	NSLog(@"New alpha: %f, text: %@", numCurrDayLabel.alpha, numCurrDayLabel.text);
}

- (IBAction)subtractSmoke {
	int numSmoked = [self.numCurrDayLabel.text intValue];
	numSmoked--;
	if (numSmoked <= 0) {
		numSmoked = 0;
	}
	NSString *newValStr = [NSString stringWithFormat:@"%d", numSmoked];
	numCurrDayLabel.text = newValStr;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}

@end
