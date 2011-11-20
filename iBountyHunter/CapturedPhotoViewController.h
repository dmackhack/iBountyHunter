//
//  CapturedPhotoViewController.h
//  iBountyHunter
//
//  Created by David MacKenzie on 20/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fugitive.h"

@interface CapturedPhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>
{
    UIImageView* fugitiveImage_;
    Fugitive* fugitive_;
}

@property (nonatomic, retain) IBOutlet UIImageView* fugitiveImage;
@property (nonatomic, retain) Fugitive* fugitive;

- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)takePictureButtonPressed:(id)sender;

@end
