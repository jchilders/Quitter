//
//  QuitterAppDelegate.h
//  Quitter
//
//  Created by James Childers on 10/22/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuitterViewController;

@interface QuitterAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    QuitterViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet QuitterViewController *viewController;

@end

