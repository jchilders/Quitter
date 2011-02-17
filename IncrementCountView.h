//
//  IncrementCountView.h
//  Quitter
//
//  Created by James Childers on 2/15/11.
//  Copyright 2011 Green Bar Consulting, LLC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>


@interface IncrementCountView : UIView {
	UIView *bigView;
}

- (void)animate;

@property (nonatomic, retain) UIView *bigView;

@end
