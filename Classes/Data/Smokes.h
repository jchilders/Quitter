//
//  Smokes.h
//  Collection of Smoke objects for a given day.
//
//  Created by James Childers on 1/4/11.
//  Copyright 2011 Green Bar Consulting, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Smokes : NSObject {
	NSDate *date;
	NSMutableArray *smokesArray;

	NSManagedObjectContext *managedObjectContext;
}

- (id)initWithArray:(NSMutableArray *)smokes forDate:(NSDate *)forDate;
- (id)initWithDate:(NSDate *)forDate;

- (NSArray *)getSmokesFor:(NSDate *)date;
- (int) count;

@property (nonatomic, retain) NSArray *smokesArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end
