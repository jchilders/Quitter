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
	NSDate *usingDate;
	NSMutableArray *smokesArray;
	IBOutlet UILabel *numSmokedLabel;
	IBOutlet UILabel *motivationMessageLabel;
	
	NSManagedObjectContext *managedObjectContext;
	CLLocationManager *locationManager;
}

- (IBAction)showInfo:(id)sender;
- (IBAction)addAndShow:(id)sender;
- (IBAction)subtractAndShow:(id)sender;

- (NSArray *)getSmokesFor:(NSDate *)date;
- (int)numSmoked;

- (void)snowNumSmoked;
- (void)showMotivationMessage;
- (void)addSmoke;
- (void)subtractSmoke;

@property (nonatomic, retain) NSDate *usingDate;
@property (nonatomic, retain) NSArray *smokesArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
