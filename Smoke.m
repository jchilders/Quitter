//
//  Smoke.m
//  Quitter
//
//  Created by James Childers on 1/2/11.
//  Copyright 2011 Green Bar Consulting, LLC. All rights reserved.
//

#import "Smoke.h"


@implementation Smoke

@synthesize timestamp;

- (id)init
{
	NSDate *date = [[NSDate alloc] init];
	[self setTimestamp:date];
	[date release];
	
	return self;
}

- (id)initWithDate:(NSDate *)date
{
	timestamp = date;
	
	return self;
}

- (void)dealloc
{
	[timestamp release];
	[super dealloc];
}

@end
