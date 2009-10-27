//
//  QuitterAppTests.m
//  Quitter
//
//  Created by James Childers on 10/23/09.
//  Copyright 2009 Green Bar Consulting, LLC. All rights reserved.
//

#import "QuitterAppTests.h"


@implementation QuitterAppTests

- (void) testAppDelegate {
	id app_delegate = [[UIApplication sharedApplication] delegate];
	STAssertNotNil(app_delegate, @"Cannot find the application delegate.");
}

@end
