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
	NSMutableArray *smokesArray;
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)ctx;

- (NSArray *)getSmokesFor:(NSDate *)date;

@property (nonatomic, retain) NSArray *smokesArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end
