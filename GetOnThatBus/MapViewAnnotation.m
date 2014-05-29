//
//  MapViewAnnotation.m
//  GetOnThatBus
//
//  Created by Thomas Orten on 5/28/14.
//  Copyright (c) 2014 Orten, Thomas. All rights reserved.
//

#import "MapViewAnnotation.h"

@implementation MapViewAnnotation

- (NSString *)title;
{
    return [self.dictionary objectForKey:@"cta_stop_name"];
}

- (NSString *)subtitle
{
    return [self.dictionary objectForKey:@"routes"];
}

- (CLLocationCoordinate2D)coordinate
{
    double latitude = [[self.dictionary objectForKey:@"latitude"] doubleValue];
    double longitude = -fabs([[self.dictionary objectForKey:@"longitude"] doubleValue]); // Fix issue with bussstop in China
    return CLLocationCoordinate2DMake(latitude, longitude);
}

@end