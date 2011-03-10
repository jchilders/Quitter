//
//  HorizontalPickerView.m
//  Quitter
//
//  Created by James Childers on 2/22/11.
//  Copyright 2011 Green Bar Consulting, LLC. All rights reserved.
//

#import "HorizontalPickerView.h"


@implementation HorizontalPickerView

@synthesize labels;

const float KPComponentWidth = 160.0;
const float KPComponentHeight = 40.0;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectZero];

		picker.delegate = self;
		picker.dataSource = self;
		
		picker.showsSelectionIndicator = NO;
		picker.backgroundColor = [UIColor blueColor];
		[self addSubview:picker];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame data:(NSArray *)data {
	self = [self initWithFrame:frame];
	self.labels = data;
	return self;
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
	DebugLog(@"Called for label '%@'", [labels objectAtIndex:row]);
	CGRect rect = CGRectMake(0, 0, KPComponentWidth, KPComponentHeight);
	UILabel *label = [[[UILabel alloc] initWithFrame:rect] autorelease];

	label.text = [labels objectAtIndex:row];
	label.textAlignment = UITextAlignmentCenter;
	label.textColor = [UIColor whiteColor];
	label.backgroundColor = [UIColor greenColor];
	
	return label;
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	DebugLog(@"Called for row %i", row);
	return [labels objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	return KPComponentWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return KPComponentHeight;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [labels count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (void)dealloc {
    [super dealloc];
	[labels dealloc];
}


@end
