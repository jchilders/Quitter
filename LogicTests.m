//
//  LogicTests.m
//  Quitter
//
//  Created by James Childers on 10/23/09.
//  Copyright 2009 Green Bar Consulting, LLC. All rights reserved.
//


#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>

#import "Smoke.h"

@interface LogicTests : SenTestCase {
	Smoke *smoke;
}

@end

@implementation LogicTests

-(void) setUp {
	smoke = [[Smoke new] retain];
	STAssertNotNil(smoke, @"Cannot create test Smoke instance.");
}

-(void) tearDown {
	[smoke release];
}

-(void) testSmokeInit {
	STAssertEquals([smoke.amount intValue], 1, [NSString stringWithFormat:@"smoke.amount should have been 1 but was %d", smoke.amount]);
	NSDate *newDate= smoke.when;
	
	double diff = fabs([newDate timeIntervalSinceDate:[NSDate date]]);
	STAssertTrue(diff < 10, [NSString stringWithFormat:@"Time diff expected to be less than 10, but was %d", diff]);
}

-(void) testSmokeInitWithParams {
	NSDate *newDate = [NSDate date];
	Smoke *newSmoke = [[[Smoke alloc] initWithWhen:newDate
											amount:[NSNumber numberWithInt:2]] autorelease];
	STAssertEquals([newSmoke.amount intValue], 2, [NSString stringWithFormat:@"newSmoke.amount should have been 2 but was %d", newSmoke.amount]);
	STAssertEquals([newSmoke.when compare:newDate], NSOrderedSame, @"");
}

@end
