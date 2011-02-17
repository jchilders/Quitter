//
//  IncrementCountView.m
//  Quitter
//
//  Created by James Childers on 2/15/11.
//  Copyright 2011 Green Bar Consulting, LLC. All rights reserved.
//

#import "IncrementCountView.h"


@implementation IncrementCountView

@synthesize bigView;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		CGRect rect = [[UIScreen mainScreen] applicationFrame];
		UIView *view = [[[UIView alloc] initWithFrame:rect] autorelease];
		view.backgroundColor = [UIColor clearColor];

		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 45)];
		UIFont *font = [UIFont fontWithName:@"Arial" size:48.0];
		
		label.backgroundColor = [UIColor clearColor];
		label.center = view.center;
		label.font = font;		
		label.text = @"+1";
		label.textAlignment = UITextAlignmentCenter;
		label.textColor = [UIColor whiteColor];

		[view addSubview:label];
		[self addSubview:view];
		
		self.bigView = view;
		
		[label release];
    }
    return self;
}

- (void)animate {
	CGPoint ctr = [[self superview] center];
	DebugLog(@"before center: %f/%f", ctr.x, ctr.y);

	[UIView animateWithDuration:0.5 animations:^{		
		CGAffineTransform t0 = CGAffineTransformMakeTranslation(0, -40);
		CGAffineTransform s0 = CGAffineTransformMakeScale(10, 10);
		self.transform = CGAffineTransformConcat(t0, s0);
		
		self.alpha = 0.0;
	} completion:^(BOOL finished){
		DebugLog(@"after center: %f/%f", self.center.x, self.center.y);
		[self removeFromSuperview];
	}];	
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
