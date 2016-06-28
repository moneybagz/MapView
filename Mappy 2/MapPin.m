//
//  MapPin.m
//  Mappy 2
//
//  Created by Clyfford Millet on 6/28/16.
//  Copyright © 2016 Clyff IOS supercompany. All rights reserved.
//

#import "MapPin.h"

@implementation MapPin
@synthesize coordinate,title,subtitle;

- (id)initWithLocation:(CLLocationCoordinate2D)coord {
    self = [super init];
    if (self) {
        coordinate = coord;
    }
    return self;
}

@end
