//
//  Smoke.m
//  Quitter
//
//  Created by James Childers on 10/23/09.
//  Copyright 2009 Green Bar Consulting, LLC. All rights reserved.
//

#import "Smoke.h"


@implementation Smoke

@synthesize when;
@synthesize amount;

- (id)init {
	self = [super init];
	if (nil != self) {
		self.amount = [NSNumber numberWithInt:1];
		self.when = [NSDate date];
	}
	return self;
}

- (id)initWithWhen:(NSDate *)newWhen
			amount:(NSNumber *)newAmount {
	self = [super init];
	if (nil != self) {
		self.when = newWhen;
		self.amount = newAmount;
	}
	return self;
}

- (void)dealloc {
	self.when = nil;
	[super dealloc];
}

@end
