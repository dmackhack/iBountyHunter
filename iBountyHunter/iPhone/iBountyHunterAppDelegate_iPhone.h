//
//  iBountyHunterAppDelegate_iPhone.h
//  iBountyHunter
//
//  Created by David Mackenzie on 16/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iBountyHunterAppDelegate.h"

@interface iBountyHunterAppDelegate_iPhone : iBountyHunterAppDelegate {
    
    UITabBarController* tabBarController_;
    
}

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
