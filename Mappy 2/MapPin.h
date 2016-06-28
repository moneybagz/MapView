//
//  MapPin.h
//  Mappy 2
//
//  Created by Clyfford Millet on 6/28/16.
//  Copyright © 2016 Clyff IOS supercompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapPin : NSObject <MKAnnotation>
//{
//    CLLocationCoordinate2D coordinate;
//}

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;



@end
