//
//  Fugitive.h
//  iBountyHunter
//
//  Created by David MacKenzie on 23/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>

@interface Fugitive : NSManagedObject <MKAnnotation>

@property (nonatomic, retain) NSDecimalNumber * bounty;
@property (nonatomic, retain) NSNumber * capturedLat;
@property (nonatomic, retain) NSNumber * captured;
@property (nonatomic, retain) NSNumber * capturedLon;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSNumber * fugitiveID;
@property (nonatomic, retain) NSDate * captdate;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * lastSeenLat;
@property (nonatomic, retain) NSNumber * lastSeenLon;
@property (nonatomic, retain) NSNumber * lastSeenDesc;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (NSString *) title;
- (NSString *) subtitle;

@end
