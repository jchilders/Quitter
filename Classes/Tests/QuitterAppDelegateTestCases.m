//
//  untitled.m
//  Quitter
//
//  Created by James Childers on 1/4/11.
//  Copyright 2011 Green Bar Consulting, LLC. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>

#import "QuitterAppDelegate.h"
#import "MainViewController.h"

@interface QuitterAppDelegateTestCases : SenTestCase {
	QuitterAppDelegate *appDelegate;
	MainViewController *viewController;
	UIView             *calcView;
}
@end

@implementation QuitterAppDelegateTestCases

#if USE_APPLICATION_UNIT_TEST     // all code under test is in the iPhone Application

- (void) testAppDelegate {
    id yourApplicationDelegate = [[UIApplication sharedApplication] delegate];
    STAssertNotNil(yourApplicationDelegate, @"UIApplication failed to find the AppDelegate");
}



#else                           // all code under test must be linked into the Unit Test bundle

- (void) testMath {

    STAssertTrue((1+1)==2, @"Compiler isn't feeling well today :-(" );

}


#endif


@end
