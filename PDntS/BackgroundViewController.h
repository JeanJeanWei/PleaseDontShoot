//
//  BackgroundViewController.h
//  PDntS
//
//  Created by JJ WEI on 12-10-08.
//  Copyright (c) 2012 Ice Whale Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackgroundViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>
{
    UIImagePickerController *ipc;
    IBOutlet UIImageView *bgImgView;
    int bgType;
}

- (IBAction)pickImgPressed;
- (IBAction)defaultPressed;
- (IBAction)blankPressed;
- (IBAction)doneClidked;
@end
