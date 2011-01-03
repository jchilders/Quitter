//
//  Smoke.h
//  Quitter
//
//  Created by James Childers on 1/2/11.
//  Copyright 2011 Green Bar Consulting, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Smoke : NSObject {
	NSDate *timestamp;
}

-(id)init;
-(id)initWithDate:(NSDate *)date;

@property (nonatomic, retain) NSDate *timestamp;

@end
