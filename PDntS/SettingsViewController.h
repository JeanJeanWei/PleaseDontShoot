//
//  SettingsViewController.h
//  PzDontShoot
//
//  Created by Jean-Jean Wei on 12-09-18.
//
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
{
    //-------- view 2
    IBOutlet UIButton *setUptimer;
    IBOutlet UIButton *tab;
    IBOutlet UIButton *s0;
    IBOutlet UIButton *s1;
    IBOutlet UIButton *m0;
    IBOutlet UIButton *m1;
    IBOutlet UIButton *h0;
    IBOutlet UIButton *h1;
    
    IBOutlet UIButton *d0;
    IBOutlet UIButton *d1;
    IBOutlet UIButton *d2;
    IBOutlet UIButton *vb0;
    IBOutlet UIButton *vb1;

    NSTimer *t4;
    int c4;
    int v;
    int d;
}

// view 2
- (IBAction)goV3Pressed;
- (IBAction)backPressed;


- (IBAction)d0Pressed;
- (IBAction)d1Pressed;
- (IBAction)d2Pressed;
- (void)clearCD;

- (IBAction)vi0Pressed;
- (IBAction)vi1Pressed;
- (void)clearVib;

- (IBAction)moreApps;
- (IBAction)infoPressed;

- (void)loadSettings;
- (void)saveSettings;

@end
