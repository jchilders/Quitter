//
//  Smokes.m
//  Array decorator containing Smoke objects.
//
//  Created by James Childers on 1/4/11.
//  Copyright 2011 Green Bar Consulting, LLC. All rights reserved.
//

#import "Smokes.h"

@implementation Smokes

@synthesize managedObjectContext;
@synthesize smokesArray;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)ctx {
	self = [super init];
	self.managedObjectContext = ctx;
	return self;
}

- (id)initWithDate:(NSDate *)forDate {
	return [self initWithArray:[[NSMutableArray alloc] init]
					   forDate:forDate];
}

- (NSArray *)getSmokesFor:(NSDate *)forDate {
	return [[[NSMutableArray alloc] init] autorelease];
}

- (void)dealloc {
	[smokesArray release];
	[super dealloc];
}

@end
