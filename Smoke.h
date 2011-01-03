//
//  Smoke.h
//  Quitter
//
//  Created by James Childers on 1/2/11.
//  Copyright 2011 Green Bar Consulting, LLC. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Smoke :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSDate * timestamp;

@end



