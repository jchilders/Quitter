//
//  MainViewController.h
//  Quitter
//
//  Created by James Childers on 1/1/11.
//  Copyright 2011 Green Bar Consulting, LLC. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
	int numSmoked;
	IBOutlet UILabel *numSmokedLabel;
	IBOutlet UILabel *motivationMessageLabel;
}

- (IBAction)showInfo:(id)sender;
- (void)showNumSmokedToday;
- (void)showMotivationMessage;

@property (nonatomic) int numSmoked;

@end
