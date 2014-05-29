//
//  MapViewAnnotation.h
//  GetOnThatBus
//
//  Created by Thomas Orten on 5/28/14.
//  Copyright (c) 2014 Orten, Thomas. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MapViewAnnotation : NSObject <MKAnnotation>
@property NSDictionary *dictionary;
@end
