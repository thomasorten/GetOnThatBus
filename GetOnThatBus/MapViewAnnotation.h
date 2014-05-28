//
//  MapViewAnnotation.h
//  GetOnThatBus
//
//  Created by Thomas Orten on 5/28/14.
//  Copyright (c) 2014 Orten, Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKPointAnnotation.h>

@interface MapViewAnnotation : MKPointAnnotation

@property(nonatomic, copy) NSString *address;
@property(nonatomic, copy) NSString *routes;
@property(nonatomic, copy) NSString *transfers;

@end
