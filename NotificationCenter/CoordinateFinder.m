//
//  CoordinateFinder.m
//  NotificationCenter
//
//  Created by Rishabh Jain on 6/9/15.
//  Copyright (c) 2015 Rishabh Jain. All rights reserved.
//

#import "CoordinateFinder.h"

@interface CoordinateFinder ()

@property (readwrite) NSMutableArray *mapItems;

@end

@implementation CoordinateFinder

- (id)initWithAddressOrPOI:(NSString *)address address:(MKCoordinateRegion)inRegion
{
    [self forwardGeocodeAddress:address inRegion:inRegion];
    self = [super init];
    if (self) {
        //
    }
    return self;
}

- (void)forwardGeocodeAddress:(NSString *)address inRegion:(MKCoordinateRegion)inRegion {
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] init];
    self.mapItems = [[NSMutableArray alloc] init];
    searchRequest.naturalLanguageQuery = address;
    searchRequest.region = inRegion;
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (!error) {
            int i = 0;
            do {
                MKMapItem *mapItem = [response.mapItems objectAtIndex:i];
                [self.mapItems addObject:mapItem];
                i++;
            } while (i < response.mapItems.count);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Address Found" object:self];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Not Found" object:self];
        }
    }];
}

@end