//
//  QuitterViewController.h
//  Quitter
//
//  Created by James Childers on 10/22/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuitterViewController : UIViewController {
	UILabel *numCurrDayLabel;
	UILabel *numPrevDayLabel;
	UILabel *numNextDayLabel;
	UILabel *currDayLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *numCurrDayLabel;
@property (nonatomic, retain) IBOutlet UILabel *numPrevDayLabel;
@property (nonatomic, retain) IBOutlet UILabel *numNextDayLabel;
@property (nonatomic, retain) IBOutlet UILabel *currDayLabel;

- (IBAction)addSmoke;
- (IBAction)subtractSmoke;

@end

