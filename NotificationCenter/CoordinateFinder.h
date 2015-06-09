//
//  CoordinateFinder.h
//  NotificationCenter
//
//  Created by Rishabh Jain on 6/9/15.
//  Copyright (c) 2015 Rishabh Jain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface CoordinateFinder : NSObject

@property (nonatomic, readonly) NSMutableArray *mapItems;

- (id)initWithAddressOrPOI:(NSString *)address address:(MKCoordinateRegion)inRegion;

@end
