//
//  ViewController.m
//  GetOnThatBus
//
//  Created by Thomas Orten on 5/28/14.
//  Copyright (c) 2014 Orten, Thomas. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSArray *busStops = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError] objectForKey:@"row"];
        for (NSDictionary *busStop in busStops) {
            MKPointAnnotation *stop = [[MKPointAnnotation alloc] init];
            stop.title = [busStop objectForKey:@"cta_stop_name"];
            stop.subtitle = [busStop objectForKey:@"routes"];
                stop.coordinate = CLLocationCoordinate2DMake([[busStop objectForKey:@"latitude"] floatValue], [[busStop objectForKey:@"longitude"] floatValue]);
            [self.mapView addAnnotation:stop];
        }
        CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(41.89373984, -87.63532979);
        MKCoordinateSpan span = MKCoordinateSpanMake(.4, 0.4);
        MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
        [self.mapView setRegion:region animated:YES];
    }];
}

@end
