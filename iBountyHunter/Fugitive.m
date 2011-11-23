//
//  Fugitive.m
//  iBountyHunter
//
//  Created by David MacKenzie on 23/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Fugitive.h"


@implementation Fugitive

@dynamic bounty;
@dynamic capturedLat;
@dynamic captured;
@dynamic capturedLon;
@dynamic image;
@dynamic fugitiveID;
@dynamic captdate;
@dynamic desc;
@dynamic name;
@dynamic lastSeenLat;
@dynamic lastSeenLon;
@dynamic lastSeenDesc;

- (CLLocationCoordinate2D) coordinate 
{
    return CLLocationCoordinate2DMake([self.capturedLat doubleValue], [self.capturedLon doubleValue]);
}

- (NSString *) title 
{
    return self.name;
}

- (NSString *) subtitle 
{
    return self.desc;
}

@end
