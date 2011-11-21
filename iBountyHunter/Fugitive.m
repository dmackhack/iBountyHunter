//
//  Fugitive.m
//  iBountyHunter
//
//  Created by David Mackenzie on 20/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Fugitive.h"


@implementation Fugitive
@dynamic desc;
@dynamic captured;
@dynamic bounty;
@dynamic captdate;
@dynamic name;
@dynamic fugitiveID;
@dynamic image;
@dynamic capturedLat;
@dynamic capturedLon;

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake([self.capturedLat doubleValue], [self.capturedLon doubleValue]);
}

-(NSString *)title
{
    return self.name;
}

- (NSString *)subtitle
{
    return self.desc;
}

@end
