//
//  Fugitive.h
//  iBountyHunter
//
//  Created by David MacKenzie on 20/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Fugitive : NSManagedObject

@property (nonatomic, retain) NSNumber * captured;
@property (nonatomic, retain) NSDate * captdate;
@property (nonatomic, retain) NSDecimalNumber * bounty;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * fugitiveID;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSData * image;

@end
