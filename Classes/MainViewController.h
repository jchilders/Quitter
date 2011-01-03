//
//  MainViewController.h
//  Quitter
//
//  Created by James Childers on 1/1/11.
//  Copyright 2011 Green Bar Consulting, LLC. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <CoreData/CoreData.h>
#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
	int numSmokedToday;
	NSMutableArray *smokesArray;
	IBOutlet UILabel *numSmokedLabel;
	IBOutlet UILabel *motivationMessageLabel;
	
	NSManagedObjectContext *managedObjectContext;
	CLLocationManager *locationManager;
}

- (IBAction)showInfo:(id)sender;
- (IBAction)addAndShow:(id)sender;
- (IBAction)subtractAndShow:(id)sender;

- (void)showNumSmokedToday;
- (void)showMotivationMessage;
- (void)addSmoke;
- (void)subtractSmoke;

@property (nonatomic) int numSmokedToday;
@property (nonatomic, retain) NSMutableArray *smokesArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
