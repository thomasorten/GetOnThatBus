//
//  ViewController.m
//  GetOnThatBus
//
//  Created by Thomas Orten on 5/28/14.
//  Copyright (c) 2014 Orten, Thomas. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import <MapKit/MapKit.h>
#import "MapViewAnnotation.h"

@interface ViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property NSArray *busStops;
@property NSDictionary *selectedStop;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.busStops = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError] objectForKey:@"row"];
        for (NSDictionary *busStop in self.busStops) {
            MapViewAnnotation *stop = [[MapViewAnnotation alloc] init];
            stop.dictionary = busStop;
            [self.mapView addAnnotation:stop];
        }
        [self.mapView showAnnotations:self.mapView.annotations animated:YES];
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(MapViewAnnotation *)annotation
{
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    pin.canShowCallout = YES;
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return pin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    MapViewAnnotation *selectedAnnotation = (MapViewAnnotation *)view.annotation;
    self.selectedStop = selectedAnnotation.dictionary;
    [self performSegueWithIdentifier: @"DetailSegue" sender: self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *nextController = [segue destinationViewController];
    nextController.title = [self.selectedStop objectForKey:@"cta_stop_name"];
    nextController.stop = self.selectedStop;
}

@end
