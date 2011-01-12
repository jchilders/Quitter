//
//  SmokesTestCases
//  Quitter
//
//  Created by James Childers on 1/11/11.
//  Copyright 2011 Green Bar Consulting, LLC. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <CoreData/CoreData.h>

#import "Smokes.h"
#import "Smoke.h"

@interface SmokesTestCases : SenTestCase {
	Smokes *smokes;
	Smoke *smoke;

	NSManagedObjectModel *model;
	NSPersistentStoreCoordinator *coordinator;
	NSManagedObjectContext *context;
}
@end

@implementation SmokesTestCases


#if USE_APPLICATION_UNIT_TEST     // all code under test is in the iPhone Application

- (void) testAppDelegate {

    id yourApplicationDelegate = [[UIApplication sharedApplication] delegate];
    STAssertNotNil(yourApplicationDelegate, @"UIApplication failed to find the AppDelegate");
}

#else                           // all code under test must be linked into the Unit Test bundle

- (void) setUp {
	NSArray *bundles = [NSArray arrayWithObject:[NSBundle bundleForClass:[self class]]];
	model = [[NSManagedObjectModel mergedModelFromBundles:bundles] retain];
	NSLog(@"Model: %@", model);

	coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
	context = [[NSManagedObjectContext alloc] init];
	[context setPersistentStoreCoordinator:coordinator];

	smoke = (Smoke *)[NSEntityDescription insertNewObjectForEntityForName:@"Smoke"
													 inManagedObjectContext:context];
}

- (void) tearDown {
	[context rollback];
	[context release];
	[coordinator release];
	[model release];
}

- (void) testInitializers {

	NSMutableArray *array = [[NSMutableArray alloc] init];
	smokes = [[Smokes alloc] initWithArray:array forDate:NULL];
	STAssertNotNil(smokes, @"Smokes was nil, should not have been.");
	STAssertEquals(0, [smokes count], @"Size should be 0, was %d", [smokes count]);

	smokes = [[Smokes alloc] init];
	STAssertNotNil(smokes, @"Smokes was nil, should not have been.");
	STAssertEquals(0, [smokes count], @"Size should be 0, was %d", [smokes count]);
}

- (void) testAddBadDates {

	NSTimeInterval secondsPerDay = 24 * 60 * 60;
	NSDate *yesterday = [[NSDate alloc]
						 initWithTimeIntervalSinceNow:-secondsPerDay];
	smokes = [[Smokes alloc] initWithDate:yesterday];

	smoke = [[Smoke alloc] init];
	[smoke setTimestamp:[NSDate date]];

	NSMutableArray *array = [[NSMutableArray alloc] init];
	[array addObject:smoke];
	[smokes setSmokesArray:array];

	STAssertEquals(0, [smokes count], @"Expected bad date to be rejected, wasn't.");

	[array release];
}


#endif


@end
