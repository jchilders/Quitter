//
//  MainViewController.h
//  Quitter
//
//  Created by James Childers on 1/1/11.
//  Copyright 2011 Green Bar Consulting, LLC. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>

#import "FlipsideViewController.h"
#import "Smokes.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
	NSDate *activeDate;

	IBOutlet UILabel *activeDateLabel;
	IBOutlet UILabel *numSmokedLabel;
	IBOutlet UILabel *motivationMessageLabel;

	NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSDate *activeDate;
@property (nonatomic, retain) Smokes *smokes;

- (IBAction)showInfo:(id)sender;
- (IBAction)addAndShow:(id)sender;
- (IBAction)subtractAndShow:(id)sender;

- (int)numSmoked;

- (void)showNumSmoked;
- (void)showMotivationMessage;
- (void)addSmoke;
- (void)subtractSmoke;

- (IBAction)showPreviousDay:(id)sender;
- (IBAction)showNextDay:(id)sender;
- (void)showViewForDay:(int)offset;
- (void)showActiveDate;
- (BOOL)activeDateIsToday;
- (void)becameActive;

@end
