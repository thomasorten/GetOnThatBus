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
@property NSString *selectedTitle;
@property NSString *selectedAddress;
@property NSString *selectedRoutes;
@property NSString *selectedTransfers;
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
            stop.title = [busStop objectForKey:@"cta_stop_name"];
            stop.subtitle = [busStop objectForKey:@"routes"];
            stop.address = [busStop objectForKey:@"_address"];
            stop.routes = stop.subtitle;
            stop.transfers = [busStop objectForKey:@"inter_modal"];
                stop.coordinate = CLLocationCoordinate2DMake([[busStop objectForKey:@"latitude"] floatValue], [[busStop objectForKey:@"longitude"] floatValue]);
            [self.mapView addAnnotation:stop];
        }
        CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(41.89373984, -87.63532979);
        MKCoordinateSpan span = MKCoordinateSpanMake(.4, 0.4);
        MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
        [self.mapView setRegion:region animated:YES];
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
    self.selectedTitle = selectedAnnotation.title;
    self.selectedAddress = selectedAnnotation.address;
    self.selectedRoutes = selectedAnnotation.routes;
    self.selectedTransfers = selectedAnnotation.transfers;
    [self performSegueWithIdentifier: @"DetailSegue" sender: self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *nextController = [segue destinationViewController];
    nextController.title = self.selectedTitle;
    nextController.address = self.selectedAddress;
    nextController.routes = self.selectedRoutes;
    nextController.transfers = self.selectedTransfers;
}

@end
