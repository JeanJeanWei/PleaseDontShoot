//
//  SetTimeViewController.h
//  PzDontShoot
//
//  Created by JJ WEI on 12-09-17.
//  Copyright (c) 2012 Ice Whale Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  SetTimeViewController;

@protocol SetTimeViewController

- (void)setTimeViewCOntroller:(SetTimeViewController*)backClicked;

@end

@interface SetTimeViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    //------- view 3
    IBOutlet UIPickerView *picker;
    IBOutlet UILabel *hLabel;
    IBOutlet UILabel *mLabel;
    IBOutlet UILabel *sLabel;
    IBOutlet UIButton *set;
    NSArray *mins;
    NSArray *hours;
    NSTimer *t3;
   // int time;
    int c;
    
    
}

@property (copy) NSArray *mins;
@property (copy) NSArray *hours;

// view 3
-(IBAction) backV2Pressed;
-(void) loadTimer;
-(void) saveTimer;

@end
