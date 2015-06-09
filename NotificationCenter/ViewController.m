//
//  ViewController.m
//  NotificationCenter
//
//  Created by Rishabh Jain on 6/9/15.
//  Copyright (c) 2015 Rishabh Jain. All rights reserved.
//
#import "ViewController.h"
#import "CoordinateFinder.h"

@interface ViewController ()

@end

@implementation ViewController

CoordinateFinder *coordinateFinder;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedNotification:)
                                                 name:@"Address Found"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedNotification:)
                                                 name:@"Not Found"
                                               object:nil];
}

- (void)receivedNotification:(NSNotification *) notification {
    if ([[notification name] isEqualToString:@"Address Found"]) {
        [self addAnnotations];
    } else if ([[notification name] isEqualToString:@"Not Found"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Results Found"
                                                            message:nil delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)addAnnotations {
    NSLog(@"Reached annotations: %i", coordinateFinder.mapItems.count);
    int i = 0;
    do {
        MKMapItem *mapItem = [coordinateFinder.mapItems objectAtIndex:i];
        MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
        myAnnotation.coordinate = mapItem.placemark.coordinate;
        myAnnotation.title = mapItem.name;
        myAnnotation.subtitle = mapItem.placemark.title;
        [self.mapView addAnnotation:myAnnotation];
        i++;
    } while (i < coordinateFinder.mapItems.count);
}

- (IBAction)search:(UITextField *)sender {
    MKCoordinateRegion currentRegion = MKCoordinateRegionMake(self.mapView.centerCoordinate, MKCoordinateSpanMake(0.58, 0.58));
    [self.mapView removeAnnotations:self.mapView.annotations];
    coordinateFinder = [[CoordinateFinder alloc] initWithAddressOrPOI:sender.text address:currentRegion];
    NSLog(@"%i", coordinateFinder.mapItems.count);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end