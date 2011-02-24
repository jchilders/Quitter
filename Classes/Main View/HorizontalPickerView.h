//
//  HorizontalPickerView.h
//  Quitter
//
//  Created by James Childers on 2/22/11.
//  Copyright 2011 Green Bar Consulting, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HorizontalPickerView : UIPickerView <UIPickerViewDelegate, UIPickerViewDataSource> {
	NSArray *labels;
}

- (id)initWithFrame:(CGRect)frame data:(NSArray *)data;

@property (nonatomic, retain) NSArray *labels;

@end
