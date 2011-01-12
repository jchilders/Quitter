//
//  Smokes.m
//  Array decorator containing Smoke objects.
//
//  Created by James Childers on 1/4/11.
//  Copyright 2011 Green Bar Consulting, LLC. All rights reserved.
//

#import "Smokes.h"


@implementation Smokes

- (id)initWithArray:(NSMutableArray *)smokes
			forDate:(NSDate *)forDate
{
	self = [super init];
	if (self) {
		smokesArray = smokes;

		if (date != NULL) {
			date = forDate;
		} else {
			date = [NSDate date];
		}
	}

	return self;
}

- (id)initWithDate:(NSDate *)forDate
{
	return [self initWithArray:[[NSMutableArray alloc] init]
					   forDate:forDate];
}

- (NSArray *)getSmokesFor:(NSDate *)forDate
{
	return [[[NSMutableArray alloc] init] autorelease];
}

- (int)count
{
	return [smokesArray count];
}

- (void)dealloc
{
	[smokesArray release];
	[date release];

	[super dealloc];
}

@synthesize smokesArray;
@synthesize managedObjectContext;

@end
