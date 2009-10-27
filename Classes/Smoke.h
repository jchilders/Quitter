//
//  Smoke.h
//  Quitter
//
//  Created by James Childers on 10/23/09.
//  Copyright 2009 Green Bar Consulting, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Smoke : NSObject {
	NSDate *when;
	NSNumber *amount;
}

- (id)init;

- (id)initWithWhen:(NSDate*)newWhen
			amount:(NSNumber *)newAmount;

@property (nonatomic, copy) NSDate *when;
@property (nonatomic, copy) NSNumber *amount;


@end
