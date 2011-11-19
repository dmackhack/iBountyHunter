//
//  Fugitive.h
//  iBountyHunter
//
//  Created by David Mackenzie on 20/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Fugitive : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDecimalNumber * bounty;
@property (nonatomic, retain) NSNumber * fugitiveID;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * captured;
@property (nonatomic, retain) NSDate * captdate;

@end
