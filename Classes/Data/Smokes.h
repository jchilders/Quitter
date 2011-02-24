//
//  Smokes.h
//  Collection of Smoke objects for a given day.
//
//  Created by James Childers on 1/4/11.
//  Copyright 2011 Green Bar Consulting, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Smokes : NSObject {
	NSManagedObjectContext *managedObjectContext;
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)ctx;

- (BOOL)addSmokeForDate:(NSDate *)date;
- (BOOL)removeSmokeForDate:(NSDate *)date;
- (NSArray *)smokesForDateRange:(NSDate *)fromDate toDate:(NSDate *)toDate;
- (NSArray *)smokesForDate:(NSDate *)date;
- (NSArray *)allSmokes;
- (BOOL)saveContext;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end
