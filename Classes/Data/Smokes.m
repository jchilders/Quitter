//
//  Smokes.m
//  Array decorator containing Smoke objects.
//
//  Created by James Childers on 1/4/11.
//  Copyright 2011 Green Bar Consulting, LLC. All rights reserved.
//

#import "Smoke.h"
#import "Smokes.h"

@implementation Smokes

@synthesize managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)ctx {
	self = [super init];
	self.managedObjectContext = ctx;
	return self;
}

- (BOOL)addSmokeForDate:(NSDate *)date
{
	Smoke *smoke = (Smoke *)[NSEntityDescription insertNewObjectForEntityForName:@"Smoke"
														  inManagedObjectContext:managedObjectContext];
	[smoke setTimestamp:date];

	NSError *error = nil;
	if (![managedObjectContext save:&error]) {
		NSLog(@"An error occured saving this Smoke: %@", [error localizedDescription]);
		return NO;
	}

	return YES;
}

- (BOOL)removeSmokeForDate:(NSDate *)date
{
	NSArray *smokes = [self smokesForDate:date];
	if (smokes == nil || [smokes count] == 0) {
		return YES;
	}

	NSManagedObject *smokeToDelete = [smokes lastObject];
	[self.managedObjectContext deleteObject:smokeToDelete];

	// Commit change
	NSError *error = nil;
	if (![self.managedObjectContext save:&error]) {
		NSLog(@"Error deleting Smoke: %S", [error localizedDescription]);
		return NO;
	}

	return YES;
}

- (NSArray *)smokesForDateRange:(NSDate *)fromDate toDate:(NSDate *)toDate
{
	if (!managedObjectContext) {
		return [[[NSMutableArray alloc] initWithCapacity:0] autorelease];
	}

	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(timestamp >= %@) and (timestamp <= %@)", fromDate, toDate];
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:[NSEntityDescription entityForName:@"Smoke" inManagedObjectContext:self.managedObjectContext]];
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

- (NSArray *)allSmokes
{
	if (!managedObjectContext) {
		return [[[NSMutableArray alloc] initWithCapacity:0] autorelease];
	}
	
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:[NSEntityDescription entityForName:@"Smoke" inManagedObjectContext:self.managedObjectContext]];
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	NSError *error = nil;
	NSMutableArray *results = [[[managedObjectContext executeFetchRequest:request error:&error] mutableCopy] autorelease];
	
	[sortDescriptors release];
	[sortDescriptor release];
	
	return results;
}

- (NSArray *)smokesForDate:(NSDate *)date
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

	[gregorian release];

	return results;
}

- (BOOL)saveContext
{
    NSError *error = nil;
	NSManagedObjectContext *ctx = self.managedObjectContext;
    if (ctx != nil) {
        if ([ctx hasChanges] && ![ctx save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
			return NO;
        }
    }
	return YES;
}

- (void)dealloc
{
	[super dealloc];
}

@end
